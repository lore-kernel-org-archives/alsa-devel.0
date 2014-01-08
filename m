From: Olivier Langlois <olivier@trillion01.com>
Subject: [PATCH] alsa-utils: fix pcm_read() return value
Date: Tue,  7 Jan 2014 23:18:17 -0500
Message-ID: <1389154697-23849-1-git-send-email-olivier@trillion01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy7-pub.mail.unifiedlayer.com
 (oproxy7-pub.mail.unifiedlayer.com [67.222.55.9])
 by alsa0.perex.cz (Postfix) with SMTP id 9094C2616FF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 05:18:31 +0100 (CET)
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
Cc: Olivier Langlois <olivier@trillion01.com>
List-Id: alsa-devel@alsa-project.org

Because of the way the pcm_read() functions are currently used, returning
rcount or result is equivalent but I feel it is more accurate to
return 'result'.

Signed-off-by: Olivier Langlois <olivier@trillion01.com>
---
 aplay/aplay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index e0631c4..69e8bda 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -2039,7 +2039,7 @@ static ssize_t pcm_read(u_char *data, size_t rcount)
 			data += r * bits_per_frame / 8;
 		}
 	}
-	return rcount;
+	return result;
 }
 
 static ssize_t pcm_readv(u_char **data, unsigned int channels, size_t rcount)
@@ -2084,7 +2084,7 @@ static ssize_t pcm_readv(u_char **data, unsigned int channels, size_t rcount)
 			count -= r;
 		}
 	}
-	return rcount;
+	return result;
 }
 
 /*
-- 
1.8.5.2
