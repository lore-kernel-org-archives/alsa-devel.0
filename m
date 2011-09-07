From: Mans Rullgard <mans.rullgard@linaro.org>
Subject: ASoC: auto-loading board-specific modules
Date: Wed, 7 Sep 2011 23:16:47 +0100
Message-ID: <CAG5Tg6VzdgPLG4L9how4-L8SJHVrEk+Twh9QcKnVF_-rVPka+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f50.google.com (mail-gw0-f50.google.com [74.125.83.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 1198424344
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 00:16:48 +0200 (CEST)
Received: by gwj16 with SMTP id 16so144039gwj.23
	for <alsa-devel@alsa-project.org>; Wed, 07 Sep 2011 15:16:47 -0700 (PDT)
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

Currently in ASoC, there is for each supported board a module describing the
board-specific DAI links by creating a "soc-audio" platform device with an
associated struct snd_soc_card.

The problem with this is that these modules are not automatically loaded
by udev (or other device-scanning mechanisms) so some intervention is
required before sound will work.

I can think of a few different ways to make everything happen automatically:

1. Build the board-specific bits into the platform modules which are
   already loaded as platform drivers.

2. Create another platform device whose only function is to cause the board
   modules to be loaded.

3. Something entirely different.

Someone had a recollection of the current scheme being introduced as a
"temporary" solution a couple of years ago, in which case it is about
time it got fixed.

I'd appreciate some input on which direction to pursue this before spending
time on a potentially inappropriate solution.

--
Mans Rullgard
Multimedia
mans.rullgard@linaro.org
