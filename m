From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: debugfs support improvement
Date: Wed, 30 Sep 2009 13:24:18 +0300
Message-ID: <1254306259-8098-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B704243B4
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 12:24:32 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

I have noticed that the support for multiple cards/codecs via the debugfs is
kind of broken.
The second codec, which tries to create the debugfs files would emit the
following messages:
ASoC: Failed to create codec register debugfs file
Failed to create pop time debugfs file
...

The following patch fixes this by adding a directory per codec to host the
files.
The additional directory is named as codec->name, so it is easier to find the
correct codec we are looking for.

---
Peter Ujfalusi (1):
  ASoC: add support for multiple cards/codecs in debugfs

 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)
