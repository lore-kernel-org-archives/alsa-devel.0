From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] SoundScape: snd_malloc_isa_pages_fallback
Date: Sat, 28 Sep 2002 21:31:07 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209282031.g8SKV81m001666@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I can't dispute this section of Takashi's patch, except to note that
you probably don't want to clobber buf->size if the snd_xxx_fallback()
function sets it properly for you.

Chris


Index: alsa-driver/isa/sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/sscape.c,v
retrieving revision 1.4
diff -u -u -r1.4 sscape.c
--- alsa-driver/isa/sscape.c	25 Sep 2002 11:48:08 -0000	1.4
+++ alsa-driver/isa/sscape.c	28 Sep 2002 20:22:27 -0000
@@ -161,15 +161,11 @@
 static struct dmabuf *get_dmabuf(struct dmabuf *buf, unsigned long s)
 {
 	if (buf) {
-		while (((buf->data = snd_malloc_isa_pages(s, &buf->addr)) == NULL) && (s > PAGE_SIZE))
-			s /= 2;
-
+		buf->data = snd_malloc_isa_pages_fallback(s, &buf->addr, &buf->size);
 		if (!buf->data) {
 			printk(KERN_ERR "sscape: Failed to allocate %lu bytes for DMA\n", s);
 			return NULL;
 		}
-
-		buf->size = s;
 	}
 
 	return buf;


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
