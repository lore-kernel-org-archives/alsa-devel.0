From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 0/2] Give the N_AMSDELTA line discipline more generic name
Date: Thu, 6 Aug 2009 13:06:26 +0200
Message-ID: <200908061306.27639.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, e3-hacking@earth.li, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This series of patches renames the N_AMSDELTA line discipline, used by the 
Amstrad Delta ASoC machine driver and the CX20442 ASoC codec driver for 
controlling the CX20442 voice codec over the CX81801 voice modem, giving it a 
more generic name: N_V253. The name has been chosen after the voice modem 
standard codename V.253.

I think that even if the code of the line discipline is currently implemented 
inside those two specific drivers, the idea, if not the code, could be reused 
with other similar hardware configurations, if necessary.

As the line discipline is conceived to be registered from a machine driver, 
there should be no conflicts, even if used by several different drivers that 
happen to be be built-in side-by-side.

[PATCH 1/2] TTY: Rename N_AMSDELTA line discipline to N_V253
[PATCH 2/2] ASoC: AMS_DELTA: Use updated line discipline name

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
