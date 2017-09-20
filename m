From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RESEND 0/3] Intel-rt5670 updates
Date: Tue, 19 Sep 2017 19:34:50 -0500
Message-ID: <20170920003453.16209-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D8D8E266D08
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 02:35:01 +0200 (CEST)
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
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

[when I started cleaning-up some patches reviewed by Andy Shevchenko,
I realized this initial batch has not been merged, although both
Takashi and Vinod reviewed them, see
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-September/125331.html
no change except for the addition of Takashi's Reviewed-by and Vinod's
Acked-by.  I don't mean to be pushy or anything, just checking if
something is missing ]

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
2.11.0
