From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: rt5645: Constify dmi_system_id table
Date: Sun, 28 Jun 2015 11:41:19 +0800
Message-ID: <1435462879.15772.5.camel@ingics.com>
References: <1435462822.15772.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E71112605F4
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 05:41:24 +0200 (CEST)
Received: by pdbci14 with SMTP id ci14so96824070pdb.2
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 20:41:23 -0700 (PDT)
In-Reply-To: <1435462822.15772.4.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

dmi_check_system() takes "const struct dmi_system_id *", so make the
dmi_system_id table const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ce311e..297d3f6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3221,7 +3221,7 @@ static int strago_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
-static struct dmi_system_id dmi_platform_intel_braswell[] = {
+static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{
 		.ident = "Intel Strago",
 		.callback = strago_quirk_cb,
-- 
2.1.0
