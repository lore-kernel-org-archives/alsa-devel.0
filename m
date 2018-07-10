From: <twischer@de.adit-jv.com>
Subject: [PATCH - snd_interval_refine 1/1] pcm:
	snd_interval_refine_first/last: exclude value only if also
	excluded before
Date: Tue, 10 Jul 2018 17:28:45 +0200
Message-ID: <1531236525-17874-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Without this commit the following intervals [x y), (x y) were be
replaced to (y-1 y) by snd_interval_refine_last(). This was also done if
y-1 is part of the previous interval.
With this changes it will be replaced with [y-1 y) in case of y-1 is
part of the previous interval. A similar behavior will be used for
snd_interval_refine_first().

This commit adapts the changes for alsa-lib of commit
9bb985c ("pcm: snd_interval_refine_first/last: exclude value only if
also excluded before")

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---

That this fix is also required for kernel was spotted by Takashi in [1].

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-July/137764.html

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index faa6786..729a85a 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -629,27 +629,33 @@ EXPORT_SYMBOL(snd_interval_refine);
 
 static int snd_interval_refine_first(struct snd_interval *i)
 {
+	const unsigned int last_max = i->max;
+
 	if (snd_BUG_ON(snd_interval_empty(i)))
 		return -EINVAL;
 	if (snd_interval_single(i))
 		return 0;
 	i->max = i->min;
-	i->openmax = i->openmin;
-	if (i->openmax)
+	if (i->openmin)
 		i->max++;
+	/* only exclude max value if also excluded before refine */
+	i->openmax = (i->openmax && i->max >= last_max);
 	return 1;
 }
 
 static int snd_interval_refine_last(struct snd_interval *i)
 {
+	const unsigned int last_min = i->min;
+
 	if (snd_BUG_ON(snd_interval_empty(i)))
 		return -EINVAL;
 	if (snd_interval_single(i))
 		return 0;
 	i->min = i->max;
-	i->openmin = i->openmax;
-	if (i->openmin)
+	if (i->openmax)
 		i->min--;
+	/* only exclude min value if also excluded before refine */
+	i->openmin = (i->openmin && i->min <= last_min);
 	return 1;
 }
 
-- 
2.7.4
