From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix of the get_id fix
Date: Mon, 02 Dec 2002 11:39:34 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212020949450.9290-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> revision 1.6
> date: 2002/11/28 13:54:34;  author: perex;  state: Exp;  lines: +3 -4
>
> Fixed parsiong of id where dst is NULL
>
> Index: initval.h
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/include/initval.h,v
> retrieving revision 1.5
> retrieving revision 1.6
> diff -u -r1.5 -r1.6
> --- initval.h   23 Nov 2002 10:41:53 -0000      1.5
> +++ initval.h   28 Nov 2002 13:54:34 -0000      1.6
> @@ -156,10 +156,9 @@
>         for (s = *str; isalpha(*s) || isdigit(*s) || *s == '_'; s++);
>         if (s != *str) {
>                 *dst = (char *)kmalloc(s - *str, GFP_KERNEL);
> -               if ((d = *dst) != NULL) {
> -                       s = *str;
> -                       while (isalpha(*s) || isdigit(*s) || *s == '_')
> +               s = *str; d = *dst;
> +               while (isalpha(*s) || isdigit(*s) || *s == '_')
> +                       if (d != NULL)
>                                 *d++ = *s++;
> -               }
>         }
>         *str = s;

I'm not sure I understand what this patch tries to fix. Revision 1.5 seems
to work when kmalloc fails (it skips the input field and returns NULL),
but revision 1.6 goes into an infinite loop because s isn't incremented
when d == NULL.

And IMNSHO the returned string should be zero-terminated.


-- 
Clemens



Index: alsa-kernel/include/initval.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/initval.h,v
retrieving revision 1.6
diff -u -r1.6 initval.h
--- alsa-kernel/include/initval.h	28 Nov 2002 13:54:34 -0000	1.6
+++ alsa-kernel/include/initval.h	2 Dec 2002 08:48:55 -0000
@@ -155,11 +155,13 @@
 		return 0;
 	for (s = *str; isalpha(*s) || isdigit(*s) || *s == '_'; s++);
 	if (s != *str) {
-		*dst = (char *)kmalloc(s - *str, GFP_KERNEL);
+		*dst = (char *)kmalloc(s - *str + 1, GFP_KERNEL);
-		s = *str; d = *dst;
-		while (isalpha(*s) || isdigit(*s) || *s == '_')
-			if (d != NULL)
+		if ((d = *dst) != NULL) {
+			s = *str;
+			while (isalpha(*s) || isdigit(*s) || *s == '_')
 				*d++ = *s++;
+			*d = '\0';
+		}
 	}
 	*str = s;
 	if (*s == ',') {



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
