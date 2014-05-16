From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/7] ASoC: max98090: Couple improvements and
	ACPI probing support
Date: Fri, 16 May 2014 16:55:18 +0300
Message-ID: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 31B0B26087D
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 15:55:32 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Here are couple improvements to MAX98090 codec driver. I think only 1/7
is a real fix and rest 2-7/7 are regular updates that make codec resume
working and add ACPI probing support on Intel Baytrail platform.

Jarkko Nikula (2):
  ASoC: max98090: Move microphone bias voltage setting to probe function
  ASoC: max98090: Add ACPI probing support

Liam Girdwood (5):
  ASoC: max98090: Fix digital sidetone gain TLV
  ASoC: max98090: Fix reset at resume time.
  ASoC: max98090: Reset codec on resume
  ASoC: max98090: Mark cache as dirty prior to restoring
  ASoC: max98090: Make sure we configure BCLK in one place

 sound/soc/codecs/max98090.c | 77 +++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/max98090.h |  1 +
 2 files changed, 65 insertions(+), 13 deletions(-)

-- 
2.0.0.rc0
