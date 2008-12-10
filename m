From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/3] ASoC: TWL4030: Fixes and small cleanup
Date: Wed, 10 Dec 2008 12:51:45 +0200
Message-ID: <1228906308-17374-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 87F7E2440F
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 11:52:49 +0100 (CET)
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
Cc: sakoman@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello,

The CarkitL/R DAPM output somehow got lost, the first patch adds it.
Really small cleanup for line wrap in the mux switch texts.
DAC names changed in order to avoid confusion with the mux switch names.

---
Peter Ujfalusi (3):
 ASoC: TWL4030: Add missing Carkit output
 ASoC: TWL4030: Small cleanup
 ASoC: TWL4030: Change the name for the DACs

 sound/soc/codecs/twl4030.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)
