From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 0/4] small fixes during code reading
Date: Wed, 20 Apr 2011 16:00:32 +0800
Message-ID: <20110420075859.11377.67437.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id B0DE4243BD
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 09:59:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following patches are fixed during my own code reading.
These are quite trivial, most are style fixes.

These patches are based on Mark Brown's for-2.6.40 branch.

---

Lu Guanqun (4):
      ASoC: fix a simple coding style issue
      ASoC: remove unused comment
      ASoC: simple style fix
      ASoC: fix two ident style problems


 include/sound/soc-dapm.h |    2 +-
 sound/soc/soc-cache.c    |    1 -
 sound/soc/soc-core.c     |    4 ++--
 sound/soc/soc-dapm.c     |    2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

-- 
guanqun
