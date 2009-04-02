From: Simon Hengel <simon.hengel@gmx.net>
Subject: [PATCH - alsa-utils 2/2] alsamixer - unified behavior
	of volume keys for left & right levels.
Date: Thu,  2 Apr 2009 18:05:30 +0200
Message-ID: <1238688330-15867-2-git-send-email-simon.hengel@gmx.net>
References: <20090402155034.GA5790@john>
	<1238688330-15867-1-git-send-email-simon.hengel@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id A5B31103881
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 18:05:32 +0200 (CEST)
In-Reply-To: <1238688330-15867-1-git-send-email-simon.hengel@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Simon Hengel <simon.hengel@gmx.net>
List-Id: alsa-devel@alsa-project.org

Contrary to what is documented 'q', 'e', 'z' and 'c' did different
things as there upper case counterparts. The lower case versions
changed volume by 2%, whereas the upper case commands changed volume by
1%.

Now all of them change the volume by only 1%.

Signed-off-by: Simon Hengel <simon.hengel@gmx.net>

diff --git a/alsamixer/alsamixer.c b/alsamixer/alsamixer.c
index 554326f..51cd97e 100644
--- a/alsamixer/alsamixer.c
+++ b/alsamixer/alsamixer.c
@@ -2187,26 +2187,22 @@ mixer_iteration (void)
 	mixer_volume_absolute = 10 * (key - '0');
 	break;
       case 'q':
-	mixer_volume_delta[MIXER_CHN_LEFT] = 1;
       case 'Q':
-	mixer_volume_delta[MIXER_CHN_LEFT] += 1;
+	mixer_volume_delta[MIXER_CHN_LEFT] = 1;
 	break;
       case 'y':
       case 'z':
-	mixer_volume_delta[MIXER_CHN_LEFT] = -1;
       case 'Y':
       case 'Z':
-	mixer_volume_delta[MIXER_CHN_LEFT] += -1;
+	mixer_volume_delta[MIXER_CHN_LEFT] = -1;
 	break;
       case 'e':
-	mixer_volume_delta[MIXER_CHN_RIGHT] = 1;
       case 'E':
-	mixer_volume_delta[MIXER_CHN_RIGHT] += 1;
+	mixer_volume_delta[MIXER_CHN_RIGHT] = 1;
 	break;
       case 'c':
-	mixer_volume_delta[MIXER_CHN_RIGHT] = -1;
       case 'C':
-	mixer_volume_delta[MIXER_CHN_RIGHT] += -1;
+	mixer_volume_delta[MIXER_CHN_RIGHT] = -1;
 	break;
       case 'm':
       case 'M':
-- 
1.5.6.3
