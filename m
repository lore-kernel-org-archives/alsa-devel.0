From: Jaime Lopez <jsollano@gmail.com>
Subject: Re: Re: [PATCH] Add mixer controls to intel8x0m
Date: Wed, 23 Feb 2005 09:41:22 -0600
Message-ID: <977226cd050223074138d1e0b2@mail.gmail.com>
References: <977226cd05022215084074718@mail.gmail.com>
	 <977226cd05022215142133ecc4@mail.gmail.com>
	 <s5hy8dfshlm.wl@alsa2.suse.de>
Reply-To: Jaime Lopez <jsollano@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_441_17446649.1109173282690"
In-Reply-To: <s5hy8dfshlm.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_441_17446649.1109173282690
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Please create a unified style patch with diff -u.

here it is

> - The callback function names can be other ones that match better to
>   the control itself

I decided to keep the names but made the callbacks reusable. Hope you
don't mind.

> - Remove spin_lock_irq() around snd_ac97_*() calls
done
> - Clean up the comments
> 
> thanks,
> 
> Takashi
> 

Signed-off-by: Jaime A. Lopez Sollano <jsollano@gmail.com>

------=_Part_441_17446649.1109173282690
Content-Type: text/x-patch; name="intel8x0m.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="intel8x0m.c.patch"

Index: intel8x0m.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0m.c,v
retrieving revision 1.28
diff -u -r1.28 intel8x0m.c
--- intel8x0m.c=0917 Feb 2005 14:48:07 -0000=091.28
+++ intel8x0m.c=0923 Feb 2005 15:30:10 -0000
@@ -34,7 +34,9 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
+#include <sound/core.h>
 #include <sound/info.h>
+#include <sound/control.h>
 #include <sound/initval.h>
=20
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
@@ -281,9 +283,63 @@
 #endif
 =09{ 0, }
 };
+static int snd_intel8x0m_switch_default_get(snd_kcontrol_t *kcontrol,
+=09=09=09snd_ctl_elem_value_t *ucontrol);
+static int snd_intel8x0m_switch_default_put(snd_kcontrol_t *kcontrol,
+=09=09=09=09=09=09snd_ctl_elem_value_t *ucontrol);
+static int snd_intel8x0m_switch_default_info(snd_kcontrol_t *kcontrol,
+=09=09=09=09=09=09snd_ctl_elem_info_t *uinfo);
+struct snd_intel8x0m_mixer_switch_args {
+=09unsigned short reg;
+=09unsigned short mask;
+};
+#define PRIVATE_VALUE_INITIALIZER(r,m) \
+(unsigned long)&(struct snd_intel8x0m_mixer_switch_args) \
+{ .reg =3D r, .mask =3D m}
+
+static snd_kcontrol_new_t snd_intel8x0m_mixer_switches[] __devinitdata =3D=
 {
+  { .name  =3D "Off-hook Switch",
+    .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
+    .info  =3D snd_intel8x0m_switch_default_info,
+    .get   =3D snd_intel8x0m_switch_default_get,
+    .put   =3D snd_intel8x0m_switch_default_put,
+    .private_value =3D PRIVATE_VALUE_INITIALIZER(AC97_GPIO_STATUS,AC97_GPI=
O_LINE1_OH)
+  }
+};
=20
 MODULE_DEVICE_TABLE(pci, snd_intel8x0m_ids);
=20
+static int snd_intel8x0m_switch_default_info(snd_kcontrol_t *kcontrol,
+=09=09=09=09=09=09snd_ctl_elem_info_t *uinfo)
+{
+=09uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+=09uinfo->count =3D 1;
+=09uinfo->value.integer.min =3D 0;
+=09uinfo->value.integer.max =3D 1;
+=09return 0;
+}
+
+static int snd_intel8x0m_switch_default_get(snd_kcontrol_t *kcontrol,
+=09=09=09snd_ctl_elem_value_t *ucontrol)
+{
+=09struct snd_intel8x0m_mixer_switch_args *args =3D (void *)kcontrol->priv=
ate_value;
+=09intel8x0_t *chip =3D snd_kcontrol_chip(kcontrol);
+=09unsigned int status;
+=09status =3D snd_ac97_read(chip->ac97,args->reg)&args->mask?1:0;
+=09ucontrol->value.integer.value[0] =3D status;
+=09return 0;
+}
+static int snd_intel8x0m_switch_default_put(snd_kcontrol_t *kcontrol,
+=09=09=09=09=09=09snd_ctl_elem_value_t *ucontrol)
+{
+=09struct snd_intel8x0m_mixer_switch_args *args =3D (void *)kcontrol->priv=
ate_value;
+=09intel8x0_t *chip =3D snd_kcontrol_chip(kcontrol);
+=09unsigned short new_status =3D ucontrol->value.integer.value[0]?args->ma=
sk:~args->mask;
+=09int ret;
+=09ret =3D snd_ac97_update_bits(chip->ac97,args->reg,
+=09=09=09=09=09args->mask, new_status);
+=09return ret;
+}
 /*
  *  Lowlevel I/O - busmaster
  */
@@ -638,17 +694,12 @@
=20
 static int snd_intel8x0m_pcm_trigger(snd_pcm_substream_t *substream, int c=
md)
 {
-=09ichdev_t *ichdev =3D get_ichdev(substream);
 =09/* hook off/on on start/stop */
-=09/* TODO: move it to ac97 controls */
+=09/* Moved this to mixer control */
 =09switch (cmd) {
 =09case SNDRV_PCM_TRIGGER_START:
-=09=09snd_ac97_update_bits(ichdev->ac97, AC97_GPIO_STATUS,
-=09=09=09=09     AC97_GPIO_LINE1_OH, AC97_GPIO_LINE1_OH);
 =09=09break;
 =09case SNDRV_PCM_TRIGGER_STOP:
-=09=09snd_ac97_update_bits(ichdev->ac97, AC97_GPIO_STATUS,
-=09=09=09=09     AC97_GPIO_LINE1_OH, ~AC97_GPIO_LINE1_OH);
 =09=09break;
 =09default:
 =09=09return -EINVAL;
@@ -890,6 +941,7 @@
 =09ac97_t *x97;
 =09int err;
 =09unsigned int glob_sta =3D 0;
+=09unsigned int idx;
 =09static ac97_bus_ops_t ops =3D {
 =09=09.write =3D snd_intel8x0_codec_write,
 =09=09.read =3D snd_intel8x0_codec_read,
@@ -925,6 +977,10 @@
 =09=09chip->ichd[ICHD_MDMIN].ac97 =3D x97;
 =09=09chip->ichd[ICHD_MDMOUT].ac97 =3D x97;
 =09}
+=09for(idx =3D 0; idx < ARRAY_SIZE(snd_intel8x0m_mixer_switches); idx++) {
+=09=09if((err =3D snd_ctl_add(chip->card,snd_ctl_new1(&snd_intel8x0m_mixer=
_switches[idx],chip))) <0 )
+=09=09goto __err;
+=09}
=20
 =09chip->in_ac97_init =3D 0;
 =09return 0;

------=_Part_441_17446649.1109173282690--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
