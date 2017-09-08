From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] Intel-rt5670 updates
Date: Thu,  7 Sep 2017 20:12:53 -0500
Message-ID: <20170908011256.7706-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B808266ED0
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 03:13:20 +0200 (CEST)
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
Cc: tiwai@suse.de, bardliao@realtek.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

Instead of submitting all my patches at ones, I broke them by
platforms/codecs. This series is only for Intel-rt5670 platforms. It
fixes a mistake on the Dell Venue 5585 - corrected with the help from
Realtek and Dell who kindly provided schematics and data sheet
information needed to fix non-working DMIC capture. Since there are
still some reports of non-functional audio on some platforms, I added
quirks that can be changed from the kernel command line (and later
added as DMI-based quirks). The last two patches are minor corrections
to fix ACPI HID naming issues and use a more meaningful card name.

Pierre-Louis Bossart (3):
  ASoC: rt5670: refactor DMI quirks and fix Dell Venue settings
  ASoC: Intel: cht_bsw_rt5672: use actual HID in suspend/resume
  ASoC: Intel: cht_bsw_rt5672: fix card name

 sound/soc/codecs/rt5670.c               | 124 +++++++++++++++++++++++++++-----
 sound/soc/intel/boards/cht_bsw_rt5672.c |  10 ++-
 2 files changed, 112 insertions(+), 22 deletions(-)

-- 
2.9.3
