From: Jaime Lopez <jsollano@gmail.com>
Subject: Re: [PATCH] Add mixer controls to intel8x0m
Date: Tue, 22 Feb 2005 17:14:01 -0600
Message-ID: <977226cd05022215142133ecc4@mail.gmail.com>
References: <977226cd05022215084074718@mail.gmail.com>
Reply-To: Jaime Lopez <jsollano@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_714_28460182.1109114041053"
In-Reply-To: <977226cd05022215084074718@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_714_28460182.1109114041053
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

oops. forgot to include the diff:



On Tue, 22 Feb 2005 17:08:26 -0600, Jaime Lopez <jsollano@gmail.com> wrote:
> This patch adds a mixer switch to the intel8x0m driver, so that the
> hook state can be controlled from userspace, instead of bringing the
> line off hook on capture start. Please someone test, and merge into
> cvs. Comments are welcome
>

------=_Part_714_28460182.1109114041053
Content-Type: text/x-patch; name="intel8x0m.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="intel8x0m.patch"

Index: intel8x0m.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0m.c,v
retrieving revision 1.28
diff -r1.28 intel8x0m.c
36a37
> #include <sound/core.h>
37a39
> #include <sound/control.h>
283a286,300
> static int snd_intel8x0m_switch_default_get(snd_kcontrol_t *kcontrol,
> =09=09=09snd_ctl_elem_value_t *ucontrol);
> static int snd_intel8x0m_switch_default_put(snd_kcontrol_t *kcontrol,
> =09=09=09=09=09=09snd_ctl_elem_value_t *ucontrol);
> static int snd_intel8x0m_switch_default_info(snd_kcontrol_t *kcontrol,
> =09=09=09=09=09=09snd_ctl_elem_info_t *uinfo);
>=20
> static snd_kcontrol_new_t snd_intel8x0m_mixer_switches[] __devinitdata =
=3D {
>   { .name  =3D "Off-hook Switch",
>     .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>     .info  =3D snd_intel8x0m_switch_default_info,
>     .get   =3D snd_intel8x0m_switch_default_get,
>     .put   =3D snd_intel8x0m_switch_default_put
>   }
> };
286a304,339
> static int snd_intel8x0m_switch_default_info(snd_kcontrol_t *kcontrol,
> =09=09=09=09=09=09snd_ctl_elem_info_t *uinfo)
> {
> =09uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
> =09uinfo->count =3D 1;
> =09uinfo->value.integer.min =3D 0;
> =09uinfo->value.integer.max =3D 1;
> =09return 0;
> }
>=20
> static int snd_intel8x0m_switch_default_get(snd_kcontrol_t *kcontrol,
> =09=09=09snd_ctl_elem_value_t *ucontrol)
> {
> =09intel8x0_t *chip =3D snd_kcontrol_chip(kcontrol);
> =09unsigned int status;
> =09spin_lock_irq(&chip->reg_lock);
> =09status =3D snd_ac97_read(chip->ac97,AC97_GPIO_STATUS)&AC97_GPIO_LINE1_=
OH?1:0;
> =09spin_unlock_irq(&chip->reg_lock);
> =09ucontrol->value.integer.value[0] =3D status;
> =09return 0;
> }
> static int snd_intel8x0m_switch_default_put(snd_kcontrol_t *kcontrol,
> =09=09=09=09=09=09snd_ctl_elem_value_t *ucontrol)
> {
> =09intel8x0_t *chip =3D snd_kcontrol_chip(kcontrol);
> =09unsigned short new_status =3D ucontrol->value.integer.value[0]?AC97_GP=
IO_LINE1_OH:~AC97_GPIO_LINE1_OH;
> =09int ret;
> =09//unsigned short status =3D snd_ac97_read(chip->ac97,AC97_GPIO_STATUS)=
&AC97_GPIO_LINE1_OH;
> =09spin_lock_irq(&chip->reg_lock);
> =09snd_printk("Writing status: %04x\n",new_status);
> =09ret =3D snd_ac97_update_bits(chip->ac97,AC97_GPIO_STATUS,
> =09=09=09=09=09AC97_GPIO_LINE1_OH, new_status);
> =09spin_unlock_irq(&chip->reg_lock);
> =09return ret;
> =09//return 0;
> }
544a598
> =09unsigned int ring =3D 0;
566a621,624
>=20
> =09//status =3D igetdword(chip,ICHREG(GLOB_STA));
> =09//ring =3D ((status=3Dsnd_ac97_read(chip->ac97,AC97_GPIO_STATUS))&(1<<=
5))?1:0;
> =09//if(status !=3D 0xffff) snd_printk("s: %08x\n",status);
640a699
> =09unsigned short regv;
646,647c705,707
< =09=09snd_ac97_update_bits(ichdev->ac97, AC97_GPIO_STATUS,
< =09=09=09=09     AC97_GPIO_LINE1_OH, AC97_GPIO_LINE1_OH);
---
> =09=09//snd_ac97_update_bits(ichdev->ac97, AC97_GPIO_STATUS,
> =09=09//=09=09     AC97_GPIO_LINE1_OH, AC97_GPIO_LINE1_OH);
> =09=09//snd_ac97_update_bits(ichdev->ac97,AC97_GPIO_STATUS,0x40,0x40);
650,651c710,712
< =09=09snd_ac97_update_bits(ichdev->ac97, AC97_GPIO_STATUS,
< =09=09=09=09     AC97_GPIO_LINE1_OH, ~AC97_GPIO_LINE1_OH);
---
> =09=09//snd_ac97_update_bits(ichdev->ac97, AC97_GPIO_STATUS,
> =09=09//=09=09     AC97_GPIO_LINE1_OH, ~AC97_GPIO_LINE1_OH);
> =09=09//snd_ac97_update_bits(ichdev->ac97,AC97_GPIO_STATUS,0x40,~0x40);
892a954
> =09unsigned int idx;
927a990,993
> =09for(idx =3D 0; idx < ARRAY_SIZE(snd_intel8x0m_mixer_switches); idx++) =
{
> =09=09if((err =3D snd_ctl_add(chip->card,snd_ctl_new1(&snd_intel8x0m_mixe=
r_switches[idx],chip))) <0 )
> =09=09goto __err;
> =09}

------=_Part_714_28460182.1109114041053--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
