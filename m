From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] sound: Close holes in struct
	snd_pcm_constraint_list
Date: Mon, 27 Apr 2015 12:20:29 +0200
Message-ID: <1430130030-17895-2-git-send-email-lars@metafoo.de>
References: <1430130030-17895-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id C1B022650C0
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 12:20:34 +0200 (CEST)
In-Reply-To: <1430130030-17895-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On a 64-bit system there is a 32-bit hole in struct snd_pcm_constraint_list
and then 32-bit padding at the end. Reordering things slightly gets rid of
the hole and padding, reducing the size of the struct by 50% from its
original size.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index d632809..691e7ee 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -274,8 +274,8 @@ struct snd_pcm_hw_constraint_ratdens {
 };
 
 struct snd_pcm_hw_constraint_list {
-	unsigned int count;
 	const unsigned int *list;
+	unsigned int count;
 	unsigned int mask;
 };
 
-- 
1.8.0
