From: mengdong.lin@intel.com
Subject: [PATCH v2 0/8] ASoC: topology: ABI - Add support for
	PCM, BE & CC link
Date: Wed, 30 Sep 2015 17:28:09 +0800
Message-ID: <cover.1443605139.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CE3C1265A8C
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 11:13:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@intel.com, vedang.patel@intel.com, subhransu.s.prusty@intel.com, vinod.koul@intel.com, jeeja.kp@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This series includes topology ABI update to support PCM (FE DAI/DAI links),
BE and CC DAI links. Bump the ABI version to 4.

Mengdong Lin (2):
  ASoC: topology: ABI - Change stream formats to a bitwise flag
  ASoC: topology: ABI - Remove tdm_slot & dai_fmt from
    snd_soc_tplg_stream

Vedang Patel (6):
  ASoC: topology: ABI - Add PCM Support and bump ABI version to 4
  ASoC: topology: ABI - Remove unused struct snd_soc_tplg_stream_config
  ASoC: topology: ABI - Use __le32 instead of __u32 in
    snd_soc_tplg_dapm_widget
  ASoC: topology: ABI - Add name element to snd_soc_tplg_stream
  ASoC: topology: ABI - Add the type for BE DAI link
  ASoC: topology: ABI - Add configuration for BE & Codec-Codec DAI Links

 include/uapi/sound/asoc.h | 76 +++++++++++++++++++++++++----------------------
 sound/soc/soc-topology.c  |  4 +--
 2 files changed, 43 insertions(+), 37 deletions(-)

-- 
1.9.1
