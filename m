From: Simon Hengel <simon.hengel@gmx.net>
Subject: [PATCH - alsa-utils] Added vi-like key bindings to
	alsamixer.
Date: Wed,  1 Apr 2009 21:58:15 +0200
Message-ID: <1238615895-5980-2-git-send-email-simon.hengel@gmx.net>
References: <1238615895-5980-1-git-send-email-simon.hengel@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id C171C10383A
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 21:58:16 +0200 (CEST)
In-Reply-To: <1238615895-5980-1-git-send-email-simon.hengel@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Simon Hengel <simon.hengel@gmx.net>
List-Id: alsa-devel@alsa-project.org

* Added 'j' as an alias for KEY_DOWN
* Added 'k' as an alias for KEY_UP

Signed-off-by: Simon Hengel <simon.hengel@gmx.net>

diff --git a/alsamixer/alsamixer.c b/alsamixer/alsamixer.c
index 414033e..c65c22d 100644
--- a/alsamixer/alsamixer.c
+++ b/alsamixer/alsamixer.c
@@ -2113,11 +2113,13 @@ mixer_iteration (void)
 	mixer_hscroll_delta -= 1;
 	break;
       case KEY_UP:
+      case 'k':
       case 'w':
       case 'W':
 	mixer_vscroll_delta -= 1;
 	break;
       case KEY_DOWN:
+      case 'j':
       case 'x':
       case 'X':
 	mixer_vscroll_delta += 1;
@@ -2179,12 +2181,14 @@ mixer_iteration (void)
 	break;
       case 'w':
       case KEY_UP:
+      case 'k':
         mixer_set_delta(1);
       case 'W':
         mixer_add_delta(1);
 	break;
       case 'x':
       case KEY_DOWN:
+      case 'j':
         mixer_set_delta(-1);
       case 'X':
         mixer_add_delta(-1);
-- 
1.5.6.3
