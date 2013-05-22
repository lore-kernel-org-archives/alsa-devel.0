From: Stefano Panella <stefano.panella@citrix.com>
Subject: Problem opening default device in haswell system using
	aplay
Date: Wed, 22 May 2013 16:48:58 +0100
Message-ID: <519CE8EA.3010303@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D168260783
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 17:48:55 +0200 (CEST)
Received: from slimey.cam.xci-test.com ([10.80.249.177])	by
 norwich.cam.xci-test.com with esmtp (Exim 4.72)	(envelope-from
 <stefano.panella@citrix.com>)	id 1UfBHa-0008CE-DB	for
 alsa-devel@alsa-project.org; Wed, 22 May 2013 15:48:54 +0000
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

Hi everyone,

sorry if this email has been sent twice... ( I sent it once before subscribing)

I am working on some haswell systems running Ubuntu 12.04 and I have a problem if I run aplay -D sysdefault.

when I do:

cat /proc/asound/pcm

I get:

00-03: HDMI 0 : HDMI 0 : playback 1
00-07: HDMI 1 : HDMI 1 : playback 1
00-08: HDMI 2 : HDMI 2 : playback 1
01-00: ALC662 rev3 Analog : ALC662 rev3 Analog : playback 1 : capture 1
01-02: ALC662 rev3 Analog : ALC662 rev3 Analog : capture 1

If I do:

aplay -L | grep sysdefault

I get:

sysdefault:CARD=PCH

where PCH is card number 1 (id = 1)

on most of my systems (non haswell laptops) the default card is number 0

If I run

aplay -D sysdefault

I get:

ALSA lib pcm_dmix.c:1018:(snd_pcm_dmix_open) unable to open slave
aplay: main:682: audio open error: No such file or directory

if I strace it I get:

open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK|O_CLOEXEC) = -1 ENOENT (No
such file or directory)

If I run:

aplay -D hw:PCH,0

all works fine...

Any idea why hw:PCH,0 works and sysdefault does not?

I guess there could be a problem in the mapping of devices in hw systems?

Has anybody else observed a similar issue? Or has this been a problem in
the past already fixed upstream?
If so, where was it fixed (kernel, lib, tools, utils, etc.) ?

Thanks for all your help on this.

In case this is a real problem I am willing to help debugging it and
submit patches.

Stefano
