From: Damien Zammit <damien.zammit@gmail.com>
Subject: - snd-usb-audio - SPDIF clock source mixer control for
 Digidesign Mbox
Date: Wed, 29 Oct 2014 21:21:29 +1100
Message-ID: <5450BFA9.1090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 743A12604C9
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 11:21:34 +0100 (CET)
Received: by mail-pd0-f175.google.com with SMTP id y13so2697411pdi.6
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 03:21:33 -0700 (PDT)
Received: from [192.168.140.2] (14-201-185-176.static.tpgi.com.au.
 [14.201.185.176])
 by mx.google.com with ESMTPSA id fy4sm3941752pbb.42.2014.10.29.03.21.31
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 29 Oct 2014 03:21:32 -0700 (PDT)
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

Hi all,

As some of you may remember, the Digidesign Mbox has a multiple endpoint
interface and does not follow the standard USB audio spec.
I am pretty sure that the first interface 0 is for firmware upgrades
only, and the second interface has 2 endpoints one for playback and one
for capture.

I have heard that the SPDIF output is always on, but there is a special
command to change the clock source to external sync with SPDIF.

I think I have found the correct USB command for changing the clock
source of the device to SPDIF external sync.  I tried to use a pair of
the devices in JACK using a pcm_multi configuration and syncing one of
them to the other with a RCA cable, but unfortunately I get lots of
XRUNs in JACK and I am wondering if there is a reason for this?

Can someone who knows about the pcm_multi stuff shed some light on why I
might be getting thousands of XRUNs when I use two identical USB
soundcards that are (hopefully) synced to each other?

I have written a non-standard mixer control for this so alsamixer can
select the external clock source.

Basically, the command to set SPDIF sync seems to include a sample rate
command, but the sample rate is set to zero for SPDIF sync.  Could JACK
be resetting the sample rate and overriding my command perhaps?  How
would I override the ALSA driver code so that the sample rate is not
reset by JACK to 48000 instead of 0 but only when the mixer control sets
the flag?

Damien
