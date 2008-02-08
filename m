From: "William Juul" <william@juul.no>
Subject: snd-dummy and snd_pcm_new()
Date: Fri, 8 Feb 2008 13:20:20 +0100
Message-ID: <2563ac9e0802080420t21ed9b24l390d89f9329b4428@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 44CFD243B1
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 13:20:21 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so387934wag.8
	for <alsa-devel@alsa-project.org>; Fri, 08 Feb 2008 04:20:20 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am using snd-dummy on a NGW100 card with buildroot
provided by Atmel. The alsa version is 1.0.14a and the kernel is
2.6.23.

I have compiled three versions of the snd-dummy driver: the original,
one with capture_count=0 and one
with playback_count=0.
When I use snd_pcm_new() with playback_count=0, there will be no PCM
devices other than the "null" (see below).
Is this expected?
Can I still capture from this driver (and a real driver with the same symptoms)?

Best regards
William Juul

Listings (annotated):

(with original snd-dummy
and
modified snd-dummy to use capture_count=0)

# modprobe snd-dummy
#
# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: Dummy [Dummy], device 0: Dummy PCM [Dummy PCM]
 Subdevices: 8/8
 Subdevice #0: subdevice #0
 Subdevice #1: subdevice #1
 Subdevice #2: subdevice #2
 Subdevice #3: subdevice #3
 Subdevice #4: subdevice #4
 Subdevice #5: subdevice #5
 Subdevice #6: subdevice #6
 Subdevice #7: subdevice #7
#
# arecord -L
default:CARD=Dummy
   Dummy, Dummy PCM
   Default Audio Device
null
   Discard all samples (playback) or generate zero samples (capture)

# reboot
..
(with modified snd-dummy to use playback_count=0)
# modprobe snd-dummy
# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: Dummy [Dummy], device 0: Dummy PCM [Dummy PCM]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
# arecord -L
null
    Discard all samples (playback) or generate zero samples (capture)
#
