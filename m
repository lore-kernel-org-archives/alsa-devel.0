From: Rander Wang <rander.wang@linux.intel.com>
Subject: [PATCH 0/3] ASoC: hda: capture-related fixes
Date: Fri,  8 Mar 2019 16:38:56 +0800
Message-ID: <20190308083859.50026-1-rander.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70305F80724
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 09:37:35 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There are several sources of errors fixed in this series, such as mismatch
between TX and RX mask used to store the stream_tag, the use of hw_param
fixups not properly handled in the hdac_hda codec and registers set on capture
when they should only be used on playback. 

The first patch fixes a issue caused by tx|rx_mask for TDM.
The Second one fixes the mismatch between BE dai format and hda codec format.
The last one removes the register of stream id setting on capture. 

this series was tested successfully with the Intel Skylake driver on a Skylake
Dell XPS13 (same as Linus), KabyLake NUC, Whiskylake laptop and Apollolake LeafHill
board. The two soc-pcm and hdac_hda fixes are needed by the SOF driver as well, but
SOF-specific patches will be provided in the next batch and are not included here

Rander Wang (3):
  ASoC:soc-pcm:fix a codec fixup issue in TDM case
  ASoC:hdac_hda:use correct format to setup hda codec
  ASoC:intel:skl:fix a simultaneous playback & capture issue on hda platform

 sound/soc/codecs/hdac_hda.c       | 53 ++++++++++++++++++++++++++++-----------
 sound/soc/codecs/hdac_hda.h       |  1 +
 sound/soc/intel/skylake/skl-pcm.c | 19 ++++++++++----
 sound/soc/soc-pcm.c               |  7 ++++--
 4 files changed, 59 insertions(+), 21 deletions(-)

-- 
2.14.1
