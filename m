From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: VIBRA output support
Date: Tue,  5 May 2009 08:55:46 +0300
Message-ID: <1241502947-18151-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C17782443B
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 07:56:05 +0200 (CEST)
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

The VIBRA output can be driven with audio data or with local vibrator driver,
the following patch adds VIBRA output support (for driving the VIBRA output
with audio data) for the TWL4030 codec.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Add VIBRA output

 sound/soc/codecs/twl4030.c |   61 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
