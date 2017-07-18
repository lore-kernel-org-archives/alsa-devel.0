From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] ASoC: rt5677: Few clean ups to the
	driver
Date: Tue, 18 Jul 2017 20:34:16 +0300
Message-ID: <20170718173419.65980-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DBFBF2671F9
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 19:35:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, John Keeping <john@metanate.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This series removes legacy and unused platform data along with fixing
code which compiler complains about.

In v2:
- fix compilation error (kbuild bot)
- add couple more patches to fix the code according to compile complains

Andy Shevchenko (3):
  ASoC: rt5677: Hide platform data in the module sources
  ASoC: rt5677: Refactor code to avoid comparison unsigned >= 0
  ASoC: rt5677: Remove never used variables

 include/sound/rt5677.h    | 45 --------------------------
 sound/soc/codecs/rt5677.c | 81 ++++++++++++++++++++++-------------------------
 sound/soc/codecs/rt5677.h | 30 +++++++++++++++++-
 3 files changed, 67 insertions(+), 89 deletions(-)
 delete mode 100644 include/sound/rt5677.h

-- 
2.11.0
