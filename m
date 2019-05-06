From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: synth: emux: soundfont.c: divide by zero
 in calc_gus_envelope_time()
Date: Mon, 6 May 2019 15:51:19 +0300
Message-ID: <20190506125119.GB13799@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39643F80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 14:51:40 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

This function is called from load_guspatch() and the rate is specified
by the user.  If they accidentally selected zero then it would crash the
kernel.  I've just changed the zero to a one.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/synth/emux/soundfont.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index 31a4ea94830e..9b5d70104489 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -856,6 +856,8 @@ calc_gus_envelope_time(int rate, int start, int end)
 	int r, p, t;
 	r = (3 - ((rate >> 6) & 3)) * 3;
 	p = rate & 0x3f;
+	if (!p)
+		p = 1;
 	t = end - start;
 	if (t < 0) t = -t;
 	if (13 > r)
-- 
2.18.0
