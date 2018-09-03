From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: q6routing: initialize data correctly"
	to the asoc tree
Date: Mon,  3 Sep 2018 14:47:16 +0100 (BST)
Message-ID: <20180903134716.BC3FF11227AE@debutante.sirena.org.uk>
References: <20180903110747.10745-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D4462678B0
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:47:17 +0200 (CEST)
In-Reply-To: <20180903110747.10745-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: bgoswami@codeaurora.org, alsa-devel@alsa-project.org, broonie@kernel.org, rohitkr@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: q6routing: initialize data correctly

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7aa09ff24301535491cd4de1b93107ee91449a12 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 3 Sep 2018 12:07:47 +0100
Subject: [PATCH] ASoC: q6routing: initialize data correctly

Some of the router data fields are left as default zeros which are
valid dai ids, so initialize these to invalid value of -1.

Without intializing these correctly get_session_from_id() can return
incorrect session resulting in not closing the opened copp and messing
up with the copp ref count.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index dc94c5c53788..c6b51571be94 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -960,8 +960,10 @@ static int msm_routing_probe(struct snd_soc_component *c)
 {
 	int i;
 
-	for (i = 0; i < MAX_SESSIONS; i++)
+	for (i = 0; i < MAX_SESSIONS; i++) {
 		routing_data->sessions[i].port_id = -1;
+		routing_data->sessions[i].fedai_id = -1;
+	}
 
 	return 0;
 }
-- 
2.19.0.rc1
