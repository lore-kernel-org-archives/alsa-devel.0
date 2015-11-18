From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: fix info callback for TLV
	byte control" to the asoc tree
Date: Wed, 18 Nov 2015 13:13:35 +0000
Message-ID: <E1Zz2YJ-0006Bp-8Q@debutante>
References: <1447091401-24298-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 65C6526145E
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:13:49 +0100 (CET)
In-Reply-To: <1447091401-24298-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Omair M Abdullah <omair.m.abdullah@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: fix info callback for TLV byte control

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f4be978b9611c94f20cdc8cee540ef1a52f8875c Mon Sep 17 00:00:00 2001
From: Omair M Abdullah <omair.m.abdullah@intel.com>
Date: Mon, 9 Nov 2015 23:20:01 +0530
Subject: [PATCH] ASoC: topology: fix info callback for TLV byte control

topology core used wrong callback for TLV bytes control, it should be
snd_soc_bytes_info_ext and not snd_soc_bytes_info

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 8d7ec80af51b..50f21ed00cfa 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -531,7 +531,7 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 		/* TLV bytes controls need standard kcontrol info handler,
 		 * TLV callback and extended put/get handlers.
 		 */
-		k->info = snd_soc_bytes_info;
+		k->info = snd_soc_bytes_info_ext;
 		k->tlv.c = snd_soc_bytes_tlv_callback;
 
 		ext_ops = tplg->bytes_ext_ops;
-- 
2.6.2
