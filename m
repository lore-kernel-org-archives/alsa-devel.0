From: "Sam Revitch" <sam.revitch@gmail.com>
Subject: Re: stateful reconnect with snd-usb-audio
Date: Sat, 17 Jun 2006 01:23:23 -0700
Message-ID: <8d4807d50606170123k51bf2db5ma673b071c8e18d4b@mail.gmail.com>
References: <8d4807d50606121405n51edef2au3de163b01029aaf5@mail.gmail.com>
	<Pine.LNX.4.61.0606141330280.10637@tm8103.perex-int.cz>
	<s5hy7w07wvx.wl%tiwai@suse.de> <s5hr71r97rz.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606141543260.10637@tm8103.perex-int.cz>
	<s5hodwv961d.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606141645450.10637@tm8103.perex-int.cz>
	<8d4807d50606141020w8e29a50t6b97528d7e82a0c5@mail.gmail.com>
	<8d4807d50606150304o5ae2ccd0xf7af2f4ccf38ec4c@mail.gmail.com>
	<s5hver1777i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_61672_19299451.1150532603583"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hver1777i.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

------=_Part_61672_19299451.1150532603583
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/16/06, Takashi Iwai <tiwai@suse.de> wrote:
> The patch looks fine to me (as I also wanted to implement the same
> stuff right now :)  Did you check whether it works with usb-audio
> actually?
>
> If it's confirmed to work, we can commit it together with the changes
> for other components.  Then snd_card_free_in_thread() should be
> replaced with snd_card_free_when_closed().

Apparently the last patch had some problems tearing down the
/proc/asound/cardX/pcmYZ entries at disconnect time.  The attached one
should fix that.  The original one was developed on the driver bundled
with a recent -mm kernel that didn't seem to create those entries.
Anyway, it seems to work as advertised with the usb-audio driver, at
least in my configuration.  The whole /proc/asound/cardX tree goes
away immediately when the card is unplugged without hanging khubd, and
with an old handle held open, playback seems to work through the new
device instance on the same slot when the card is plugged back in.

Now, there has got to be some way to make usb-audio retain its
snd_card structure at disconnect time.  Perhaps it could optionally
leave things hanging for some period of time before calling
snd_card_disconnect(), leaving a window for the same device to be
reconnected...?  Does this sound too kludgy?

Thanks..
-Sam Revitch

------=_Part_61672_19299451.1150532603583
Content-Type: text/x-patch; name=snd-disconnect.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_eojp2w5g
Content-Disposition: attachment; filename="snd-disconnect.patch"

