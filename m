From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] Lenovo Thinkpad quirks
Date: Mon, 17 Apr 2017 10:04:06 -0500
Message-ID: <20170417150408.20935-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E6B71266872
 for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2017 17:04:27 +0200 (CEST)
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

Minor update to support new skews and need to manage quirks in codec
driver for jack detection to work.

Nicole Faerber (1):
  ASoC: codecs: rt5670: add Thinkpad Tablet 10 quirk

Pierre-Louis Bossart (1):
  ASoC: Intel: Atom: update Thinkpad 10 quirk

 sound/soc/codecs/rt5670.c           | 21 +++++++++++++++++++++
 sound/soc/intel/atom/sst/sst_acpi.c | 16 +++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.9.3
