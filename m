From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: card_id() in initval.h
Date: Sat, 27 Dec 2003 09:56:05 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312270951580.8959@pnote.perex-int.cz>
References: <x7k74nuwwq.fsf@dorian.home.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <x7k74nuwwq.fsf@dorian.home.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andre Batista de Oliveira <abo@netvisao.pt>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Dec 2003, Andre Batista de Oliveira wrote:

> I'm facing some problems passing the ALSA drivers'
> parameters from the kernel command line.
> 
> When I try to specify the ID string for the card
> (snd-sgalaxy=1,0,Waverider,0x220,0x530,10,3),
> the kernel just reboots immediately, even before printing anything!
> 
> But when I leave the ID string unspecified
> (snd-sgalaxy=1,0,,0x220,0x530,10,3), it boots and works fine,
> and the card gets the default "Galaxy" ID.

Thanks for the bug report. Could you try this "official" patch?

Index: initval.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/initval.h,v
retrieving revision 1.17
diff -u -r1.17 initval.h
--- initval.h	30 Oct 2003 14:21:07 -0000	1.17
+++ initval.h	27 Dec 2003 09:00:51 -0000
@@ -138,27 +138,24 @@
 #include <linux/init.h>
 static int __init get_id(char **str, char **dst)
 {
-	char *s, *d;
+	char *s;
 
 	if (!(*str) || !(**str))
 		return 0;
 	for (s = *str; isalpha(*s) || isdigit(*s) || *s == '_'; s++);
 	if (s != *str) {
-		*dst = (char *)kmalloc((s - *str) + 1, GFP_KERNEL);
-		s = *str; d = *dst;
-		while (isalpha(*s) || isdigit(*s) || *s == '_') {
-			if (d != NULL)
-				*d++ = *s;
-			s++;
+		int len = s - *str;
+		char *d = (char *)alloc_bootmem(len + 1);
+		if (d != NULL) {
+			memcpy(*dst = d, *str, len);
+			d[len] = '\0';
 		}
-		if (d != NULL)
-			*d = '\0';
 	}
-	*str = s;
 	if (*s == ',') {
-		(*str)++;
+		*str = s + 1;
 		return 2;
 	}
+	*str = s;
 	return 1;
 }
 #endif

					Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
