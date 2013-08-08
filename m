From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: s6105-ipcam: Fix incorrect placement
	of __initdata
Date: Thu,  8 Aug 2013 16:52:18 +0530
Message-ID: <1375960938-29005-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 5379C2656B7
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 13:39:08 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id bg4so3306334pad.32
 for <alsa-devel@alsa-project.org>; Thu, 08 Aug 2013 04:39:07 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, Daniel Gloeckner <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Daniel Gloeckner <dg@emlix.com>
---
 sound/soc/s6000/s6105-ipcam.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index 58cfb1e..945e8ab 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -192,7 +192,7 @@ static struct snd_soc_card snd_soc_card_s6105 = {
 	.num_links = 1,
 };
 
-static struct s6000_snd_platform_data __initdata s6105_snd_data = {
+static struct s6000_snd_platform_data s6105_snd_data __initdata = {
 	.wide		= 0,
 	.channel_in	= 0,
 	.channel_out	= 1,
-- 
1.7.9.5
