From: Simon Hengel <simon.hengel@gmx.net>
Subject: [PATCH - alsa-utils 1/2] alsamixer - unified behavior
	of volume control keys.
Date: Thu,  2 Apr 2009 18:05:29 +0200
Message-ID: <1238688330-15867-1-git-send-email-simon.hengel@gmx.net>
References: <20090402155034.GA5790@john>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 165EF103881
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 18:05:31 +0200 (CEST)
In-Reply-To: <20090402155034.GA5790@john>
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

Contrary to what is documented '+' and KEY_UP did not the same thing.
The behavior was as follows:

W | +           increase volume by 1%
w | KEY_UP      increase volume by 2%
X | -           decrease volume by 1%
x | KEY_DOWN    decrease volume by 2%

Now all of them change the volume by only 1%.

Signed-off-by: Simon Hengel <simon.hengel@gmx.net>

diff --git a/alsamixer/alsamixer.c b/alsamixer/alsamixer.c
index 414033e..554326f 100644
--- a/alsamixer/alsamixer.c
+++ b/alsamixer/alsamixer.c
@@ -1916,15 +1916,6 @@ mixer_set_delta(int delta)
     mixer_volume_delta[grp] = delta;
 }
 
-static void
-mixer_add_delta(int delta)
-{
-  int grp;
-  
-  for (grp = 0; grp < 2; grp++)
-    mixer_volume_delta[grp] += delta;
-}
-
 static int
 mixer_iteration (void)
 {
@@ -2172,22 +2163,16 @@ mixer_iteration (void)
         mixer_set_delta(-100);
 	break;
       case '+':
-        mixer_set_delta(1);
-	break;
-      case '-':
-        mixer_set_delta(-1);
-	break;
       case 'w':
+      case 'W':
       case KEY_UP:
         mixer_set_delta(1);
-      case 'W':
-        mixer_add_delta(1);
 	break;
+      case '-':
       case 'x':
+      case 'X':
       case KEY_DOWN:
         mixer_set_delta(-1);
-      case 'X':
-        mixer_add_delta(-1);
 	break;
       case '0':
       case '1':
-- 
1.5.6.3
