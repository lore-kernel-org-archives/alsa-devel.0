From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs43130: Fix possible Oops with invalid
	dev_id" to the asoc tree
Date: Mon, 04 Sep 2017 15:49:41 +0100
Message-ID: <E1dosh3-0006VK-NP@debutante>
References: <20170904131445.32438-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7522817559022124297=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AD88A26704E
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 16:49:42 +0200 (CEST)
In-Reply-To: <20170904131445.32438-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============7522817559022124297==
Content-Type: text/plain

The patch

   ASoC: cs43130: Fix possible Oops with invalid dev_id

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

>From f31877a16b0926dea4d1d9b72917a3eca9be19b6 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 4 Sep 2017 15:54:47 +0200
Subject: [PATCH] ASoC: cs43130: Fix possible Oops with invalid dev_id
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As compiler spotted out, there is the potential NULL-dereference in
the code when dc-measure OF is given for other than 43130/43131:
  sound/soc/codecs/cs43130.c:2089:18: warning: ‘hpload_seq’ may be used uninitialized in this function [-Wmaybe-uninitialized]

Warn it and return before triggering Oops.

Fixes: 8f1e5bf9b440 ("ASoC: cs43130: Add support for CS43130 codec")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs43130.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 9f1aa0516fd0..4229a95e2859 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2079,6 +2079,10 @@ static void cs43130_imp_meas(struct work_struct *wk)
 	case CS43131_CHIP_ID:
 		hpload_seq = hpload_seq2;
 		seq_size = ARRAY_SIZE(hpload_seq2);
+		break;
+	default:
+		WARN(1, "Invalid dev_id for meas: %d", cs43130->dev_id);
+		return;
 	}
 
 	i = 0;
-- 
2.14.1


--===============7522817559022124297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7522817559022124297==--
