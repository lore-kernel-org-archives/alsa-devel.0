From: "Pamela K. Clift" <pclift@pianodisc.com>
Subject: adding volume to raw-midi device
Date: Tue, 26 Sep 2006 15:03:30 -0700
Message-ID: <DB99F0250CDF5F438C525F4695C888DC154511@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I am new to alsa and I am trying to write a raw-midi device driver.  When I tried to add the volume control I could not compile the file anymore.  I am hoping someone can help me and see what I am missing.  I have looked in the Writing an Alsa Driver chapter 6 and I have looked at dummy.c .  I believe I am following what they say to do but when I compile the file I get many errors including "warning: "struct snd_ctl_elem_info declared inside parameter list"   I have at the top of my file #include <sound/control.h> along with the other includes I see in the sample files.  Below is the code I added.

static int snd_ld_volume_info(struct snd_kcontrol *kcontrol,
                 struct snd_ctl_elem_info *uinfo)
{
    uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
    uinfo->count = 1;
    uinfo->value.integer.min = 0;
    uinfo->value.integer.max = 127;
    return 0;
}
 
static int snd_ld_volume_get(struct snd_kcontrol *kcontrol,
                struct snd_ctl_elem_value *ucontrol)
{
    struct snd_card_ld *ld = snd_kcontrol_chip(kcontrol);
    int addr = kcontrol->private_value;

    spin_lock_irq(&ld->mixer_lock);
    ucontrol->value.integer.value[0] = ld->mixer_volume[addr];
    spin_unlock_irq(&ld->mixer_lock);
    return 0;
}

static int snd_ld_volume_put(struct snd_kcontrol *kcontrol,
                struct snd_ctl_elem_value *ucontrol)
{
    struct snd_card_ld *ld = snd_kcontrol_chip(kcontrol);
    int changed = 0, addr = kcontrol->private_value;
    int value;

    value = ucontrol->value.integer.value[0];
    if (value < 0)
        value = 0;
    if (value > 127)
        value = 127;
    spin_lock_irq(&ld->mixer_lock);
    changed = ld->mixer_volume[addr] != value;
    ld->mixer_volume[addr] = value;
    spin_unlock_irq(&ld->mixer_lock);
    return changed;
}

static struct snd_kcontrol_new snd_ld_volume = {
  .iface = SNDRV_CTL_ELEM_IFACE_MIXER, 
  .name = "Master Playback Volume", 
  .index = 0,
  .info = snd_ld_volume_info,
  .get = snd_ld_volume_get, 
  .put = snd_ld_volume_put,
  .private_value = addr
};

static int __init snd_card_ld_new_mixer(struct snd_card_ld *ld)
{
  struct snd_card *card = ld->card;
  int err;

  snd_assert(ld != NULL, return -EINVAL);
  spin_lock_init(&ld->mixer_lock);
  strcpy(card->mixername, "LD Mixer");

  if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_ld_volume, ld)))
                                                                   < 0)
    return err;
  return 0;
}


static int __init snd_card_ld_probe(int dev)
{
  snd_card_t *card;
  struct snd_card_ld *ld;
  int err;

(many things, deleted here since I believe not relevent to problem)

  /* add mixer volume */
  if ((err = snd_card_ld_new_mixer(ld)) < 0)
    return err;

 






-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
