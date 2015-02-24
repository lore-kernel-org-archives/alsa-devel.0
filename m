From: John Frankish <john.frankish@outlook.com>
Subject: No sound from speakers with Realtek ALC3226
Date: Tue, 24 Feb 2015 13:14:38 +0400
Message-ID: <COL403-EAS144CB85A708197E0DF2965FF3160@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from COL004-OMC3S14.hotmail.com (col004-omc3s14.hotmail.com
 [65.55.34.152]) by alsa0.perex.cz (Postfix) with ESMTP id 977AE260511
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 10:14:49 +0100 (CET)
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I posted this on the alsa-user list, but did not get a reply.

Although it occasionally works, I am usually unable to get any sound out of
the speakers on a dell latitude e7240 using alsa-1.0.28 and linux-3.16.6 -
see details at the end of the post.

1. HDMI is the default sound device - why, the analogue device would make
more sense?

2. On the analogue sound device, the headphones are the default instead of
the speakers. On the few occasions I get sound out of the speakers, the
headphones need to be muted first - even though no headphones are connected.

3. Shutting windows 7 64bit down with "shutdown.exe -s" seems to help with
getting sound from the speakers with linux on the same machine.

Most of the time, I see the error:

snd_hda_intel 0000:00:1b.0: IRQ timing workaround is activated for card #1.
Suggest a bigger bdl_pos_adj.

I've tried various module options:

options snd_hda_intel probe_only=0,1
options snd-hda-intel enable_msi=1 bdl_pos_adj=1,32 [and 48 and 64] options
snd-hda-intel id=PCH index=1

..all to no avail.

Any additional troubleshooting suggestions (or a patch) would be much
appreciated.

John

----------
$ lspci | grep -i audio
00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller
(rev0b)
00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller (rev04)

$ cat /proc/asound/cards
 0 [HDMI           ]: HDA-Intel - HDA Intel HDMI
                      HDA Intel HDMI at 0xf7e34000 irq 65
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf7e30000 irq 64

$ aplay -l
**** List of PLAYBACK Hardware Devices **** card 0: HDMI [HDA Intel HDMI],
device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 0: ALC3226 Analog [ALC3226 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ cat /proc/asound/card*/codec* | grep Codec
Codec: Intel Haswell HDMI
Codec: Realtek ALC3226
