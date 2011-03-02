From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Check for a CODEC before
	dereferencing in DAPM
Date: Wed,  2 Mar 2011 19:21:08 +0000
Message-ID: <1299093671-12309-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C326103822
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 20:20:54 +0100 (CET)
In-Reply-To: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

A CODEC pointer is optional (and is checked for in most contexts within
DAPM) - add checks to the few places where it was missed.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8240ab8..570db88 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1517,7 +1517,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	char prefixed_source[80];
 	int ret = 0;
 
-	if (dapm->codec->name_prefix) {
+	if (dapm->codec && dapm->codec->name_prefix) {
 		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s %s",
 			 dapm->codec->name_prefix, route->sink);
 		sink = prefixed_sink;
@@ -2167,14 +2167,14 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		return -ENOMEM;
 
 	name_len = strlen(widget->name) + 1;
-	if (dapm->codec->name_prefix)
+	if (dapm->codec && dapm->codec->name_prefix)
 		name_len += 1 + strlen(dapm->codec->name_prefix);
 	w->name = kmalloc(name_len, GFP_KERNEL);
 	if (w->name == NULL) {
 		kfree(w);
 		return -ENOMEM;
 	}
-	if (dapm->codec->name_prefix)
+	if (dapm->codec && dapm->codec->name_prefix)
 		snprintf(w->name, name_len, "%s %s",
 			dapm->codec->name_prefix, widget->name);
 	else
-- 
1.7.2.3
