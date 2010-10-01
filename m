From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Fri, 1 Oct 2010 18:15:32 +0800
Message-ID: <AANLkTi=1=jT5LnjjP9uGMx-Q9kM7X6kx5=NeKK6Sa9g8@mail.gmail.com>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
	<s5hsk0rtlun.wl%tiwai@suse.de>
	<AANLkTinT3EU3aLSBt5WmA=qDOf1cFABUNG+RiT3Nvx3e@mail.gmail.com>
	<s5h4od7tf43.wl%tiwai@suse.de> <20100930154557.GD11399@localhost>
	<AANLkTinnTeseJY4RDuGNkTjNE--QJ0Mw_S8FVKy_RT7h@mail.gmail.com>
	<20101001021548.GA7115@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 66E0B1039FC
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 12:15:33 +0200 (CEST)
Received: by wyb42 with SMTP id 42so2808803wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 03:15:33 -0700 (PDT)
In-Reply-To: <20101001021548.GA7115@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 1, 2010 at 10:15 AM, Wu Fengguang <fengguang.wu@intel.com> wrot=
e:

> Jeff, this should make your mic work.
>
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexan=
t.c
> index a6c68cb..c0c2b33 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -3110,6 +3110,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] =3D {
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_ID=
EAPAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge 13 (197)", CX=
T5066_IDEAPAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDE=
APAD),
> + =A0 =A0 =A0 SND_PCI_QUIRK(0x17aa, 0x2156, "Lenovo X201s", CXT5066_THINK=
PAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_T=
HINKPAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G series", CXT5066_I=
DEAPAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x390a, "Lenovo S10-3t", CXT5066_IDE=
APAD),


Getting closer, but mic still not working.


HDA Intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> IRQ 17
HDA Intel 0000:00:1b.0: irq 42 for MSI/MSI-X
HDA Intel 0000:00:1b.0: setting latency timer to 64
ALSA sound/pci/hda/hda_intel.c:2518: chipset global capabilities =3D 0x4401
ALSA sound/pci/hda/hda_intel.c:908: codec_mask =3D 0x9
ALSA sound/pci/hda/hda_intel.c:1346: codec #0 probed OK
ALSA sound/pci/hda/hda_intel.c:1346: codec #3 probed OK
ALSA sound/pci/hda/hda_codec.c:3720: hda_codec: model 'thinkpad' is
selected for config 17aa:215e (Lenovo Thinkpad)
ALSA sound/pci/hda/hda_generic.c:683: hda_generic: no proper input path fou=
nd
ALSA sound/pci/hda/hda_generic.c:288: Skip Digital OUT node 2
ALSA sound/pci/hda/hda_generic.c:288: Skip Digital OUT node 3
ALSA sound/pci/hda/hda_generic.c:431: hda_generic: no proper output path fo=
und
ALSA sound/pci/hda/hda_generic.c:1036: hda_generic: no PCM found
ALSA sound/pci/hda/patch_conexant.c:3032: CXT5066: init
ALSA sound/pci/hda/patch_conexant.c:2374: CXT5066: hp automute portA=3D0
portD=3D0 present=3D0
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D0
ALSA sound/pci/hda/patch_conexant.c:2354: CXT5066: external microphone abse=
nt
ALSA device list:
  #0: HDA Intel at 0xf2520000 irq 42

ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D0
ALSA sound/pci/hda/patch_conexant.c:3032: CXT5066: init
ALSA sound/pci/hda/patch_conexant.c:2374: CXT5066: hp automute portA=3D0
portD=3D0 present=3D0
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D0
ALSA sound/pci/hda/patch_conexant.c:2354: CXT5066: external microphone abse=
nt
ALSA sound/pci/hda/hda_intel.c:1670: azx_pcm_prepare: bufsize=3D0x10000,
format=3D0x11
ALSA sound/pci/hda/hda_codec.c:1226: hda_codec_setup_stream: NID=3D0x10,
stream=3D0x5, channel=3D0, format=3D0x11
ALSA sound/pci/hda/hda_codec.c:1284: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1284: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_intel.c:1670: azx_pcm_prepare: bufsize=3D0x10000,
format=3D0x11
ALSA sound/pci/hda/hda_codec.c:1226: hda_codec_setup_stream: NID=3D0x10,
stream=3D0x5, channel=3D0, format=3D0x11
ALSA sound/pci/hda/hda_codec.c:1284: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1284: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/patch_conexant.c:3032: CXT5066: init
ALSA sound/pci/hda/patch_conexant.c:2374: CXT5066: hp automute portA=3D0
portD=3D0 present=3D0
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D0
ALSA sound/pci/hda/patch_conexant.c:2354: CXT5066: external microphone abse=
nt
ALSA sound/pci/hda/patch_conexant.c:3032: CXT5066: init
ALSA sound/pci/hda/patch_conexant.c:2374: CXT5066: hp automute portA=3D1
portD=3D0 present=3D1
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D1
ALSA sound/pci/hda/patch_conexant.c:2348: CXT5066: external microphone dete=
cted
ALSA sound/pci/hda/hda_intel.c:1670: azx_pcm_prepare: bufsize=3D0x10000,
format=3D0x31
ALSA sound/pci/hda/hda_codec.c:1226: hda_codec_setup_stream: NID=3D0x14,
stream=3D0x1, channel=3D0, format=3D0x31
ALSA sound/pci/hda/hda_intel.c:701: azx_get_response timeout, polling
the codec once: last cmd=3D0x014a0000
ALSA sound/pci/hda/hda_codec.c:1284: hda_codec_cleanup_stream: NID=3D0x14
ALSA sound/pci/hda/hda_intel.c:1670: azx_pcm_prepare: bufsize=3D0x10000,
format=3D0x31
ALSA sound/pci/hda/hda_codec.c:1226: hda_codec_setup_stream: NID=3D0x10,
stream=3D0x5, channel=3D0, format=3D0x31
ALSA sound/pci/hda/hda_codec.c:1284: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/patch_conexant.c:3032: CXT5066: init
ALSA sound/pci/hda/patch_conexant.c:2374: CXT5066: hp automute portA=3D1
portD=3D0 present=3D1
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D1
ALSA sound/pci/hda/patch_conexant.c:2348: CXT5066: external microphone dete=
cted
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D1
ALSA sound/pci/hda/patch_conexant.c:3032: CXT5066: init
ALSA sound/pci/hda/patch_conexant.c:2374: CXT5066: hp automute portA=3D1
portD=3D0 present=3D1
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D1
ALSA sound/pci/hda/patch_conexant.c:2348: CXT5066: external microphone dete=
cted
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D1
ALSA sound/pci/hda/patch_conexant.c:3032: CXT5066: init
ALSA sound/pci/hda/patch_conexant.c:2374: CXT5066: hp automute portA=3D1
portD=3D0 present=3D1
ALSA sound/pci/hda/patch_conexant.c:2110: CXT5066: update speaker, hp_prese=
nt=3D1
ALSA sound/pci/hda/patch_conexant.c:2348: CXT5066: external microphone dete=
cted


Thanks,
Jeff.
