From: "Nicolas Kalkhof" <nkalkhof@web.de>
Subject: Re: No sound from Headphone Jack over Lenovo Docking
 Station with T440p Laptop
Date: Sun, 22 Dec 2013 14:41:20 +0100 (CET)
Message-ID: <trinity-b32c2def-5a7a-4758-ab0d-9f66dbd1daf0-1387719680578@3capp-webde-bs32>
References: <trinity-ed805987-a2af-445d-8c84-171681bd6482-1387447530146@3capp-webde-bs34>,
 <CAN8cciaKv=4s2Njaag7XjqBj203EPL1BTi3XAG+ZmEpSP+20hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id E446526109E
 for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2013 14:41:21 +0100 (CET)
Received: from 3capp-webde-bs32.server.lan ([172.19.170.32]) by
 mriweb.server.lan (mriweb001) with ESMTP (Nemesis) id
 0Liq95-1VMl2r2rFd-00cxTw for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2013
 14:41:20 +0100
In-Reply-To: <CAN8cciaKv=4s2Njaag7XjqBj203EPL1BTi3XAG+ZmEpSP+20hg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Do your dock station has one headphone and one mic Jack or just one combo
> headset Jack ?
> Connect headphones or a headset that has a 3.5-mm (0.14-inch), 4-pole plug
> to the audio connector to listen to the sound from the computer.

The Docking station as well as the Notebook has just one Stereo/Mic Combo Audio Jack. I've tried various Headset with 4-Pole and 3-pole plugs. They all work fine on the Notebook but not with the Docking station (40A20090EU). However the Laptop speakers mute as soon as I plug the Headset in the Docking Station so it seems that the driver is somehow aware of it!

> Remove the following lines
> options snd cards_limit=1
> #options snd-hda-intel model=thinkpad
> options snd-hda-intel model=thinkpad enable=1 index=0
> options snd-hda-intel model=hdmi enable=1 index=-2

I already tried that no success. Without the index parameter alsa switches to the HDMI output by default.

> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=108cc108a3bb42fe4705df1317ff98e1e29428a6[https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=108cc108a3bb42fe4705df1317ff98e1e29428a6]

> lenovo-dock expect dock headphone Jack and dock Mic Jack ?

I guess so since there is only one plug. Again all works well when I use the Notebooks 3.5mm plug.

> Post the output of alsa-info.sh when thinkpad is docked and not docked with
> headphone pluggedd and unplugged

Well here I have another problem. The script doesn't get very far:
ALSA Information Script v 0.4.62
--------------------------------

This script visits the following commands/files to collect diagnostic
information about your ALSA installation and sound related hardware.

  dmesg
  lspci
  lsmod
  aplay
  amixer
  alsactl
  /proc/asound/
  /sys/class/sound/
  ~/.asoundrc (etc.)

See 'alsa-info.sh --help' for command line options.

cat: /proc/asound/modules: No such file or directory

Strange thing, /proc/asound exists:
HDMI  PCH  card0  card1  cards  devices  pcm  timers  version

I've compiled the drivers als modules and they are loaded!

lsmod shows:
thinkpad_acpi          52900  1
i915                  666771  5
snd_hda_intel          26867  6
snd_hda_codec         116484  2 snd_hda_codec_realtek,snd_hda_intel
cfbfillrect             3650  1 i915
cfbimgblt               2039  1 i915
cfbcopyarea             3350  1 i915
snd_pcm                65126  4 snd_hda_codec,snd_hda_intel
drm_kms_helper         27044  1 i915
intel_gtt              11928  1 i915
snd_page_alloc          6690  2 snd_pcm,snd_hda_intel

cat pcm:
00-00: ALC292 Analog : ALC292 Analog : playback 1 : capture 1
01-03: ID 2807 Digital : ID 2807 Digital : playback 1

cat cards:
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf0634000 irq 44
 1 [HDMI           ]: HDA-Intel - HDA Intel HDMI
                     HDA Intel HDMI at 0xf0630000 irq 46

Any further help?
