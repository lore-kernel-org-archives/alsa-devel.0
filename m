From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] snd_ctl_elem_info_get_dimension? fixes
Date: Sun, 13 Jul 2003 14:19:10 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030713141910.5cf02d55.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



It's against alsa-lib 0.9.5. It also applies to the CVS version because
the files are identical.


--- ./src/control/control.c_old	Sun Jul 13 14:01:10 2003
+++ ./src/control/control.c	Sun Jul 13 14:09:31 2003
@@ -1699,10 +1699,10 @@
 	assert(obj);
 	if (obj->access & SNDRV_CTL_ELEM_ACCESS_DINDIRECT)
 		return 0;			/* FIXME: implement indirect access as well */
-	for (i = 3; i >= 0; i++)
+	for (i = 3; i >= 0; i--)
 		if (obj->dimen.d[i])
 			break;
-	return i >= 0 ? i + 1 : 0;
+	return i + 1;
 }
 use_default_symbol_version(__snd_ctl_elem_info_get_dimensions, snd_ctl_elem_info_get_dimensions, ALSA_0.9.3);
 
@@ -1722,7 +1722,7 @@
 		return 0;			/* FIXME: implement indirect access as well */
 	if (idx >= 3)
 		return 0;
-	return obj->dimen.d[0];
+	return obj->dimen.d[idx];
 }
 use_default_symbol_version(__snd_ctl_elem_info_get_dimension, snd_ctl_elem_info_get_dimension, ALSA_0.9.3);
 


-- 
Bye.
   Giuliano.


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
