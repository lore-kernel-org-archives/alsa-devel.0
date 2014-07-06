From: Josef Gajdusek <atx@atx.name>
Subject: [PATCH] amixer: Fix convert_prange1 not rounding
	correctly
Date: Sun, 6 Jul 2014 20:25:10 +0200
Message-ID: <20140706182510.GA6314@dashie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The convert_prange1 macro was not the exact inverse of convert_prange.
This was causing the volume percentage set by 'amixer set' to differ from the 
one displayed by 'amixer get'.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
 amixer/amixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index cf82892..577a2ca 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -201,7 +201,7 @@ static int convert_prange(long val, long min, long max)
 /* Function to convert from percentage to volume. val = percentage */
 
 #define convert_prange1(val, min, max) \
-	ceil((val) * ((max) - (min)) * 0.01 + (min))
+	rint((val) * ((max) - (min)) * 0.01 + (min))
 
 struct volume_ops {
 	int (*get_range)(snd_mixer_elem_t *elem, long *min, long *max);
-- 
1.8.5.5
