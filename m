From: Dominique Bureau <dbureau@gmail.com>
Subject: snd_hda_intel: live-reconfiguring codec possible while
	in use?
Date: Wed, 21 Feb 2018 16:10:04 -0500
Message-ID: <CAFxx+qPZ6mWSgMGN1R86fQyu1p-k1Y50NbbumD5B_B53iwpKMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 87142267660
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 22:10:07 +0100 (CET)
Received: by mail-ua0-f170.google.com with SMTP id n48so1959764uae.13
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 13:10:06 -0800 (PST)
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

I'm trying to figure out if there would be any sane way to perform codec
reconfiguration live, without requiring to stop/disconnect all running
applications. Currently, sound/pci/hda/hda_codec.c: snd_hda_codec_reset()
doesn't allow to be called while the device is in use (returns -EBUSY). I'm
looking for some advice before digging further.


We're currently in the final phase of a product design and noticed some
audio instability when the system is subjected to ESD. The issue seems to
be that the codec (Realtek ALC892) falls in an unknown state and stops
communicating properly with the audio controller (Intel Sunrise Point-H HD
Audio, as reported by lspci).

Whenever this happens, all capture device buffers and pointers from in
/proc/asound/card0/pcm0c/sub0/status fall to 0 like so:
-----------------------
state: RUNNING
owner_pid   : 1384
trigger_time: 104807.286533210
tstamp      : 104807.292766671
delay       : 0
avail       : 0
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 0
-----------------------

Reloading snd_hda_intel or reconfiguring the codec (using
CONFIG_SND_HDA_RECONFIG' /sys/class/sound/hwC0D1/reconfig) brings it back
on its feet, but this requires stopping all applications.

Kernel is 4.9.61, and we are using jackd version 0.125.0.


If anyone has any pointers about this, I'm all ears!

Thanks,
Dominique Bureau
