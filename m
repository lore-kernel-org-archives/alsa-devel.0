From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Control vs Device
Date: Tue, 27 Apr 2010 16:47:20 +1000
Message-ID: <z2zcb44e8371004262347qc9c225ebva610b998b0df9632@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C568624816
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 08:47:23 +0200 (CEST)
Received: by pxi13 with SMTP id 13so1750294pxi.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 23:47:21 -0700 (PDT)
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

Hi.

Currently maintaining the audio code on the MythTV project...

Lately, I've had reports on issues by users when using digital audio.

This for some reasons however fails, unless the device opened is
something like : IEC958:{AES0: 0x06}

When we are about to configure a digital audio stream, we do the
equivalent of what iecset does. So I would have thought that our code
should work under most circumstances...

Then I started to suspect the code setting the IEC958_AES0_NONAUDIO bit.

We always open the "default" controller like so:
snd_ctl_open(&ctl, "default", 0)

I thought that maybe the issue is that the "default" controller isn't
the one to open.

Is there a way, from the name of the device card ; to retrieve which
controller is used?

So before opening a specific ALSA audio device, I find the
corresponding controller, set the flag non-audio on it and continue as
usual..

I couldn't find any functions nor documentation that would help me
achieve such results..

Any hints would be greatly appreciated...

Thank you !!
Jean-Yves
