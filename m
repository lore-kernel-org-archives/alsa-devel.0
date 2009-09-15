From: Anders Kirchenbauer <ack0954@gmail.com>
Subject: Radeon RV730 (Radeon HD 4670) not playing back
Date: Tue, 15 Sep 2009 19:06:59 -0400
Message-ID: <4AB01E13.3070205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f177.google.com (mail-qy0-f177.google.com
	[209.85.221.177])
	by alsa0.perex.cz (Postfix) with ESMTP id E1F1C2415E
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 01:07:03 +0200 (CEST)
Received: by qyk7 with SMTP id 7so5467qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2009 16:07:03 -0700 (PDT)
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

I am unable to have sound playback through HDMI, presumably because 
there is no PCM codec support with the current state of my driver.  An 
alsa-info.sh dump is below, and below that a pastebin.ca of speaker-test

http://www.alsa-project.org/db/?f=2e2c6ba9f4052ef0a2defc25688067d597737af9

http://pastebin.ca/1567621

Also, changing the PCI ID to 1002aa38 in the two places in 
patch_atihdmi.c resulted in no sound or mixer device being available 
when the drivers were loaded. Went back to distro-default drivers 
afterwards.

Only IEC958 Mute/Unmute control works, rest are permission denied.  All 
permission denied are denied under user and root accounts.

alsamixer defines card as "ATI R6xx HDMI"
