From: Douglas Mencken <dougmencken@gmail.com>
Subject: snd-powermac @ G4 DA (PowerMac3,
	4) - headphone detection doesn't work
Date: Tue, 23 Feb 2010 17:20:58 +0100
Message-ID: <29bea45b1002230820m5111e0cu6006e6636201049e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f213.google.com (mail-bw0-f213.google.com
	[209.85.218.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 643B824392
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 17:21:00 +0100 (CET)
Received: by bwz5 with SMTP id 5so5225384bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 08:20:59 -0800 (PST)
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

I can hear sound with internal speakers only if I plug headphones
jack, without plugged jack, there's no sound at all; to listen thru
headphones, I need to half-insert that jack and this leads to
distortions; with h/phones jack plugged fully, no sound in phones, but
sound in internal speaker. With the same half-plug, in OS X I head
sound both via h/phones and internal speaker.
Driver: snd-powermac. Audio card: Tumbler @ i2ca @ KeyLargo i2c (I can
provide the full dump of OpenFirmware device tree).

As <gnubien> at #alsa @ irc.freenode.net suggested, I ran `alsamixer
-c 0` and MM-ed 'Auto Mute'. After that, I can fully plug h/phones
jack and enjoy full sounds w/o distortions but still can't get any
sound when it's unplugged.

The result of running ./alsa-info.sh:
Your ALSA information is located at
http://www.alsa-project.org/db/?f=daac9e06cbe772222b90d7fba14c1a49a65b980c
