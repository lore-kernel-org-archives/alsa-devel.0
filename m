From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: Using codec_regcache in
	twl4030_init_chip
Date: Fri, 29 May 2009 09:22:36 +0300
Message-ID: <1243578157-27690-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 8500924471
	for <alsa-devel@alsa-project.org>;
	Fri, 29 May 2009 08:23:07 +0200 (CEST)
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

The twl4030_init_chip used the twl4030_reg array directly to set the default
register values.
In other places the defaults has been modified in the codec->reg_cache (prime
example is the Headset ramp delay configuration).

Switch using the codec->reg_cache in the twl4030_init_chip function, so updated
defaults will be actually used.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Use reg_cache in twl4030_init_chip

 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
