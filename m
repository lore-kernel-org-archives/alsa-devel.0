From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: fix analog right microphone
	path
Date: Tue, 19 May 2009 10:51:02 +0300
Message-ID: <1242719463-17508-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id AADCE24672
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 09:51:14 +0200 (CEST)
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

Here is the fix for AUXR recording that Anuj reported.
Bit 2 is selecting the AUXR input in the ANAMICR register and not bit 1.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Fix Analog capture path for AUXR

 sound/soc/codecs/twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
