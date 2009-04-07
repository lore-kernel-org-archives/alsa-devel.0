From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: Fix for compilation error
Date: Tue,  7 Apr 2009 09:13:59 +0300
Message-ID: <1239084840-16546-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 1525D2434F
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 08:14:20 +0200 (CEST)
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
Cc: sakoman@gmail.com, sfr@canb.auug.org.au, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

I'm really sorry for the trouble that this caused.

The patch provides fix for the compillation error, which is introduced by the
"ASoC: TWL4030: Add constrains for second stream" patch of mine...

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Compillation error fix

 sound/soc/codecs/twl4030.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)
