From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: Re:
 =?utf-8?q?Request_for_HW_auto-recognition=3A_HP_Pavi?=
 =?utf-8?q?lion_dv7_with=09STAC92xx?=
Date: Thu, 13 Dec 2012 14:04:10 +0100
Message-ID: <28554302d077d5894814557cdb219bad@sourcepole.ch>
References: <f1d85d07d48763e792148f67cb6f842c@sourcepole.ch>
 <s5hk3snrsrk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 43BC026160D
 for <Alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 14:04:20 +0100 (CET)
In-Reply-To: <s5hk3snrsrk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Dec 2012 20:10:23 +0100, Takashi Iwai wrote:
> At Wed, 12 Dec 2012 18:08:25 +0100, Tomas Pospisek wrote:
>> 
>> I have a HP Pavilion dv7 laptop (LS066EA#UUZ), with:
>> 
>>   # cat /proc/asound/card0/codec* | grep Codec
>>   Codec: IDT 92HD81B1X5
>>   Codec: Intel CougarPoint HDMI
>> 
>> when play sound without any tweaks, I get a very weak sound output. If
I
>> want to have "beats audio", that is subwoofer and all speakers, I need
to
>> set:
>> 
>>   # cat /etc/modprobe.d/alsa-base.conf 
>>   options snd-hda-intel model=hp-dv7-4000
>> 
>> Could the snd_hda_intel alsa driver be updated to recognize and setup
the
>> driver accordingly?
>> 
>> alsa-info.sh output here:
>>  
>>
http://www.alsa-project.org/db/?f=54ea874f43f12c1572aff3ee3113dc4b0ad0b398
> 
> Could you check whether the patch below works?
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/patch_sigmatel.c
> b/sound/pci/hda/patch_sigmatel.c
> index df13c0f..a86547c 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -1725,7 +1725,7 @@ static const struct snd_pci_quirk
> stac92hd83xxx_cfg_tbl[] = {
>  	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1658,
>  			  "HP", STAC_92HD83XXX_HP_cNB11_INTQUAD),
>  	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1659,
> -			  "HP", STAC_92HD83XXX_HP_cNB11_INTQUAD),
> +			  "HP Pavilion dv7", STAC_HP_DV7_4000),
>  	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x165A,
>  			  "HP", STAC_92HD83XXX_HP_cNB11_INTQUAD),
>  	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x165B,

It now indeed does switch on "beats audio" aka subwoofer et al.

However now I got a different problem: When I play a video on youtube,
then
suspend to RAM, and then resume:

* if the music was playing when suspending, then the desktop gets stuck
  after resume:
  no mouse, no keyboard input gets through to the desktop. I can
  Ctrl-Alt-F1 out of X and reboot and that's it. I guess it's the firefox
  flash plugin getting blocked in the kernel while accessing the audio
  device and thus blocking the whole desktop (that's my speculation).

* if the music was *not* playing (i.e. video paused), then after resume
  there is no sound any more. "alsa force-reload" puts the audio in some
  weird state where it gets in a loop playing some short bit of sound:
  tak-tak-tak-tak-tak-tak... So again I reboot.

# uname -a
  Linux hier 3.7.0 #2 SMP Thu Dec 13 12:48:25 CET 2012 x86_64 GNU/Linux

*t
