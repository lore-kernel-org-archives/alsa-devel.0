From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/11] ASoC: mmp-sspa: Staticize non exported
	struct
Date: Tue, 14 May 2013 22:19:52 +0200
Message-ID: <1368562797-10440-6-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id D23E326084D
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:26 +0200 (CEST)
In-Reply-To: <1368562797-10440-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Zhangfei Gao <zhangfei.gao@marvell.com>
List-Id: alsa-devel@alsa-project.org

The mmp_sspa_dai struct is only used in mmp-sspa.c, so make it static.

Cc: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/mmp-sspa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index a647799..62142ce 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -388,7 +388,7 @@ static struct snd_soc_dai_ops mmp_sspa_dai_ops = {
 	.set_fmt	= mmp_sspa_set_dai_fmt,
 };
 
-struct snd_soc_dai_driver mmp_sspa_dai = {
+static struct snd_soc_dai_driver mmp_sspa_dai = {
 	.probe = mmp_sspa_probe,
 	.playback = {
 		.channels_min = 1,
-- 
1.8.0
