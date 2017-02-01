From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] Baytrail/Cherrytrail audio fixes - take2
Date: Wed,  1 Feb 2017 12:27:03 -0600
Message-ID: <1485973625-20553-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 20DDD2674E1
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 19:27:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Correction to previous series (applies on top for Mark's for-next)
 - better handling of missing gpiod, continue only on -ENOENT
 - compiler warning

Pierre-Louis Bossart (2):
  ASoC: rt5645: fix error handling for gpio detection
  ASoC: cht-bsw-rt5645: fix unused variable compiler warning

 sound/soc/codecs/rt5645.c               | 10 ++++++++--
 sound/soc/intel/boards/cht_bsw_rt5645.c |  1 -
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.7.4
