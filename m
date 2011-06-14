From: =?iso-8859-1?Q?Lambrecht_J=FCrgen?= <J.Lambrecht@TELEVIC.com>
Subject: ASoC: "No soundcards found" but
 'snd_soc_instantiate_card' succeeds afterwards
Date: Tue, 14 Jun 2011 16:54:42 +0200
Message-ID: <4DF77632.8070105@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ip2.televic.com (ip2.televic.com [81.82.194.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 059A81037F5
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 16:54:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I have a imx27 ARM9 with MC13783 codec (all from Freescale).

alsa init does not find a sound card, but finally there is a sound card.
   cat /proc/asound/cards:
     0 [iMXmc13783audio]:  - iMX-mc13783-audio
                         iMX-mc13783-audio

Maybe the inits are done in a wrong order, but how to fix?

Here some parts of the prints:
[start]
bus: 'platform': add driver mc13783-codec
bus: 'platform': driver_probe_device: matched device mc13783-codec with =

driver mc13783-codec
bus: 'platform': really_probe: probing driver mc13783-codec with device =

mc13783-codec
mc13783-codec mc13783-codec: codec register mc13783-codec
mc13783-codec mc13783-codec: dai register mc13783-codec #1
Registered DAI 'mc13783-hifi'
Registered codec 'mc13783-codec'
driver: 'mc13783-codec': driver_bound: bound to device 'mc13783-codec'
bus: 'platform': really_probe: bound device mc13783-codec to driver =

mc13783-codec
bus: 'platform': add driver imx-ssi
bus: 'platform': driver_probe_device: matched device imx-ssi.0 with =

driver imx-ssi
bus: 'platform': really_probe: probing driver imx-ssi with device imx-ssi.0
imx-ssi imx-ssi.0: dai register imx-ssi.0
Registered DAI 'imx-ssi.0'
Registering platform device 'imx-fiq-pcm-audio.0'. Parent at platform
device: 'imx-fiq-pcm-audio.0': device_add
bus: 'platform': add device imx-fiq-pcm-audio.0
Registering platform device 'imx-pcm-audio.0'. Parent at platform
device: 'imx-pcm-audio.0': device_add
bus: 'platform': add device imx-pcm-audio.0
driver: 'imx-ssi.0': driver_bound: bound to device 'imx-ssi'
bus: 'platform': really_probe: bound device imx-ssi.0 to driver imx-ssi
bus: 'platform': add driver imx-pcm-audio
bus: 'platform': driver_probe_device: matched device imx-pcm-audio.0 =

with driver imx-pcm-audio
bus: 'platform': really_probe: probing driver imx-pcm-audio with device =

imx-pcm-audio.0
imx-pcm-audio imx-pcm-audio.0: platform register imx-pcm-audio.0
asoc: snd_soc_instantiate_cards
Registered platform 'imx-pcm-audio.0'
driver: 'imx-pcm-audio.0': driver_bound: bound to device 'imx-pcm-audio'
bus: 'platform': really_probe: bound device imx-pcm-audio.0 to driver =

imx-pcm-audio
ALSA device list:
   No soundcards found.
[end]

-> then a sound card is registered by calling =

'late_initcall(imx_mc13783_audio_init);'

[start]
Registering platform device 'soc-audio'. Parent at platform
device: 'soc-audio': device_add
bus: 'platform': add device soc-audio
bus: 'platform': driver_probe_device: matched device soc-audio with =

driver soc-audio
bus: 'platform': really_probe: probing driver soc-audio with device =

soc-audio
asoc: snd_soc_instantiate_card iMX-mc13783-audio
soc-audio soc-audio: binding MC13783 Playback at idx 0
soc-audio soc-audio: binding MC13783 Capture at idx 1
asoc: created sound card for card iMX-mc13783-audio
asoc: sound card iMX-mc13783-audio probed
soc-audio soc-audio: probe iMX-mc13783-audio dai link 0
device: 'MC13783 Playback': device_add
soc-audio soc-audio: registered pcm #0 Playback mc13783-hifi-0
asoc: mc13783-hifi <-> imx-ssi.0 mapping ok
asoc: sound card iMX-mc13783-audio instantiated
soc-audio soc-audio: probe iMX-mc13783-audio dai link 1
device: 'MC13783 Capture': device_add
soc-audio soc-audio: registered pcm #1 Capture mc13783-hifi-1
asoc: mc13783-hifi <-> imx-ssi.0 mapping ok
asoc: sound card iMX-mc13783-audio instantiated
device: 'card0': device_add
device: 'pcmC0D1p': device_add
device: 'pcmC0D1c': device_add
device: 'adsp': device_add
device: 'pcmC0D0p': device_add
device: 'pcmC0D0c': device_add
device: 'dsp': device_add
device: 'audio': device_add
device: 'controlC0': device_add
device: 'mixer': device_add
asoc: sound card iMX-mc13783-audio registered
[end]

Regards,
J=FCrgen

P.S.: to enable pr_debug and dev_dbg I had to add them myself in =

soc-core.c (see my previous mail)
-- =


J=FCrgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
