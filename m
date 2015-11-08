From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ALSA: ctxfi: constify dao and dai rsc ops structures
Date: Sun,  8 Nov 2015 23:06:49 +0100
Message-ID: <1447020409-3022-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The dao and dai rsc ops structures are never modified, so declare them as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/pci/ctxfi/ctdaio.c |    4 ++--
 sound/pci/ctxfi/ctdaio.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index 9b87dd2..2221d7c 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -263,7 +263,7 @@ static int dao_clear_right_input(struct dao *dao)
 	return 0;
 }
 
-static struct dao_rsc_ops dao_ops = {
+static const struct dao_rsc_ops dao_ops = {
 	.set_spos		= dao_spdif_set_spos,
 	.commit_write		= dao_commit_write,
 	.get_spos		= dao_spdif_get_spos,
@@ -318,7 +318,7 @@ static int dai_commit_write(struct dai *dai)
 	return 0;
 }
 
-static struct dai_rsc_ops dai_ops = {
+static const struct dai_rsc_ops dai_ops = {
 	.set_srt_srcl		= dai_set_srt_srcl,
 	.set_srt_srcr		= dai_set_srt_srcr,
 	.set_srt_msr		= dai_set_srt_msr,
diff --git a/sound/pci/ctxfi/ctdaio.h b/sound/pci/ctxfi/ctdaio.h
index 0ebbf35..a30be73 100644
--- a/sound/pci/ctxfi/ctdaio.h
+++ b/sound/pci/ctxfi/ctdaio.h
@@ -51,7 +51,7 @@ struct daio {
 
 struct dao {
 	struct daio daio;
-	struct dao_rsc_ops *ops;	/* DAO specific operations */
+	const struct dao_rsc_ops *ops;	/* DAO specific operations */
 	struct imapper **imappers;
 	struct daio_mgr *mgr;
 	struct hw *hw;
@@ -60,7 +60,7 @@ struct dao {
 
 struct dai {
 	struct daio daio;
-	struct dai_rsc_ops *ops;	/* DAI specific operations */
+	const struct dai_rsc_ops *ops;	/* DAI specific operations */
 	struct hw *hw;
 	void *ctrl_blk;
 };
