From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 0/3] ASoC: topology: UAPI updates for TLV,
	ops and types
Date: Wed,  5 Aug 2015 14:41:12 +0100
Message-ID: <1438782075-19977-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A0669265E3F
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 15:41:26 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This series updates the topology UAPI to allow easier addition of new TLV
object types, generic operations and added a private data type for the kernel
topology core.

Changes since V1

 * Split into several patches for UAPI changes.
 * Fixed {} usage in if statement.
 * Added __le32 data[SND_SOC_TPLG_TLV_SIZE] back to struct snd_soc_tplg_ctl_tlv

Liam Girdwood (1):
  ASoC: topology: Add private data type and bump ABI version to 3

Mengdong Lin (2):
  ASoC: topology: Update TLV support so we can support more TLV types
  ASoC: topology: Add ops support to byte controls UAPI

 include/uapi/sound/asoc.h | 33 ++++++++++++++++++---------
 sound/soc/soc-topology.c  | 58 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 63 insertions(+), 28 deletions(-)

-- 
2.1.4
