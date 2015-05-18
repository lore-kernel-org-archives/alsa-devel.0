From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: info: Drop kerneldoc comment from
	snd_info_create_entry()
Date: Mon, 18 May 2015 09:57:04 +0200
Message-ID: <1431935824-8670-5-git-send-email-tiwai@suse.de>
References: <1431935824-8670-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B4BE2604A7
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 09:57:07 +0200 (CEST)
In-Reply-To: <1431935824-8670-1-git-send-email-tiwai@suse.de>
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
Cc: libin.yang@intel.com, han.lu@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

It's no longer a part of API but merely a local function.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 76cdf1d21f17..895362a696c9 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -686,7 +686,7 @@ const char *snd_info_get_str(char *dest, const char *src, int len)
 
 EXPORT_SYMBOL(snd_info_get_str);
 
-/**
+/*
  * snd_info_create_entry - create an info entry
  * @name: the proc file name
  * @parent: the parent directory
-- 
2.3.6
