From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] of: add empty of_find_node_by_path() for !OF
Date: Wed, 16 Apr 2014 10:49:20 +0400
Message-ID: <1397630960-26677-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.mail.ru (smtp1.mail.ru [94.100.176.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 8001A2616B4
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 08:49:37 +0200 (CEST)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add an empty version of of_find_node_by_path().
This fixes following build error for asoc tree:
sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
sound/soc/fsl/fsl_ssi.c:1471:2: error: implicit declaration of function 'of_find_node_by_path' [-Werror=implicit-function-declaration]
  sprop = of_get_property(of_find_node_by_path("/"), "compatible", NULL);

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 include/linux/of.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 919bf21..3bad8d1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -374,6 +374,11 @@ static inline struct device_node *of_find_matching_node_and_match(
 	return NULL;
 }
 
+static inline struct device_node *of_find_node_by_path(const char *path)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_parent(const struct device_node *node)
 {
 	return NULL;
-- 
1.8.3.2
