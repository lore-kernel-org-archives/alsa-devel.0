From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] amixer: Parse the value more strictly
Date: Sun, 23 Nov 2014 10:16:02 +0100
Message-ID: <1416734162-24748-2-git-send-email-tiwai@suse.de>
References: <1416734162-24748-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F4FD2605A4
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 10:16:04 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 00EF1AAF1
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 09:16:03 +0000 (UTC)
In-Reply-To: <1416734162-24748-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

So far amixer allows some unexpected suffix and assumes as a raw
absolute value without returning an error.  This is rather dangerous,
e.g. user might not notice that a completely wrong value was set when
the command line included a typo.

This patch makes the parser a bit more strict: it doesn't allow any
longer invalid suffixes, instead either returns an error or skips the
invalid value, depending on the operation mode.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 amixer/amixer.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index 6a2fdb96c62f..ed60e7c3a960 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -325,7 +325,7 @@ static int set_volume_simple(snd_mixer_elem_t *elem,
 	long val, orig, pmin, pmax;
 	char *p = *ptr, *s;
 	int invalid = 0, percent = 0, err = 0;
-	int vol_type = std_vol_type;
+	int vol_type;
 	double scale = 1.0;
 	int correct = 0;
 
@@ -344,14 +344,19 @@ static int set_volume_simple(snd_mixer_elem_t *elem,
 		strtol(p, &p, 10);
 	}
 	if (*p == '%') {
+		vol_type = std_vol_type;
 		percent = 1;
 		p++;
 	} else if (toupper(p[0]) == 'D' && toupper(p[1]) == 'B') {
 		vol_type = VOL_DB;
 		p += 2;
 		scale = 100;
-	} else
+	} else {
 		vol_type = VOL_RAW;
+	}
+
+	if (*p && !strchr(",:+-", *p))
+		invalid = 1;
 
 	val = (long)(strtod(s, NULL) * scale);
 	if (vol_ops[dir].v[vol_type].get_range(elem, &pmin, &pmax) < 0)
@@ -372,6 +377,10 @@ static int set_volume_simple(snd_mixer_elem_t *elem,
 		}
 		p++;
 	}
+
+	if (*p && !strchr(",:", *p))
+		invalid = 1;
+
 	if (! invalid) {
 		val = check_range(val, pmin, pmax);
 		err = vol_ops[dir].v[vol_type].set(elem, chn, val, correct);
-- 
2.1.3
