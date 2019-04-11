From: libin.yang@intel.com
Subject: [PATCH v2 00/12] ASoC: intel: add device_link to HDMI
	audio
Date: Thu, 11 Apr 2019 22:09:41 +0800
Message-ID: <1554991793-14851-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66A62F89616
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 16:25:55 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Cc: libin.yang@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patchset add the device_link between the machine devices
of intel boards and HDMI audio codec. This can make sure that
display audio power domain is always turned on before operating
on the HDMI audio codecs.

Libin Yang (12):
  ASoC: intel: skl_hda_dsp_generic: add device_link to HDMI audio
  ASoC: intel: boards: define some general functions for hdac_hdmi
  ASoC: intel: bxt_da7219_max98357a: add device_link to HDMI audio
  ASoC: intel: bxt_rt298: add device_link to HDMI audio
  ASoC: intel: glk_rt5682_max98357a: add device_link to HDMI audio
  ASoC: intel: kbl_da7219_max98357a: add device_link to HDMI audio
  ASoC: intel: kbl_da7219_max98927: add device_link to HDMI audio
  ASoC: intel: kbl_rt5660: add device_link to HDMI audio
  ASoC: intel: kbl_rt5663_max98927 add device_link to HDMI audio
  ASoC: intel: kbl_rt5663_rt5514_max98927 add device_link to HDMI audio
  ASoC: intel: skl_nau88l25_max98357a add device_link to HDMI audio
  ASoC: intel: skl_nau88l25_ssm4567 add device_link to HDMI audio

 sound/soc/intel/boards/bxt_da7219_max98357a.c      | 14 +++++++
 sound/soc/intel/boards/bxt_rt298.c                 | 14 ++++++-
 sound/soc/intel/boards/glk_rt5682_max98357a.c      | 14 +++++++
 sound/soc/intel/boards/hdac_hdmi_common.h          | 46 ++++++++++++++++++++++
 sound/soc/intel/boards/kbl_da7219_max98357a.c      | 14 +++++++
 sound/soc/intel/boards/kbl_da7219_max98927.c       | 14 +++++++
 sound/soc/intel/boards/kbl_rt5660.c                | 14 ++++++-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       | 14 ++++++-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 14 ++++++-
 sound/soc/intel/boards/skl_hda_dsp_common.c        | 22 +++++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h        |  1 +
 sound/soc/intel/boards/skl_hda_dsp_generic.c       | 12 ++++++
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    | 36 ++++++++++++++++-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      | 36 ++++++++++++++++-
 14 files changed, 259 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/intel/boards/hdac_hdmi_common.h

-- 
2.7.4
