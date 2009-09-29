From: krzysztof.h1@poczta.fm
Subject: Re:
	=?utf-8?q?=5BPATCH=5D_sscape=3A_convert_to_firmware_?=
	=?utf-8?q?loader_framework?=
Date: 29 Sep 2009 08:15:22 +0200
Message-ID: <20090929061522.E3A46108258C@f22.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6650856990677848503=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id BD1541038A2
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 08:15:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, " Theodore J. Allen" <tjallen@hws.edu>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============6650856990677848503==
Content-Type: TEXT/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Please drop this patch. It does not compile because it includes removed ssc=
ape_ioctl.h.=0AI will send updated patch.=0A=0ABest regards,=0AKrzysztof=0A=
=0A"Krzysztof Helt" <krzysztof.h1@poczta.fm> pisze:=0A> The conversion solv=
es the problem that firmware size was set to 64KB=0A> while non PnP cards h=
ave 128KB firmware files.=0A> =0A> An additional post firmware initializati=
on code has been moved=0A> from the OSS driver.=0A> =0A> ---=0A> Now, the M=
IDI is audible but not correct. It is not played timely.=0A> The sscape_ctl=
 alsa-tool is not needed any more.=0A> =0A> =0A>  Documentation/sound/alsa/=
ALSA-Configuration.txt |    8 +-=0A>  include/sound/sscape_ioctl.h         =
           |   21 --=0A>  sound/isa/Kconfig                               |=
    8 +-=0A>  sound/isa/sscape.c                              |  305=0A> ++=
+++++----------------=0A>  4 files changed, 101 insertions(+), 241 deletion=
s(-)=0A>  delete mode 100644 include/sound/sscape_ioctl.h=0A> =0A> diff --g=
it a/Documentation/sound/alsa/ALSA-Configuration.txt=0A> b/Documentation/so=
und/alsa/ALSA-Configuration.txt=0A> index 1c8eb45..cf98525 100644=0A> --- a=
/Documentation/sound/alsa/ALSA-Configuration.txt=0A> +++ b/Documentation/so=
und/alsa/ALSA-Configuration.txt=0A> @@ -1631,7 +1631,7 @@ Prior to version =
0.9.0rc4 options had a 'snd_'=0A> prefix. This was removed.=0A>    Module s=
nd-sscape=0A>    -----------------=0A>  =0A> -    Module for ENSONIQ SoundS=
cape PnP cards.=0A> +    Module for ENSONIQ SoundScape cards.=0A>  =0A>    =
  port=09- Port # (PnP setup)=0A>      wss_port=09- WSS Port # (PnP setup)=
=0A> @@ -1640,9 +1640,9 @@ Prior to version 0.9.0rc4 options had a 'snd_'=
=0A> prefix. This was removed.=0A>      dma=09=09- DMA # (PnP setup)=0A>   =
   dma2=09- 2nd DMA # (PnP setup, -1 to disable)=0A>  =0A> -    This module=
 supports multiple cards.  ISA PnP must be enabled.=0A> -    You need sscap=
e_ctl tool in alsa-tools package for loading=0A> -    the microcode.=0A> + =
   This module supports multiple cards.=0A> +=0A> +    The driver requires =
the firmware loader support on kernel.=0A>  =0A>    Module snd-sun-amd7930 =
(on sparc only)=0A>    --------------------------------------=0A> diff --gi=
t a/include/sound/sscape_ioctl.h b/include/sound/sscape_ioctl.h=0A> deleted=
 file mode 100644=0A> index 0d88859..0000000=0A> --- a/include/sound/sscape=
