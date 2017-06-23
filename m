From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] Lenovo tablet fixes
Date: Fri, 23 Jun 2017 12:20:59 -0500
Message-ID: <20170623172101.29079-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0009F266AE2
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 19:21:17 +0200 (CEST)
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

2 patches to enable rt5670 on Baytrail and fix jack detection.
There are likely follow-up patches or UCM updates needed since
some users report additional problems with headphones and
subwoofers [1] but this is already working for a number of people.

[1] Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96691

Pierre-Louis Bossart (2):
  ASoC: Intel: cht_bsw_rt5672: 19.2MHz clock for Baytrail platforms
  ASoC: codecs: rt5670: fix jd mode for Lenovo Miix 2 10

 sound/soc/codecs/rt5670.c               |  9 ++++
 sound/soc/intel/boards/cht_bsw_rt5672.c | 89 +++++++++++++++++++++++++++++----
 2 files changed, 89 insertions(+), 9 deletions(-)

-- 
2.9.3
