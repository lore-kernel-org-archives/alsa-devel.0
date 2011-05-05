From: Valerio tesei <valerio.tesei@gmail.com>
Subject: Re: Multistreaming Playback using Front Panel
 Headphone with realtek codec
Date: Thu, 5 May 2011 13:26:43 +0200
Message-ID: <BANLkTikP+e2Oe_K0yFMJNWmYGdMkdyhN+A@mail.gmail.com>
References: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
	<s5hoc3hmq0b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 30E20103810
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 13:26:44 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1671570fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 05 May 2011 04:26:43 -0700 (PDT)
In-Reply-To: <s5hoc3hmq0b.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/5 Takashi Iwai <tiwai@suse.de>

> At Wed, 4 May 2011 23:42:24 +0800,
> Raymond Yau wrote:
> >
> > Request for testers to test the patch
> >
> > Multistreaming allows you to listen to one audio source through the back
> > panel speakers and a second audio source through front panel headphones
> or
> > speakers.
> >
> > Hardware requirement
> > 1) 10 channels realtek codec (e.g. alc892) which already work with
> > model=auto
> > 2) Headphone at front panel and Line out at rear panel
> >
> > "hw:0,0" is used for the rear panel audio jack
> > "hw:0,2" is used for the front panel headphone when "Independent HP" is
> > switched ON
>
> I'd name it differently, e.g. "Headphone Stream Mode" taking "Slave" and
> "Independent", or such.  An enum with "ON" and "OFF" is no sensible choice.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Hi Raymond,
Looking at the specs of my motherboard (ASUS P7H55M-PRO) they wrote:
 Realtek ALC892 8-Channel High Definition Audio CODEC
- BD Audio Layer Content Protection
- Support Jack-dectection, Multi-streaming,Front Panel Jack-Retasking (Mic
in port)
- ASUS Noise Filter
- Optical S/PDIF out ports at back I/O
But from Realtek specs they wrote
" Ten DAC channels support 16/20/24-bit PCM format for 7.1 channel sound
playback, plus 2 channels of concurrent independent stereo sound output
(multiple streaming) through the front panel output "
An asus spec error? will be useful a test made on my motherboard?

About my problem, the audio card with the latest patches seems to work (but
great noise when nothing is playing is present, i also tried to mute
everything in alsamixer) so i could say "it works with model=auto"

I applied the patch, and build the kernel, this is my lastest alsa-info:
http://www.alsa-project.org/db/?f=61aa4129d0ea771ebc7226ea80c5c3ead24ef05c

"Loaded ALSA modules" is empty, but lsmod says:
dante log # lsmod|grep snd
snd_hda_codec_realtek   298841  1
snd_hda_intel          20936  0
snd_hda_codec          62886  2 snd_hda_codec_realtek,snd_hda_intel
snd_hwdep               5484  1 snd_hda_codec
dante log #

I notice this in my dmesg
[   12.805835] ALSA sound/pci/hda/patch_realtek.c:1842: realtek: No valid
SSID, checking pincfg 0x4005e601 for NID 0x1d
[   12.805838] ALSA sound/pci/hda/patch_realtek.c:1858: realtek: Enabling
init ASM_ID=0xe601 CODEC_ID=10ec0892
[   12.805890] ALSA sound/pci/hda/patch_realtek.c:1569: realtek: Enable HP
auto-muting on NID 0x1b
Is normal "No valid SSID" ?

Alsa-conf still not find my sound card.

Sorry for the long story, but i would give you more informations as i can to
help.