_ioctl.h=0A> +++ /dev/null=0A> @@ -1,21 +0,0 @@=0A> -#ifndef SSCAPE_IOCTL_H=
=0A> -#define SSCAPE_IOCTL_H=0A> -=0A> -=0A> -struct sscape_bootblock=0A> -=
{=0A> -  unsigned char code[256];=0A> -  unsigned version;=0A> -};=0A> -=0A=
> -#define SSCAPE_MICROCODE_SIZE  65536=0A> -=0A> -struct sscape_microcode=
=0A> -{=0A> -  unsigned char __user *code;=0A> -};=0A> -=0A> -#define SND_S=
SCAPE_LOAD_BOOTB  _IOWR('P', 100, struct sscape_bootblock)=0A> -#define SND=
_SSCAPE_LOAD_MCODE  _IOW ('P', 101, struct sscape_microcode)=0A> -=0A> -#en=
dif=0A> diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig=0A> index b90fc1=
6..02fe81c 100644=0A> --- a/sound/isa/Kconfig=0A> +++ b/sound/isa/Kconfig=
=0A> @@ -372,9 +372,9 @@ config SND_SGALAXY=0A>  =0A>  config SND_SSCAPE=0A=
>  =09tristate "Ensoniq SoundScape driver"=0A> -=09select SND_HWDEP=0A>  =
=09select SND_MPU401_UART=0A>  =09select SND_WSS_LIB=0A> +=09select FW_LOAD=
ER=0A>  =09help=0A>  =09  Say Y here to include support for Ensoniq SoundSc=
ape =0A>  =09  and Ensoniq OEM soundcards.=0A> @@ -382,7 +382,11 @@ config =
SND_SSCAPE=0A>  =09  The PCM audio is supported on SoundScape Classic, Elit=
e, PnP=0A>  =09  and VIVO cards. The supported OEM cards are SPEA Media FX =
and=0A>  =09  Reveal SC-600.=0A> -=09  The MIDI support is very experimenta=
l.=0A> +=09  The MIDI support is very experimental and requires binary=0A> =
+=09  firmware files called "scope.cod" and "sndscape.co?" where the=0A> +=
=09  ? is digit 0, 1, 2, 3 or 4. The firmware files can be found=0A> +=09  =
in DOS or Windows driver packages. One has to put the firmware=0A> +=09  fi=
les into the /lib/firmware directory.=0A>  =0A>  =09  To compile this drive=
r as a module, choose M here: the module=0A>  =09  will be called snd-sscap=
e.=0A> diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c=0A> index b11c3=
5f..08389a2 100644=0A> --- a/sound/isa/sscape.c=0A> +++ b/sound/isa/sscape.=
c=0A> @@ -1,5 +1,5 @@=0A>  /*=0A> - *   Low-level ALSA driver for the ENSON=
IQ SoundScape PnP=0A> + *   Low-level ALSA driver for the ENSONIQ SoundScap=
e=0A>   *   Copyright (c) by Chris Rankin=0A>   *=0A>   *   This driver was=
 written in part using information obtained from=0A> @@ -25,12 +25,12 @@=0A=
>  #include <linux/err.h>=0A>  #include <linux/isa.h>=0A>  #include <linux/=
delay.h>=0A> +#include <linux/firmware.h>=0A>  #include <linux/pnp.h>=0A>  =
#include <linux/spinlock.h>=0A>  #include <linux/moduleparam.h>=0A>  #inclu=
de <asm/dma.h>=0A>  #include <sound/core.h>=0A> -#include <sound/hwdep.h>=
=0A>  #include <sound/wss.h>=0A>  #include <sound/mpu401.h>=0A>  #include <=
sound/initval.h>=0A> @@ -39,7 +39,7 @@=0A>  =0A>  =0A>  MODULE_AUTHOR("Chri=
s Rankin");=0A> -MODULE_DESCRIPTION("ENSONIQ SoundScape PnP driver");=0A> +=
MODULE_DESCRIPTION("ENSONIQ SoundScape driver");=0A>  MODULE_LICENSE("GPL")=
;=0A>  =0A>  static int index[SNDRV_CARDS] __devinitdata =3D SNDRV_DEFAULT_=
IDX;=0A> @@ -142,14 +142,12 @@ struct soundscape {=0A>  =09struct resource =
*wss_res;=0A>  =09struct snd_wss *chip;=0A>  =09struct snd_mpu401 *mpu;=0A>=
 -=09struct snd_hwdep *hw;=0A>  =0A>  =09/*=0A>  =09 * The MIDI device won'=
t work until we've loaded=0A>  =09 * its firmware via a hardware-dependent =
device IOCTL=0A>  =09 */=0A>  =09spinlock_t fwlock;=0A> -=09int hw_in_use;=
=0A>  =09unsigned long midi_usage;=0A>  =09unsigned char midi_vol;=0A>  };=
=0A> @@ -167,12 +165,6 @@ static inline struct soundscape=0A> *get_mpu401_s=
oundscape(struct snd_mpu401 * mpu)=0A>  =09return (struct soundscape *) (mp=
u->private_data);=0A>  }=0A>  =0A> -static inline struct soundscape *get_hw=
dep_soundscape(struct snd_hwdep *=0A> hw)=0A> -{=0A> -=09return (struct sou=
ndscape *) (hw->private_data);=0A> -}=0A> -=0A> -=0A>  /*=0A>   * Allocates=
 some kernel memory that we can use for DMA.=0A>   * I think this means tha=
t the memory has to map to=0A> @@ -438,14 +430,14 @@ static int host_startu=
p_ack(struct soundscape *s,=0A> unsigned timeout)=0A>   * Upload a byte-str=
eam into the SoundScape using DMA channel A.=0A>   */=0A>  static int uploa=
d_dma_data(struct soundscape *s,=0A> -                           const unsi=
gned char __user *data,=0A> +=09=09=09   const unsigned char *data,=0A>    =
                         size_t size)=0A>  {=0A>  =09unsigned long flags;=
=0A>  =09struct snd_dma_buffer dma;=0A>  =09int ret;=0A>  =0A> -=09if (!get=
_dmabuf(&dma, PAGE_ALIGN(size)))=0A> +=09if (!get_dmabuf(&dma, PAGE_ALIGN(3=
2 * 1024)))=0A>  =09=09return -ENOMEM;=0A>  =0A>  =09spin_lock_irqsave(&s->=
lock, flags);=0A> @@ -468,35 +460,17 @@ static int upload_dma_data(struct s=
oundscape *s,=0A>  =09sscape_write_unsafe(s->io_base, GA_HMCTL_REG,=0A> ssc=
ape_read_unsafe(s->io_base, GA_HMCTL_REG) | 0x80);=0A>  =0A>  =09/*=0A> -=
=09 * Upload the user's data (firmware?) to the SoundScape=0A> +=09 * Uploa=
d the firmware to the SoundScape=0A>  =09 * board through the DMA channel .=
..=0A>  =09 */=0A>  =09while (size !=3D 0) {=0A>  =09=09unsigned long len;=
=0A>  =0A> -=09=09/*=0A> -=09=09 * Apparently, copying to/from userspace ca=
n sleep.=0A> -=09=09 * We are therefore forbidden from holding any=0A> -=09=
=09 * spinlocks while we copy ...=0A> -=09=09 */=0A> -=09=09spin_unlock_irq=
restore(&s->lock, flags);=0A> -=0A> -=09=09/*=0A> -=09=09 * Remember that t=
he data that we want to DMA=0A> -=09=09 * comes from USERSPACE. We have alr=
eady verified=0A> -=09=09 * the userspace pointer ...=0A> -=09=09 */=0A>  =
=09=09len =3D min(size, dma.bytes);=0A> -=09=09len -=3D __copy_from_user(dm=
a.area, data, len);=0A> +=09=09memcpy(dma.area, data, len);=0A>  =09=09data=
 +=3D len;=0A>  =09=09size -=3D len;=0A>  =0A> -=09=09/*=0A> -=09=09 * Grab=
 that spinlock again, now that we've=0A> -=09=09 * finished copying!=0A> -=
=09=09 */=0A> -=09=09spin_lock_irqsave(&s->lock, flags);=0A> -=0A>  =09=09s=
nd_dma_program(s->chip->dma1, dma.addr, len, DMA_MODE_WRITE);=0A>  =09=09ss=
cape_start_dma_unsafe(s->io_base, GA_DMAA_REG);=0A>  =09=09if (!sscape_wait=
_dma_unsafe(s->io_base, GA_DMAA_REG, 5000)) {=0A> @@ -512,6 +486,7 @@ stati=
c int upload_dma_data(struct soundscape *s,=0A>  =09} /* while */=0A>  =0A>=
  =09set_host_mode_unsafe(s->io_base);=0A> +=09outb(0x0, s->io_base);=0A>  =
=0A>  =09/*=0A>  =09 * Boot the board ... (I think)=0A> @@ -537,7 +512,7 @@=
 _release_dma:=0A>  =09/*=0A>  =09 * NOTE!!! We are NOT holding any spinloc=
ks at this point !!!=0A>  =09 */=0A> -=09sscape_write(s, GA_DMAA_REG, (s->i=
c_type =3D=3D IC_ODIE ? 0x70 : 0x40));=0A> +=09sscape_write(s, GA_DMAA_REG,=
 (s->ic_type =3D=3D IC_OPUS ? 0x40 : 0x70));=0A>  =09free_dmabuf(&dma);=0A>=
  =0A>  =09return ret;=0A> @@ -547,162 +522,70 @@ _release_dma:=0A>   * Upl=
oad the bootblock(?) into the SoundScape. The only=0A>   * purpose of this =
block of code seems to be to tell=0A>   * us which version of the microcode=
 we should be using.=0A> - *=0A> - * NOTE: The boot-block data resides in U=
SER-SPACE!!!=0A> - *       However, we have already verified its memory=0A>=
 - *       addresses by the time we get here.=0A>   */=0A> -static int ssca=
pe_upload_bootblock(struct soundscape *sscape, struct=0A> sscape_bootblock =
__user *bb)=0A> +static int sscape_upload_bootblock(struct snd_card *card)=
=0A>  {=0A> +=09struct soundscape *sscape =3D get_card_soundscape(card);=0A=
>  =09unsigned long flags;=0A> +=09const struct firmware *init_fw =3D NULL;=
=0A>  =09int data =3D 0;=0A>  =09int ret;=0A>  =0A> -=09ret =3D upload_dma_=
data(sscape, bb->code, sizeof(bb->code));=0A> -=0A> -=09spin_lock_irqsave(&=
sscape->lock, flags);=0A> -=09if (ret =3D=3D 0) {=0A> -=09=09data =3D host_=
read_ctrl_unsafe(sscape->io_base, 100);=0A> -=09}=0A> -=09set_midi_mode_uns=
afe(sscape->io_base);=0A> -=09spin_unlock_irqrestore(&sscape->lock, flags);=
=0A> -=0A> -=09if (ret =3D=3D 0) {=0A> -=09=09if (data < 0) {=0A> -=09=09=
=09snd_printk(KERN_ERR "sscape: timeout reading firmware versionn");=0A> -=
=09=09=09ret =3D -EAGAIN;=0A> -=09=09}=0A> -=09=09else if (__copy_to_user(&=
bb->version, &data, sizeof(bb->version))) {=0A> -=09=09=09ret =3D -EFAULT;=
=0A> -=09=09}=0A> +=09ret =3D request_firmware(&init_fw, "scope.cod", card-=
>dev);=0A> +=09if (ret < 0) {=0A> +=09=09snd_printk(KERN_ERR "Error loading=
 scope.cod");=0A> +=09=09return ret;=0A>  =09}=0A> +=09ret =3D upload_dma_d=
ata(sscape, init_fw->data, init_fw->size);=0A>  =0A> -=09return ret;=0A> -}=
=0A> +=09release_firmware(init_fw);=0A>  =0A> -/*=0A> - * Upload the microc=
ode into the SoundScape. The=0A> - * microcode is 64K of data, and if we tr=
y to copy=0A> - * it into a local variable then we will SMASH THE=0A> - * K=
ERNEL'S STACK! We therefore leave it in USER=0A> - * SPACE, and save oursel=
ves from copying it at all.=0A> - */=0A> -static int sscape_upload_microcod=
e(struct soundscape *sscape,=0A> -                                   const =
struct sscape_microcode __user=0A> *mc)=0A> -{=0A> -=09unsigned long flags;=
=0A> -=09char __user *code;=0A> -=09int err;=0A> -=0A> -=09/*=0A> -=09 * We=
 are going to have to copy this data into a special=0A> -=09 * DMA-able buf=
fer before we can upload it. We shall therefore=0A> -=09 * just check that =
the data pointer is valid for now.=0A> -=09 *=0A> -=09 * NOTE: This buffer =
is 64K long! That's WAY too big to=0A> -=09 *       copy into a stack-tempo=
rary anyway.=0A> -=09 */=0A> -=09if ( get_user(code, &mc->code) ||=0A> -=09=
     !access_ok(VERIFY_READ, code, SSCAPE_MICROCODE_SIZE) )=0A> -=09=09retu=
rn -EFAULT;=0A> +=09spin_lock_irqsave(&sscape->lock, flags);=0A> +=09if (re=
t =3D=3D 0)=0A> +=09=09data =3D host_read_ctrl_unsafe(sscape->io_base, 100)=
;=0A>  =0A> -=09if ((err =3D upload_dma_data(sscape, code, SSCAPE_MICROCODE=
_SIZE)) =3D=3D 0)=0A> {=0A> -=09=09snd_printk(KERN_INFO "sscape: MIDI firmw=
are loadedn");=0A> -=09}=0A> +=09if (data & 0x10)=0A> +=09=09sscape_write_u=
nsafe(sscape->io_base, GA_SMCFGA_REG, 0x2f);=0A>  =0A> -=09spin_lock_irqsav=
e(&sscape->lock, flags);=0A> -=09set_midi_mode_unsafe(sscape->io_base);=0A>=
  =09spin_unlock_irqrestore(&sscape->lock, flags);=0A>  =0A> -=09initialise=
_mpu401(sscape->mpu);=0A> +=09data &=3D 0xf;=0A> +=09if (ret =3D=3D 0 && da=
ta > 7) {=0A> +=09=09snd_printk(KERN_ERR=0A> +=09=09=09=09"sscape: timeout =
reading firmware versionn");=0A> +=09=09ret =3D -EAGAIN;=0A> +=09}=0A>  =0A=
> -=09return err;=0A> +=09return (ret =3D=3D 0) ? data : ret;=0A>  }=0A>  =
=0A>  /*=0A> - * Hardware-specific device functions, to implement special=
=0A> - * IOCTLs for the SoundScape card. This is how we upload=0A> - * the =
microcode into the card, for example, and so we=0A> - * must ensure that no=
 two processes can open this device=0A> - * simultaneously, and that we can=
't open it at all if=0A> - * someone is using the MIDI device.=0A> + * Uplo=
ad the microcode into the SoundScape.=0A>   */=0A> -static int sscape_hw_op=
en(struct snd_hwdep * hw, struct file *file)=0A> +static int sscape_upload_=
microcode(struct snd_card *card, int version)=0A>  {=0A> -=09register struc=
t soundscape *sscape =3D get_hwdep_soundscape(hw);=0A> -=09unsigned long fl=
ags;=0A> +=09struct soundscape *sscape =3D get_card_soundscape(card);=0A> +=
=09const struct firmware *init_fw =3D NULL;=0A> +=09char name[14] =3D "snds=
cape.co0";=0A>  =09int err;=0A>  =0A> -=09spin_lock_irqsave(&sscape->fwlock=
, flags);=0A> +=09name[11] =3D '0' + version;=0A>  =0A> -=09if ((sscape->mi=
di_usage !=3D 0) || sscape->hw_in_use) {=0A> -=09=09err =3D -EBUSY;=0A> -=
=09} else {=0A> -=09=09sscape->hw_in_use =3D 1;=0A> -=09=09err =3D 0;=0A> +=
=09err =3D request_firmware(&init_fw, name, card->dev);=0A> +=09if (err < 0=
) {=0A> +=09=09snd_printk(KERN_ERR "Error loading sndscape.co0");=0A> +=09=
=09return err;=0A>  =09}=0A> +=09err =3D upload_dma_data(sscape, init_fw->d=
ata, init_fw->size);=0A> +=09if (err =3D=3D 0)=0A> +=09=09snd_printk(KERN_I=
NFO "MIDI firmware loaded %d KBsn",=0A> +=09=09=09=09init_fw->size >> 10);=
=0A>  =0A> -=09spin_unlock_irqrestore(&sscape->fwlock, flags);=0A> -=09retu=
rn err;=0A> -}=0A> -=0A> -static int sscape_hw_release(struct snd_hwdep * h=
w, struct file *file)=0A> -{=0A> -=09register struct soundscape *sscape =3D=
 get_hwdep_soundscape(hw);=0A> -=09unsigned long flags;=0A> -=0A> -=09spin_=
lock_irqsave(&sscape->fwlock, flags);=0A> -=09sscape->hw_in_use =3D 0;=0A> =
-=09spin_unlock_irqrestore(&sscape->fwlock, flags);=0A> -=09return 0;=0A> -=
}=0A> -=0A> -static int sscape_hw_ioctl(struct snd_hwdep * hw, struct file =
*file,=0A> -                           unsigned int cmd, unsigned long arg)=
=0A> -{=0A> -=09struct soundscape *sscape =3D get_hwdep_soundscape(hw);=0A>=
 -=09int err =3D -EBUSY;=0A> -=0A> -=09switch (cmd) {=0A> -=09case SND_SSCA=
PE_LOAD_BOOTB:=0A> -=09=09{=0A> -=09=09=09register struct sscape_bootblock =
__user *bb =3D (struct sscape_bootblock=0A> __user *) arg;=0A> -=0A> -=09=
=09=09/*=0A> -=09=09=09 * We are going to have to copy this data into a spe=
cial=0A> -=09=09=09 * DMA-able buffer before we can upload it. We shall the=
refore=0A> -=09=09=09 * just check that the data pointer is valid for now .=
..=0A> -=09=09=09 */=0A> -=09=09=09if ( !access_ok(VERIFY_READ, bb->code, s=
izeof(bb->code)) )=0A> -=09=09=09=09return -EFAULT;=0A> -=0A> -=09=09=09/*=
=0A> -=09=09=09 * Now check that we can write the firmware version number t=
oo...=0A> -=09=09=09 */=0A> -=09=09=09if ( !access_ok(VERIFY_WRITE, &bb->ve=
rsion, sizeof(bb->version)) )=0A> -=09=09=09=09return -EFAULT;=0A> -=0A> -=
=09=09=09err =3D sscape_upload_bootblock(sscape, bb);=0A> -=09=09}=0A> -=09=
=09break;=0A> -=0A> -=09case SND_SSCAPE_LOAD_MCODE:=0A> -=09=09{=0A> -=09=
=09=09register const struct sscape_microcode __user *mc =3D (const struct=
=0A> sscape_microcode __user *) arg;=0A> -=0A> -=09=09=09err =3D sscape_upl=
oad_microcode(sscape, mc);=0A> -=09=09}=0A> -=09=09break;=0A> -=0A> -=09def=
ault:=0A> -=09=09err =3D -EINVAL;=0A> -=09=09break;=0A> -=09} /* switch */=
=0A> +=09release_firmware(init_fw);=0A>  =0A>  =09return err;=0A>  }=0A>  =
=0A> -=0A>  /*=0A>   * Mixer control for the SoundScape's MIDI device.=0A> =
  */=0A> @@ -920,7 +803,7 @@ static int mpu401_open(struct snd_mpu401 * mpu=
)=0A>  =0A>  =09=09spin_lock_irqsave(&sscape->fwlock, flags);=0A>  =0A> -=
=09=09if (sscape->hw_in_use || (sscape->midi_usage =3D=3D ULONG_MAX)) {=0A>=
 +=09=09if (sscape->midi_usage =3D=3D ULONG_MAX) {=0A>  =09=09=09err =3D -E=
BUSY;=0A>  =09=09} else {=0A>  =09=09=09++(sscape->midi_usage);=0A> @@ -105=
3,13 +936,6 @@ static int __devinit create_ad1845(struct snd_card=0A> *card=
, unsigned port,=0A>  =09=09=09}=0A>  =09=09}=0A>  =0A> -=09=09strcpy(card-=
>driver, "SoundScape");=0A> -=09=09strcpy(card->shortname, pcm->name);=0A> =
-=09=09snprintf(card->longname, sizeof(card->longname),=0A> -=09=09=09 "%s =
at 0x%lx, IRQ %d, DMA1 %d, DMA2 %dn",=0A> -=09=09=09 pcm->name, chip->port,=
 chip->irq,=0A> -=09=09=09 chip->dma1, chip->dma2);=0A> -=0A>  =09=09sscape=
->chip =3D chip;=0A>  =09}=0A>  =0A> @@ -1162,29 +1038,6 @@ static int __de=
vinit create_sscape(int dev, struct=0A> snd_card *card)=0A>  =09=09return -=
ENXIO;=0A>  =09}=0A>  =0A> -=09if (sscape->type !=3D SSCAPE_VIVO) {=0A> -=
=09=09/*=0A> -=09=09 * Now create the hardware-specific device so that we c=
an=0A> -=09=09 * load the microcode into the on-board processor.=0A> -=09=
=09 * We cannot use the MPU-401 MIDI system until this firmware=0A> -=09=09=
 * has been loaded into the card.=0A> -=09=09 */=0A> -=09=09err =3D snd_hwd=
ep_new(card, "MC68EC000", 0, &(sscape->hw));=0A> -=09=09if (err < 0) {=0A> =
-=09=09=09printk(KERN_ERR "sscape: Failed to create "=0A> -=09=09=09=09=09"=
firmware devicen");=0A> -=09=09=09goto _release_dma;=0A> -=09=09}=0A> -=09=
=09strlcpy(sscape->hw->name, "SoundScape M68K",=0A> -=09=09=09sizeof(sscape=
->hw->name));=0A> -=09=09sscape->hw->name[sizeof(sscape->hw->name) - 1] =3D=
 '=EF=BF=BD';=0A> -=09=09sscape->hw->iface =3D SNDRV_HWDEP_IFACE_SSCAPE;=0A=
> -=09=09sscape->hw->ops.open =3D sscape_hw_open;=0A> -=09=09sscape->hw->op=
s.release =3D sscape_hw_release;=0A> -=09=09sscape->hw->ops.ioctl =3D sscap=
e_hw_ioctl;=0A> -=09=09sscape->hw->private_data =3D sscape;=0A> -=09}=0A> -=
=0A>  =09/*=0A>  =09 * Tell the on-board devices where their resources are =
(I think -=0A>  =09 * I can't be sure without a datasheet ... So many magic=
 values!)=0A> @@ -1222,28 +1075,51 @@ static int __devinit create_sscape(in=
t dev, struct=0A> snd_card *card)=0A>  =09=09       wss_port[dev], irq[dev]=
);=0A>  =09=09goto _release_dma;=0A>  =09}=0A> +=09strcpy(card->driver, "So=
undScape");=0A> +=09strcpy(card->shortname, name);=0A> +=09snprintf(card->l=
ongname, sizeof(card->longname),=0A> +=09=09 "%s at 0x%lx, IRQ %d, DMA1 %d,=
 DMA2 %dn",=0A> +=09=09 name, sscape->chip->port, sscape->chip->irq,=0A> +=
=09=09 sscape->chip->dma1, sscape->chip->dma2);=0A> +=0A>  #define MIDI_DEV=
NUM  0=0A>  =09if (sscape->type !=3D SSCAPE_VIVO) {=0A> -=09=09err =3D crea=
te_mpu401(card, MIDI_DEVNUM, port[dev], mpu_irq[dev]);=0A> -=09=09if (err <=
 0) {=0A> -=09=09=09printk(KERN_ERR "sscape: Failed to create "=0A> -=09=09=
=09=09=09"MPU-401 device at 0x%lxn",=0A> -=09=09=09=09=09port[dev]);=0A> -=
=09=09=09goto _release_dma;=0A> -=09=09}=0A> +=09=09err =3D sscape_upload_b=
ootblock(card);=0A> +=09=09if (err >=3D 0)=0A> +=09=09=09err =3D sscape_upl=
oad_microcode(card, err);=0A> +=0A> +=09=09if (err =3D=3D 0) {=0A> +=09=09=
=09err =3D create_mpu401(card, MIDI_DEVNUM, port[dev],=0A> +=09=09=09=09=09=
    mpu_irq[dev]);=0A> +=09=09=09if (err < 0) {=0A> +=09=09=09=09printk(KER=
N_ERR "sscape: Failed to create "=0A> +=09=09=09=09=09=09"MPU-401 device at=
 0x%lxn",=0A> +=09=09=09=09=09=09port[dev]);=0A> +=09=09=09=09goto _release=
_dma;=0A> +=09=09=09}=0A>  =0A> -=09=09/*=0A> -=09=09 * Enable the master I=
RQ ...=0A> -=09=09 */=0A> -=09=09sscape_write(sscape, GA_INTENA_REG, 0x80);=
=0A> -=0A> -=09=09/*=0A> -=09=09 * Initialize mixer=0A> -=09=09 */=0A> -=09=
=09sscape->midi_vol =3D 0;=0A> -=09=09host_write_ctrl_unsafe(sscape->io_bas=
e, CMD_SET_MIDI_VOL, 100);=0A> -=09=09host_write_ctrl_unsafe(sscape->io_bas=
e, 0, 100);=0A> -=09=09host_write_ctrl_unsafe(sscape->io_base, CMD_XXX_MIDI=
_VOL, 100);=0A> +=09=09=09/*=0A> +=09=09=09 * Initialize mixer=0A> +=09=09=
=09 */=0A> +=09=09=09spin_lock_irqsave(&sscape->lock, flags);=0A> +=09=09=
=09sscape->midi_vol =3D 0;=0A> +=09=09=09host_write_ctrl_unsafe(sscape->io_=
base,=0A> +=09=09=09=09=09=09CMD_SET_MIDI_VOL, 100);=0A> +=09=09=09host_wri=
te_ctrl_unsafe(sscape->io_base,=0A> +=09=09=09=09=09=09sscape->midi_vol, 10=
0);=0A> +=09=09=09host_write_ctrl_unsafe(sscape->io_base,=0A> +=09=09=09=09=
=09=09CMD_XXX_MIDI_VOL, 100);=0A> +=09=09=09host_write_ctrl_unsafe(sscape->=
io_base,=0A> +=09=09=09=09=09=09sscape->midi_vol, 100);=0A> +=09=09=09host_=
write_ctrl_unsafe(sscape->io_base,=0A> +=09=09=09=09=09=09CMD_SET_EXTMIDI, =
100);=0A> +=09=09=09host_write_ctrl_unsafe(sscape->io_base,=0A> +=09=09=09=
=09=09=090, 100);=0A> +=09=09=09host_write_ctrl_unsafe(sscape->io_base, 80,=
 1);=0A> +=0A> +=09=09=09set_midi_mode_unsafe(sscape->io_base);=0A> +=09=09=
=09spin_unlock_irqrestore(&sscape->lock, flags);=0A> +=09=09}=0A>  =09}=0A>=
  =0A>  =09/*=0A> @@ -1301,11 +1177,12 @@ static int __devinit snd_sscape_p=
robe(struct=0A> device *pdev, unsigned int dev)=0A>  =09sscape->type =3D SS=
CAPE;=0A>  =0A>  =09dma[dev] &=3D 0x03;=0A> +=09snd_card_set_dev(card, pdev=
);=0A> +=0A>  =09ret =3D create_sscape(dev, card);=0A>  =09if (ret < 0)=0A>=
  =09=09goto _release_card;=0A>  =0A> -=09snd_card_set_dev(card, pdev);=0A>=
  =09if ((ret =3D snd_card_register(card)) < 0) {=0A>  =09=09printk(KERN_ER=
R "sscape: Failed to register sound cardn");=0A>  =09=09goto _release_card;=
=0A> @@ -1426,12 +1303,12 @@ static int __devinit sscape_pnp_detect(struct=
=0A> pnp_card_link *pcard,=0A>  =09=09wss_port[idx] =3D pnp_port_start(dev,=
 1);=0A>  =09=09dma2[idx] =3D pnp_dma(dev, 1);=0A>  =09}=0A> +=09snd_card_s=
et_dev(card, &pcard->card->dev);=0A>  =0A>  =09ret =3D create_sscape(idx, c=
ard);=0A>  =09if (ret < 0)=0A>  =09=09goto _release_card;=0A>  =0A> -=09snd=
_card_set_dev(card, &pcard->card->dev);=0A>  =09if ((ret =3D snd_card_regis=
ter(card)) < 0) {=0A>  =09=09printk(KERN_ERR "sscape: Failed to register so=
und cardn");=0A>  =09=09goto _release_card;=0A> -- =0A> 1.6.0.3=0A> =0A> --=
--------------------------------------------------------------------=0A> Co=
 godzine losujemy 15 000 z=0A=0A

----------------------------------------------------------------------
Praca za granic±? Zobacz oferty!
http://link.interia.pl/f2331


--===============6650856990677848503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6650856990677848503==--
