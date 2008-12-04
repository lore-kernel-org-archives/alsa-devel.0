From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Remove obsolete declaration of
	struct snd_soc_clock_info
Date: Thu,  4 Dec 2008 11:26:46 +0000
Message-ID: <1228390006-30338-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081204112542.GA30250@rakim.wolfsonmicro.main>
	<1228390006-30338-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228390006-30338-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228390006-30338-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AAC5824151
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 12:26:47 +0100 (CET)
In-Reply-To: <1228390006-30338-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The struct is never defined.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ec63c0..79d855d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -152,7 +152,6 @@ struct snd_soc_dai;
 struct snd_soc_codec;
 struct soc_enum;
 struct snd_soc_ac97_ops;
-struct snd_soc_clock_info;
 
 typedef int (*hw_write_t)(void *,const char* ,int);
 typedef int (*hw_read_t)(void *,char* ,int);
-- 
1.5.6.5
