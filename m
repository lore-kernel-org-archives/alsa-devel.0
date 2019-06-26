From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 0/3] SOF PM and jack detection fixes
Date: Wed, 26 Jun 2019 13:22:26 -0700
Message-ID: <20190626202229.16312-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBC24F806F0
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 22:22:32 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This set of patches addresses issues related to runtime
suspend and jack detection during runtime suspend.

The first 2 patches handle enabling WAKEEN in the SOF
driver to address issue with jack detection when the
SOF device is runtime suspended. More details about the
issue can be found here:
https://github.com/thesofproject/linux/issues/909

The third patch allows the SOF driver to suspend after
the autosuspend delay instead of suspending immediately
upon boot.

Pan Xiuli (1):
  ASoC: SOF: mark last_busy value at runtime PM init

Rander Wang (2):
  ASoC: SOF: Intel: hda: reduce ifdef usage for hda
  ASoC: SOF: Intel: hda: Enable jack detection in sof hda driver

 sound/soc/sof/intel/hda-codec.c | 45 +++++++++++++++++++++++++++--
 sound/soc/sof/intel/hda-dsp.c   | 51 +++++++++++++++++++++------------
 sound/soc/sof/intel/hda.h       |  4 +++
 sound/soc/sof/sof-pci-dev.c     |  3 ++
 4 files changed, 83 insertions(+), 20 deletions(-)

-- 
2.17.1
