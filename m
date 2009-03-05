From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: Add mixer control for the
	HS ramp delay
Date: Thu,  5 Mar 2009 12:48:48 +0200
Message-ID: <1236250129-2533-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 89189103866
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 11:49:04 +0100 (CET)
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following patch adds user control for the desired ramp delay used on the
Headset output - it has been hardwired to use 874/645/437 ms.

The actuall delay depends on the MCLK frequency, for example:
value 0x0 in RAMP_DELAY means 2^19/f(MCLK), which is:
27 ms when the f(MCLK) = 19.2 MHz
20 ms when the f(MCLK) = 26 MHz
14 ms when the f(MCLK) = 38.4 MHz

value 0x5 in RAMP_DELAY means 2^24/f(MCLK), which is:
874 ms when the f(MCLK) = 19.2 MHz
645 ms when the f(MCLK) = 26 MHz
437 ms when the f(MCLK) = 38.4 MHz

I think having the actual ms values in the enums are makes more sense than to
have the calculation ("2^24/F(MCLK)" for example).

If one can suggest more descriptive name, I would love to change the texts.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Make the HS ramp delay configurable

 sound/soc/codecs/twl4030.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)
