From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: TWL4030: bypass magic removal and
	cleanup patch
Date: Wed, 28 Oct 2009 10:57:03 +0200
Message-ID: <1256720225-6853-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 74F5F244FA
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 09:57:17 +0100 (CET)
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

Since the soc core is now handling the codec bias state based on the complete
paths as well, there is no need for the bypass tracking in the codec.
The second patch replaces the missleading codec_muted to apll_enabled, which
is what actually is handled by it.

This series applies on top of Mark's tree, for-2.6.33-pending branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

Since the underlying twl4030 patches are not yet in the topic/asoc of
Takashi's tree.

---
Peter Ujfalusi (2):
  ASoC: TWL4030: Remove bypass tracking
  ASoC: TWL4030: Change codec_muted to apll_enabled

 sound/soc/codecs/twl4030.c |  146 ++++++++++++--------------------------------
 1 files changed, 39 insertions(+), 107 deletions(-)
