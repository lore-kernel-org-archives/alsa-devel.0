From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Change the base value of
	compress_type
Date: Thu,  2 Dec 2010 14:53:02 +0000
Message-ID: <1291301583-15491-3-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D45DE103840
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 15:53:12 +0100 (CET)
In-Reply-To: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Ensure that the base value of compress_type starts at 1 so that
we know whether the machine driver has provided a compress_type
for overriding the codec supplied one.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 838ad36..a26cdf9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -256,7 +256,7 @@ enum snd_soc_control_type {
 };
 
 enum snd_soc_compress_type {
-	SND_SOC_FLAT_COMPRESSION,
+	SND_SOC_FLAT_COMPRESSION = 1,
 	SND_SOC_LZO_COMPRESSION,
 	SND_SOC_RBTREE_COMPRESSION
 };
-- 
1.7.3.2
