From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [RESEND PATCH v2 0/2] ASoC: topology: Add parsing
	clock gating
Date: Tue, 20 Feb 2018 18:44:44 +0100
Message-ID: <20180220174446.7784-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27FF5267502
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 18:44:39 +0100 (CET)
Received: by mail-wr0-f193.google.com with SMTP id 34so16744710wre.13
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 09:44:39 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch series adds parsing the topology clock gating parameter, which
is currently can be set by alsa-lib, but ignored by kernel.

The patch 1/2 modifies the UAPI header. If it is applied, the corresponded
patch should be applied in alsa-lib [2].

Related, but not required alsa-lib patch: [1].

[1]. [alsa-lib,v2,1/2] topology: Fix parsing config with multiple
  hw_configs
[2]. [alsa-lib,v2,2/2] ASoC: topology: Add defines for
  snd_soc_tplg_hw_config.clock_gated

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

Kirill Marinushkin (2):
  ASoC: topology: Add defines for snd_soc_tplg_hw_config.clock_gated
  ASoC: topology: Add missing clock gating parameter when parsing
    hw_configs

 include/uapi/sound/asoc.h | 7 ++++++-
 sound/soc/soc-topology.c  | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.13.6
