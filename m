From: libin.yang@intel.com
Subject: [RFC PATCH 0/4] ASoC: hdac_hdmi: refine the hdac_hdmi
	jacks
Date: Mon, 27 May 2019 17:07:23 +0800
Message-ID: <1558948047-18930-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09DEDF8065A
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2019 11:27:34 +0200 (CEST)
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
Cc: tiwai@suse.de, libin.yang@intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patchset refines the hdac_hdmi jacks:
1. kctl setting should not impact on hdmi jack status
2. bind jack to pin-port instead of pcm
3. move creating jack into hdac_hdmi from machine drivers

Libin Yang (4):
  ASoC: hdac_hdmi: amixer kctl setting should not impact on jack status
  ASoC: hdac_hdmi: jack_event represents the status
  ASoC: hdac_hdmi: refine hdmi jacks
  ASoC: hdac_hdmi: fix some coding style issue

 sound/soc/codecs/hdac_hdmi.c                       | 176 +++++++++++----------
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  10 --
 sound/soc/intel/boards/bxt_rt298.c                 |  10 --
 sound/soc/intel/boards/glk_rt5682_max98357a.c      |  10 --
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |  10 --
 sound/soc/intel/boards/kbl_da7219_max98927.c       |  10 --
 sound/soc/intel/boards/kbl_rt5660.c                |  10 --
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |  10 --
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   9 --
 sound/soc/intel/boards/skl_hda_dsp_common.c        |   9 --
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |  11 --
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |  11 --
 sound/soc/intel/boards/skl_rt286.c                 |  10 --
 sound/soc/intel/boards/sof_rt5682.c                |  11 --
 14 files changed, 92 insertions(+), 215 deletions(-)

-- 
2.7.4
