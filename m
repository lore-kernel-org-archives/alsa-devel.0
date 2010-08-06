From: Truong Hoang <truonghn@gmail.com>
Subject: ALSA: How to create multiple cards?
Date: Thu, 5 Aug 2010 20:11:26 -0700
Message-ID: <AANLkTinRfPUww40Ar3iB07rkkHWnRLUH-Hdcc29pTrS1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1C69824436
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 05:11:26 +0200 (CEST)
Received: by qwi2 with SMTP id 2so4739221qwi.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 20:11:26 -0700 (PDT)
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

Hi all,


I have a problem that I need help from the ALSA experts.

I want to write an alsa shim .ko which creates multiple cards. Let's assume
2 cards. My program calls
snd_card_create() and snd_card_register() two times. I also has 1 PCM for
each of these card.

After install the .ko to the kernal, I see the /proc/asound has card0 and
card1. But the "aplay -l" sees only card0. The snd_card_next() only returns
0 (i.e. 1 card).
What did I miss in my program? The /dev/snd/ has only hwC0D0 and pcmD0C0p.

I am a beginner in ALSA, so I appreciate if you can give the explanation in
detail.


Thank you,
