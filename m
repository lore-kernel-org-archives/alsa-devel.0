From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ASoC: Use strlcpy() for copying in
	snd_soc_info_enum_double()
Date: Mon, 28 Oct 2013 14:21:46 +0100
Message-ID: <1382966510-13075-2-git-send-email-tiwai@suse.de>
References: <1382966510-13075-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A474261661
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:19:06 +0100 (CET)
In-Reply-To: <1382966510-13075-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The provided texts aren't guaranteed to be in the fixed size.
Spotted by coverity CID 139318.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index afc3fa8..bdc1d74 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2551,8 +2551,9 @@ int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 
 	if (uinfo->value.enumerated.item > e->max - 1)
 		uinfo->value.enumerated.item = e->max - 1;
-	strcpy(uinfo->value.enumerated.name,
-		e->texts[uinfo->value.enumerated.item]);
+	strlcpy(uinfo->value.enumerated.name,
+		e->texts[uinfo->value.enumerated.item],
+		sizeof(uinfo->value.enumerated.name));
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_enum_double);
-- 
1.8.4.1
