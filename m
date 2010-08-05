From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 35/42] sound/oss: Adjust confusing if indentation
Date: Thu, 5 Aug 2010 22:27:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1008052227140.31692@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Indent the branch of an if.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable braces4@
position p1,p2;
statement S1,S2;
@@

(
if (...) { ... }
|
if (...) S1@p1 S2@p2
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

if (p1[0].column == p2[0].column):
  cocci.print_main("branch",p1)
  cocci.print_secs("after",p2)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/oss/ad1848.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 24793c5..4d2a6ae 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -716,7 +716,7 @@ static int ad1848_mixer_ioctl(int dev, unsigned int cmd, void __user *arg)
 				
 				default:
 					if (get_user(val, (int __user *)arg))
-					return -EFAULT;
+						return -EFAULT;
 					val = ad1848_mixer_set(devc, cmd & 0xff, val);
 					break;
 			} 
