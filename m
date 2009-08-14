From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1 - v2] ASoC: TWL4030: Capture mixer string
	changes
Date: Fri, 14 Aug 2009 08:43:59 +0300
Message-ID: <1250228640-31829-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E07E01038FE
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Aug 2009 07:44:10 +0200 (CEST)
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

Resending with the suggested changes:

Before the patch the analog capture path strings ended up like this at the end:
"Analog Left Capture Route Main mic Switch"
These switches showed up in the playback tab of alsamixer, which was not nice.
After the patch the strings will be like this:
"Analog Left Main Mic Capture Switch"
Which show up correctly in alsamixer as "Analog Left Main mic" under the
capture tab.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Fix for capture mixer strings

 sound/soc/codecs/twl4030.c |   46 +++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 21 deletions(-)