diff -r 08577d0b45ef core/control.c
--- a/core/control.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/control.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -1375,6 +1375,11 @@ static int snd_ctl_dev_disconnect(struct
 =09struct snd_card *card =3D device->device_data;
 =09struct list_head *flist;
 =09struct snd_ctl_file *ctl;
+=09int err, cardnum;
+
+=09snd_assert(card !=3D NULL, return -ENXIO);
+=09cardnum =3D card->number;
+=09snd_assert(cardnum >=3D 0 && cardnum < SNDRV_CARDS, return -ENXIO);
=20
 =09down_read(&card->controls_rwsem);
 =09list_for_each(flist, &card->ctl_files) {
@@ -1383,6 +1388,10 @@ static int snd_ctl_dev_disconnect(struct
 =09=09kill_fasync(&ctl->fasync, SIGIO, POLL_ERR);
 =09}
 =09up_read(&card->controls_rwsem);
+
+=09if ((err =3D snd_unregister_device(SNDRV_DEVICE_TYPE_CONTROL,
+=09=09=09=09=09 card, -1)) < 0)
+=09=09return err;
 =09return 0;
 }
=20
@@ -1408,15 +1417,8 @@ static int snd_ctl_dev_free(struct snd_d
  */
 static int snd_ctl_dev_unregister(struct snd_device *device)
 {
-=09struct snd_card *card =3D device->device_data;
-=09int err, cardnum;
-
-=09snd_assert(card !=3D NULL, return -ENXIO);
-=09cardnum =3D card->number;
-=09snd_assert(cardnum >=3D 0 && cardnum < SNDRV_CARDS, return -ENXIO);
-=09if ((err =3D snd_unregister_device(SNDRV_DEVICE_TYPE_CONTROL,
-=09=09=09=09=09 card, -1)) < 0)
-=09=09return err;
+=09if (device->state =3D=3D SNDRV_DEV_REGISTERED)
+=09=09(void) snd_ctl_dev_disconnect(device);
 =09return snd_ctl_dev_free(device);
 }
=20
diff -r 08577d0b45ef core/hwdep.c
--- a/core/hwdep.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/hwdep.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -42,6 +42,7 @@ static int snd_hwdep_free(struct snd_hwd
 static int snd_hwdep_free(struct snd_hwdep *hwdep);
 static int snd_hwdep_dev_free(struct snd_device *device);
 static int snd_hwdep_dev_register(struct snd_device *device);
+static int snd_hwdep_dev_disconnect(struct snd_device *device);
 static int snd_hwdep_dev_unregister(struct snd_device *device);
=20
=20
@@ -353,6 +354,7 @@ int snd_hwdep_new(struct snd_card *card,
 =09static struct snd_device_ops ops =3D {
 =09=09.dev_free =3D snd_hwdep_dev_free,
 =09=09.dev_register =3D snd_hwdep_dev_register,
+=09=09.dev_disconnect =3D snd_hwdep_dev_disconnect,
 =09=09.dev_unregister =3D snd_hwdep_dev_unregister
 =09};
=20
@@ -439,7 +441,7 @@ static int snd_hwdep_dev_register(struct
 =09return 0;
 }
=20
-static int snd_hwdep_dev_unregister(struct snd_device *device)
+static int snd_hwdep_dev_disconnect(struct snd_device *device)
 {
 =09struct snd_hwdep *hwdep =3D device->device_data;
=20
@@ -454,8 +456,16 @@ static int snd_hwdep_dev_unregister(stru
 =09=09snd_unregister_oss_device(hwdep->oss_type, hwdep->card, hwdep->devic=
e);
 #endif
 =09snd_unregister_device(SNDRV_DEVICE_TYPE_HWDEP, hwdep->card, hwdep->devi=
ce);
-=09list_del(&hwdep->list);
+=09list_del_init(&hwdep->list);
 =09mutex_unlock(&register_mutex);
+=09return 0;
+}
+
+static int snd_hwdep_dev_unregister(struct snd_device *device)
+{
+=09struct snd_hwdep *hwdep =3D device->device_data;
+=09snd_assert(hwdep !=3D NULL, return -ENXIO);
+=09(void) snd_hwdep_dev_disconnect(device);
 =09return snd_hwdep_free(hwdep);
 }
=20
diff -r 08577d0b45ef core/info.c
--- a/core/info.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/info.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -820,6 +820,23 @@ struct snd_info_entry *snd_info_create_c
=20
 EXPORT_SYMBOL(snd_info_create_card_entry);
=20
+int snd_info_disconnect(struct snd_info_entry *entry)
+{
+=09struct proc_dir_entry *root;
+=09if (!entry->disconnected) {
+=09=09snd_assert(entry->p !=3D NULL, return -ENXIO);
+=09=09root =3D entry->parent =3D=3D NULL ? snd_proc_root : entry->parent->=
p;
+=09=09snd_assert(root, return -ENXIO);
+=09=09mutex_lock(&info_mutex);
+=09=09snd_remove_proc_entry(root, entry->p);
+=09=09mutex_unlock(&info_mutex);
+=09=09entry->disconnected =3D 1;
+=09}
+=09return 0;
+}
+
+EXPORT_SYMBOL(snd_info_disconnect);
+
 static int snd_info_dev_free_entry(struct snd_device *device)
 {
 =09struct snd_info_entry *entry =3D device->device_data;
@@ -836,8 +853,7 @@ static int snd_info_dev_disconnect_entry
 static int snd_info_dev_disconnect_entry(struct snd_device *device)
 {
 =09struct snd_info_entry *entry =3D device->device_data;
-=09entry->disconnected =3D 1;
-=09return 0;
+=09return snd_info_disconnect(entry);
 }
=20
 static int snd_info_dev_unregister_entry(struct snd_device *device)
@@ -952,16 +968,9 @@ EXPORT_SYMBOL(snd_info_register);
  */
 int snd_info_unregister(struct snd_info_entry * entry)
 {
-=09struct proc_dir_entry *root;
-
 =09if (! entry)
 =09=09return 0;
-=09snd_assert(entry->p !=3D NULL, return -ENXIO);
-=09root =3D entry->parent =3D=3D NULL ? snd_proc_root : entry->parent->p;
-=09snd_assert(root, return -ENXIO);
-=09mutex_lock(&info_mutex);
-=09snd_remove_proc_entry(root, entry->p);
-=09mutex_unlock(&info_mutex);
+=09(void) snd_info_disconnect(entry);
 =09snd_info_free_entry(entry);
 =09return 0;
 }
diff -r 08577d0b45ef core/init.c
--- a/core/init.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/init.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -310,70 +310,104 @@ int snd_card_disconnect(struct snd_card=20
 =09if (err < 0)
 =09=09snd_printk(KERN_ERR "not all devices for card %i can be disconnected=
\n", card->number);
=20
-=09return 0;=09
-}
-
-EXPORT_SYMBOL(snd_card_disconnect);
-
-/**
- *  snd_card_free - frees given soundcard structure
- *  @card: soundcard structure
- *
- *  This function releases the soundcard structure and the all assigned
- *  devices automatically.  That is, you don't have to release the devices
- *  by yourself.
- *
- *  Returns zero. Frees all associated devices and frees the control
- *  interface associated to given soundcard.
- */
-int snd_card_free(struct snd_card *card)
-{
-=09struct snd_shutdown_f_ops *s_f_ops;
-
-=09if (card =3D=3D NULL)
-=09=09return -EINVAL;
-=09mutex_lock(&snd_card_mutex);
-=09snd_cards[card->number] =3D NULL;
-=09mutex_unlock(&snd_card_mutex);
-
-#ifdef CONFIG_PM
-=09wake_up(&card->power_sleep);
-#endif
-=09/* wait, until all devices are ready for the free operation */
-=09wait_event(card->shutdown_sleep, card->files =3D=3D NULL);
-
-#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
-=09if (snd_mixer_oss_notify_callback)
-=09=09snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
-#endif
-=09if (snd_device_free_all(card, SNDRV_DEV_CMD_PRE) < 0) {
-=09=09snd_printk(KERN_ERR "unable to free all devices (pre)\n");
-=09=09/* Fatal, but this situation should never occur */
-=09}
-=09if (snd_device_free_all(card, SNDRV_DEV_CMD_NORMAL) < 0) {
-=09=09snd_printk(KERN_ERR "unable to free all devices (normal)\n");
-=09=09/* Fatal, but this situation should never occur */
-=09}
-=09if (snd_device_free_all(card, SNDRV_DEV_CMD_POST) < 0) {
-=09=09snd_printk(KERN_ERR "unable to free all devices (post)\n");
-=09=09/* Fatal, but this situation should never occur */
-=09}
-=09if (card->private_free)
-=09=09card->private_free(card);
 =09snd_info_unregister(card->proc_id);
 =09if (snd_info_card_free(card) < 0) {
 =09=09snd_printk(KERN_WARNING "unable to free card info\n");
 =09=09/* Not fatal error */
 =09}
+
+=09return 0;=09
+}
+
+EXPORT_SYMBOL(snd_card_disconnect);
+
+/**
+ *  snd_card_free - frees given soundcard structure
+ *  @card: soundcard structure
+ *
+ *  This function releases the soundcard structure and the all assigned
+ *  devices automatically.  That is, you don't have to release the devices
+ *  by yourself.
+ *
+ *  Returns zero. Frees all associated devices and frees the control
+ *  interface associated to given soundcard.
+ */
+static int snd_card_do_free(struct snd_card *card)
+{
+=09struct snd_shutdown_f_ops *s_f_ops;
+
+#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
+=09if (snd_mixer_oss_notify_callback)
+=09=09snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
+#endif
+=09if (snd_device_free_all(card, SNDRV_DEV_CMD_PRE) < 0) {
+=09=09snd_printk(KERN_ERR "unable to free all devices (pre)\n");
+=09=09/* Fatal, but this situation should never occur */
+=09}
+=09if (snd_device_free_all(card, SNDRV_DEV_CMD_NORMAL) < 0) {
+=09=09snd_printk(KERN_ERR "unable to free all devices (normal)\n");
+=09=09/* Fatal, but this situation should never occur */
+=09}
+=09if (snd_device_free_all(card, SNDRV_DEV_CMD_POST) < 0) {
+=09=09snd_printk(KERN_ERR "unable to free all devices (post)\n");
+=09=09/* Fatal, but this situation should never occur */
+=09}
+=09if (card->private_free)
+=09=09card->private_free(card);
 =09while (card->s_f_ops) {
 =09=09s_f_ops =3D card->s_f_ops;
 =09=09card->s_f_ops =3D s_f_ops->next;
 =09=09kfree(s_f_ops);
 =09}
+=09kfree(card);
+=09return 0;
+}
+
+static int snd_card_free_prepare(struct snd_card *card)
+{
+=09if (card =3D=3D NULL)
+=09=09return -EINVAL;
+=09(void) snd_card_disconnect(card);
 =09mutex_lock(&snd_card_mutex);
+=09snd_cards[card->number] =3D NULL;
 =09snd_cards_lock &=3D ~(1 << card->number);
 =09mutex_unlock(&snd_card_mutex);
-=09kfree(card);
+#ifdef CONFIG_PM
+=09wake_up(&card->power_sleep);
+#endif
+=09return 0;
+}
+
+int snd_card_free_when_closed(struct snd_card *card)
+{
+=09int free_now =3D 0;
+=09int ret =3D snd_card_free_prepare(card);
+=09if (ret)
+=09=09return ret;
+
+=09spin_lock(&card->files_lock);
+=09if (card->files =3D=3D NULL)
+=09=09free_now =3D 1;
+=09else
+=09=09card->free_on_last_close =3D 1;
+=09spin_unlock(&card->files_lock);
+
+=09if (free_now)
+=09=09snd_card_do_free(card);
+=09return 0;
+}
+
+EXPORT_SYMBOL(snd_card_free_when_closed);
+
+int snd_card_free(struct snd_card *card)
+{
+=09int ret =3D snd_card_free_prepare(card);
+=09if (ret)
+=09=09return ret;
+
+=09/* wait, until all devices are ready for the free operation */
+=09wait_event(card->shutdown_sleep, card->files =3D=3D NULL);
+=09snd_card_do_free(card);
 =09return 0;
 }
=20
@@ -717,6 +751,7 @@ int snd_card_file_remove(struct snd_card
 int snd_card_file_remove(struct snd_card *card, struct file *file)
 {
 =09struct snd_monitor_file *mfile, *pfile =3D NULL;
+=09int last_close =3D 0;
=20
 =09spin_lock(&card->files_lock);
 =09mfile =3D card->files;
@@ -731,9 +766,14 @@ int snd_card_file_remove(struct snd_card
 =09=09pfile =3D mfile;
 =09=09mfile =3D mfile->next;
 =09}
+=09if (card->files =3D=3D NULL)
+=09=09last_close =3D 1;
 =09spin_unlock(&card->files_lock);
-=09if (card->files =3D=3D NULL)
+=09if (last_close) {
 =09=09wake_up(&card->shutdown_sleep);
+=09=09if (card->free_on_last_close)
+=09=09=09snd_card_do_free(card);
+=09}
 =09if (!mfile) {
 =09=09snd_printk(KERN_ERR "ALSA card file remove problem (%p)\n", file);
 =09=09return -ENOENT;
diff -r 08577d0b45ef core/oss/mixer_oss.c
--- a/core/oss/mixer_oss.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/oss/mixer_oss.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -1313,22 +1313,20 @@ static int snd_mixer_oss_notify_handler(
 =09=09card->mixer_oss =3D mixer;
 =09=09snd_mixer_oss_build(mixer);
 =09=09snd_mixer_oss_proc_init(mixer);
-=09} else if (cmd =3D=3D SND_MIXER_OSS_NOTIFY_DISCONNECT) {
-=09=09mixer =3D card->mixer_oss;
-=09=09if (mixer =3D=3D NULL || !mixer->oss_dev_alloc)
-=09=09=09return 0;
-=09=09snd_unregister_oss_device(SNDRV_OSS_DEVICE_TYPE_MIXER, mixer->card, =
0);
-=09=09mixer->oss_dev_alloc =3D 0;
-=09} else {=09=09/* free */
+=09} else {
 =09=09mixer =3D card->mixer_oss;
 =09=09if (mixer =3D=3D NULL)
 =09=09=09return 0;
+=09=09if (mixer->oss_dev_alloc) {
 #ifdef SNDRV_OSS_INFO_DEV_MIXERS
-=09=09snd_oss_info_unregister(SNDRV_OSS_INFO_DEV_MIXERS, mixer->card->numb=
er);
+=09=09=09snd_oss_info_unregister(SNDRV_OSS_INFO_DEV_MIXERS, mixer->card->n=
umber);
 #endif
-=09=09if (mixer->oss_dev_alloc)
 =09=09=09snd_unregister_oss_device(SNDRV_OSS_DEVICE_TYPE_MIXER, mixer->car=
d, 0);
-=09=09snd_mixer_oss_proc_done(mixer);
+=09=09=09snd_mixer_oss_proc_done(mixer);
+=09=09=09mixer->oss_dev_alloc =3D 0;
+=09=09}
+=09=09if (cmd =3D=3D SND_MIXER_OSS_NOTIFY_DISCONNECT)
+=09=09=09return 0;
 =09=09return snd_mixer_oss_free1(mixer);
 =09}
 =09return 0;
diff -r 08577d0b45ef core/oss/pcm_oss.c
--- a/core/oss/pcm_oss.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/oss/pcm_oss.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -2929,14 +2929,6 @@ static int snd_pcm_oss_disconnect_minor(
 =09=09=09snd_unregister_oss_device(SNDRV_OSS_DEVICE_TYPE_PCM,
 =09=09=09=09=09=09  pcm->card, 1);
 =09=09}
-=09}
-=09return 0;
-}
-
-static int snd_pcm_oss_unregister_minor(struct snd_pcm *pcm)
-{
-=09snd_pcm_oss_disconnect_minor(pcm);
-=09if (pcm->oss.reg) {
 =09=09if (dsp_map[pcm->card->number] =3D=3D (int)pcm->device) {
 #ifdef SNDRV_OSS_INFO_DEV_AUDIO
 =09=09=09snd_oss_info_unregister(SNDRV_OSS_INFO_DEV_AUDIO, pcm->card->numb=
er);
@@ -2945,6 +2937,12 @@ static int snd_pcm_oss_unregister_minor(
 =09=09pcm->oss.reg =3D 0;
 =09=09snd_pcm_oss_proc_done(pcm);
 =09}
+=09return 0;
+}
+
+static int snd_pcm_oss_unregister_minor(struct snd_pcm *pcm)
+{
+=09snd_pcm_oss_disconnect_minor(pcm);
 =09return 0;
 }
=20
diff -r 08577d0b45ef core/pcm.c
--- a/core/pcm.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/pcm.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -491,6 +491,18 @@ static int snd_pcm_stream_proc_init(stru
 =09return 0;
 }
=20
+static void snd_pcm_stream_proc_disconnect(struct snd_pcm_str *pstr)
+{
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
+=09if (pstr->proc_xrun_debug_entry)
+=09=09snd_info_disconnect(pstr->proc_xrun_debug_entry);
+#endif
+=09if (pstr->proc_info_entry)
+=09=09snd_info_disconnect(pstr->proc_info_entry);
+=09if (pstr->proc_root)
+=09=09snd_info_disconnect(pstr->proc_root);
+}
+
 static int snd_pcm_stream_proc_done(struct snd_pcm_str *pstr)
 {
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
@@ -569,6 +581,24 @@ static int snd_pcm_substream_proc_init(s
 =09substream->proc_status_entry =3D entry;
=20
 =09return 0;
+}
+
+/* Non-exported utility function defined in pcm_memory.c */
+extern void snd_pcm_lib_disconnect(struct snd_pcm_substream *);
+
+static void snd_pcm_substream_proc_disconnect(struct snd_pcm_substream *su=
bstream)
+{
+=09snd_pcm_lib_disconnect(substream);
+=09if (substream->proc_info_entry)
+=09=09snd_info_disconnect(substream->proc_info_entry);
+=09if (substream->proc_hw_params_entry)
+=09=09snd_info_disconnect(substream->proc_hw_params_entry);
+=09if (substream->proc_sw_params_entry)
+=09=09snd_info_disconnect(substream->proc_sw_params_entry);
+=09if (substream->proc_status_entry)
+=09=09snd_info_disconnect(substream->proc_status_entry);
+=09if (substream->proc_root)
+=09=09snd_info_disconnect(substream->proc_root);
 }
 =09=09
 static int snd_pcm_substream_proc_done(struct snd_pcm_substream *substream=
)
@@ -968,40 +998,34 @@ static int snd_pcm_dev_register(struct s
 =09return 0;
 }
=20
-static int snd_pcm_dev_disconnect(struct snd_device *device)
-{
-=09struct snd_pcm *pcm =3D device->device_data;
+static int snd_pcm_do_disconnect(struct snd_pcm *pcm, int notify)
+{
 =09struct list_head *list;
 =09struct snd_pcm_substream *substream;
-=09int cidx;
-
-=09mutex_lock(&register_mutex);
+=09int cidx, devtype;
+
+=09if (list_empty(&pcm->list))
+=09=09return 0;
+
 =09list_del_init(&pcm->list);
 =09for (cidx =3D 0; cidx < 2; cidx++)
 =09=09for (substream =3D pcm->streams[cidx].substream; substream; substrea=
m =3D substream->next)
 =09=09=09if (substream->runtime)
 =09=09=09=09substream->runtime->status->state =3D SNDRV_PCM_STATE_DISCONNE=
CTED;
-=09list_for_each(list, &snd_pcm_notify_list) {
-=09=09struct snd_pcm_notify *notify;
-=09=09notify =3D list_entry(list, struct snd_pcm_notify, list);
-=09=09notify->n_disconnect(pcm);
-=09}
-=09mutex_unlock(&register_mutex);
-=09return 0;
-}
-
-static int snd_pcm_dev_unregister(struct snd_device *device)
-{
-=09int cidx, devtype;
-=09struct snd_pcm_substream *substream;
-=09struct list_head *list;
-=09struct snd_pcm *pcm =3D device->device_data;
-
-=09snd_assert(pcm !=3D NULL, return -ENXIO);
-=09mutex_lock(&register_mutex);
-=09list_del(&pcm->list);
+=09if (notify) {
+=09=09list_for_each(list, &snd_pcm_notify_list) {
+=09=09=09struct snd_pcm_notify *notify;
+=09=09=09notify =3D list_entry(list, struct snd_pcm_notify, list);
+=09=09=09notify->n_disconnect(pcm);
+=09=09}
+=09}
 =09for (cidx =3D 0; cidx < 2; cidx++) {
+=09=09struct snd_pcm_str *pstr =3D &pcm->streams[cidx];
+=09=09int err;
 =09=09devtype =3D -1;
+=09=09for (substream =3D pstr->substream; substream; substream =3D substre=
am->next)
+=09=09=09snd_pcm_substream_proc_disconnect(substream);
+=09=09snd_pcm_stream_proc_disconnect(pstr);
 =09=09switch (cidx) {
 =09=09case SNDRV_PCM_STREAM_PLAYBACK:
 =09=09=09devtype =3D SNDRV_DEVICE_TYPE_PCM_PLAYBACK;
@@ -1010,10 +1034,38 @@ static int snd_pcm_dev_unregister(struct
 =09=09=09devtype =3D SNDRV_DEVICE_TYPE_PCM_CAPTURE;
 =09=09=09break;
 =09=09}
-=09=09snd_unregister_device(devtype, pcm->card, pcm->device);
+=09=09err =3D snd_unregister_device(devtype, pcm->card, pcm->device);
+=09=09if (err < 0)
+=09=09=09snd_printk(KERN_ERR "snd_unregister_device %d/%d =3D %i\n",
+=09=09=09=09=09pcm->card->number, devtype, err);
+=09}
+=09return 0;
+}
+
+static int snd_pcm_dev_disconnect(struct snd_device *device)
+{
+=09struct snd_pcm *pcm =3D device->device_data;
+=09int err =3D 0;
+
+=09mutex_lock(&register_mutex);
+=09err =3D snd_pcm_do_disconnect(pcm, 1);
+=09mutex_unlock(&register_mutex);
+=09return err;
+}
+
+static int snd_pcm_dev_unregister(struct snd_device *device)
+{
+=09int cidx;
+=09struct snd_pcm_substream *substream;
+=09struct list_head *list;
+=09struct snd_pcm *pcm =3D device->device_data;
+
+=09snd_assert(pcm !=3D NULL, return -ENXIO);
+=09mutex_lock(&register_mutex);
+=09snd_pcm_do_disconnect(pcm, 0);
+=09for (cidx =3D 0; cidx < 2; cidx++)
 =09=09for (substream =3D pcm->streams[cidx].substream; substream; substrea=
m =3D substream->next)
 =09=09=09snd_pcm_timer_done(substream);
-=09}
 =09list_for_each(list, &snd_pcm_notify_list) {
 =09=09struct snd_pcm_notify *notify;
 =09=09notify =3D list_entry(list, struct snd_pcm_notify, list);
diff -r 08577d0b45ef core/pcm_memory.c
--- a/core/pcm_memory.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/pcm_memory.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -255,6 +255,16 @@ int snd_pcm_lib_preallocate_pages(struct
=20
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_pages);
=20
+
+void snd_pcm_lib_disconnect(struct snd_pcm_substream *substream)
+{
+#ifdef CONFIG_SND_VERBOSE_PROCFS
+=09if (substream->proc_prealloc_entry)
+=09=09snd_info_disconnect(substream->proc_prealloc_entry);
+#endif
+}
+
+
 /**
  * snd_pcm_lib_preallocate_pages_for_all - pre-allocation for continous me=
mory type (all substreams)
  * @pcm: the pcm instance
diff -r 08577d0b45ef core/timer.c
--- a/core/timer.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/core/timer.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -88,6 +88,7 @@ static int snd_timer_free(struct snd_tim
 static int snd_timer_free(struct snd_timer *timer);
 static int snd_timer_dev_free(struct snd_device *device);
 static int snd_timer_dev_register(struct snd_device *device);
+static int snd_timer_dev_disconnect(struct snd_device *device);
 static int snd_timer_dev_unregister(struct snd_device *device);
=20
 static void snd_timer_reschedule(struct snd_timer * timer, unsigned long t=
icks_left);
@@ -772,6 +773,7 @@ int snd_timer_new(struct snd_card *card,
 =09static struct snd_device_ops ops =3D {
 =09=09.dev_free =3D snd_timer_dev_free,
 =09=09.dev_register =3D snd_timer_dev_register,
+=09=09.dev_disconnect =3D snd_timer_dev_disconnect,
 =09=09.dev_unregister =3D snd_timer_dev_unregister
 =09};
=20
@@ -884,6 +886,15 @@ static int snd_timer_unregister(struct s
 =09list_del(&timer->device_list);
 =09mutex_unlock(&register_mutex);
 =09return snd_timer_free(timer);
+}
+
+static int snd_timer_dev_disconnect(struct snd_device *device)
+{
+=09struct snd_timer *timer =3D device->device_data;
+=09mutex_lock(&register_mutex);
+=09list_del_init(&timer->device_list);
+=09mutex_unlock(&register_mutex);
+=09return 0;
 }
=20
 static int snd_timer_dev_unregister(struct snd_device *device)
diff -r 08577d0b45ef include/core.h
--- a/include/core.h=09Tue Jun 13 12:01:14 2006 +0200
+++ b/include/core.h=09Sat Jun 17 01:12:46 2006 -0700
@@ -131,6 +131,7 @@ struct snd_card {
 =09=09=09=09=09=09=09=09state */
 =09spinlock_t files_lock;=09=09/* lock the files for this card */
 =09int shutdown;=09=09=09/* this card is going down */
+=09int free_on_last_close;=09=09/* free in context of file_release */
 =09wait_queue_head_t shutdown_sleep;
 =09struct work_struct free_workq;=09/* for free in workqueue */
 =09struct device *dev;
@@ -246,6 +247,7 @@ struct snd_card *snd_card_new(int idx, c
 =09=09=09 struct module *module, int extra_size);
 int snd_card_disconnect(struct snd_card *card);
 int snd_card_free(struct snd_card *card);
+int snd_card_free_when_closed(struct snd_card *card);
 int snd_card_free_in_thread(struct snd_card *card);
 int snd_card_register(struct snd_card *card);
 int snd_card_info_init(void);
diff -r 08577d0b45ef include/info.h
--- a/include/info.h=09Tue Jun 13 12:01:14 2006 +0200
+++ b/include/info.h=09Sat Jun 17 01:12:46 2006 -0700
@@ -123,6 +123,7 @@ int snd_info_card_register(struct snd_ca
 int snd_info_card_register(struct snd_card * card);
 int snd_info_card_free(struct snd_card * card);
 int snd_info_register(struct snd_info_entry * entry);
+int snd_info_disconnect(struct snd_info_entry * entry);
 int snd_info_unregister(struct snd_info_entry * entry);
=20
 /* for card drivers */
diff -r 08577d0b45ef usb/usbaudio.c
--- a/usb/usbaudio.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/usb/usbaudio.c=09Sat Jun 17 01:12:46 2006 -0700
@@ -3469,7 +3469,7 @@ static void snd_usb_audio_disconnect(str
 =09=09}
 =09=09usb_chip[chip->index] =3D NULL;
 =09=09mutex_unlock(&register_mutex);
-=09=09snd_card_free(card);
+=09=09snd_card_free_when_closed(card);
 =09} else {
 =09=09mutex_unlock(&register_mutex);
 =09}


------=_Part_61672_19299451.1150532603583
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_61672_19299451.1150532603583
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_61672_19299451.1150532603583--
