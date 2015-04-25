From: Gabriele Martino <g.martino@gmx.com>
Subject: Intel HDA / ca0132: support for Alienware 15 Creative
 Sound Core3D-EX
Date: Sat, 25 Apr 2015 02:50:23 +0200
Message-ID: <553AE4CF.3070805@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E522A2610A6
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 02:50:10 +0200 (CEST)
Received: from [192.168.69.6] ([79.44.224.230]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MEFIm-1YWP2Q1m24-00FUgK for
 <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 02:50:10 +0200
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

Hi,
the new Alienware 15 laptop (2015, not the M15x) has a Creative Sound
Core3D-EX Audio which seems to work with ca0132.
I'm using a 4.0.0 kernel with gentoo patchset, but with the default
configuration:
- the line out/headphone jack doesn't work, it only outputs some white noise
- alsamixer shows only "Master" and "PCM" channel, no "Front", "Line
Out" or similar
- alsamixer has a toggle switch for the "HP/Speaker" but no
headphone/line out switch
- the jack detection is enabled on the "line in" jack instead of the
"line out" (if I plug something on the "line in", the speakers are muted)
- if I play too much with these switches, the speakers stop working
until suspend/reboot

To fix the first issue I run "hdajacksensetest" to get the headphone
jack pin:
hdajacksensetest -c 1 -a
Pin 0x0b (Internal Speaker): present = Yes
Pin 0x0c (Not connected): present = No
Pin 0x0d (Not connected): present = No
Pin 0x0e (Not connected): present = No
Pin 0x0f (Not connected): present = Yes
Pin 0x10 (Not connected): present = No
Pin 0x11 (Black Line In, Left side): present = No
Pin 0x12 (Internal Mic, Mobile-In): present = No
Pin 0x13 (Not connected): present = No
Pin 0x18 (Not connected): present = No

and replaced the pin number:

--- /usr/src/linux-4.0.0-gentoo/sound/pci/hda/patch_ca0132.c.old       
2015-04-13 00:12:50.000000000 +0200
+++ /usr/src/linux-4.0.0-gentoo/sound/pci/hda/patch_ca0132.c   
2015-04-25 01:43:09.607531550 +0200
@@ -4625,7 +4625,7 @@
 
        spec->num_outputs = 2;
        spec->out_pins[0] = 0x0b; /* speaker out */
-       spec->out_pins[1] = 0x10; /* headphone out */
+       spec->out_pins[1] = 0x0f; /* default: 0x10 - headphone out -0x0f
on Alienware 15 2015 */
        spec->shared_out_nid = 0x2;
 
        spec->num_inputs = 3;

Now the "HP/Speaker Auto Detect" is ignored on both jacks, but I can
switch between headphones and speakers manually with the "HP/Speaker" item.

This is a dirty hack (and probably won't work on different cards), is
there a better way to fix this and get at least the jack detection working?

Regards,
Gabriele
