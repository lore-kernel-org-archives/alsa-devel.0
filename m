From: goodbyte@phreaker.net
Subject: [PATCH] alsa-lib trampolines
Date: Sat, 9 Nov 2002 23:56:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021109225634.GA31327@goodspirit.selunatech.cjb.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi
I've been having issues with alsa-lib on a linux-grsecurity box
(www.grsecurity.net), since there is a trampoline call - code that is
executed on the stack in alsa-lib. I supply a patch that fixes this
problem, but it's not The Right Way way to do it. My suggestion is to
rewrite alsa-lib so snd_hctl_t::compare can be sent directly to qsort.
Comments?


-- 
Erik Månsson

Bender: Bite my shiny, metal ass!

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-lib-0.9.0rc5.diff"

diff -urN alsa-lib-0.9.0rc5/src/control/hcontrol.c alsa-lib-0.9.0rc5.new/src/control/hcontrol.c
--- alsa-lib-0.9.0rc5/src/control/hcontrol.c	2002-03-12 21:14:11.000000000 +0100
+++ alsa-lib-0.9.0rc5.new/src/control/hcontrol.c	2002-10-29 10:07:07.000000000 +0100
@@ -382,17 +382,20 @@
 	return 0;
 }
 
+static snd_hctl_t *compare_hctl;
+static int hctl_compare(const void *a, const void *b) {
+	return compare_hctl->compare(*(const snd_hctl_elem_t * const *) a,
+			     *(const snd_hctl_elem_t * const *) b);
+}
+
 static void snd_hctl_sort(snd_hctl_t *hctl)
 {
 	unsigned int k;
-	int compar(const void *a, const void *b) {
-		return hctl->compare(*(const snd_hctl_elem_t * const *) a,
-				     *(const snd_hctl_elem_t * const *) b);
-	}
 	assert(hctl);
 	assert(hctl->compare);
 	INIT_LIST_HEAD(&hctl->elems);
-	qsort(hctl->pelems, hctl->count, sizeof(*hctl->pelems), compar);
+	compare_hctl = hctl;
+	qsort(hctl->pelems, hctl->count, sizeof(*hctl->pelems), hctl_compare);
 	for (k = 0; k < hctl->count; k++)
 		list_add_tail(&hctl->pelems[k]->list, &hctl->elems);
 }

--PEIAKu/WMn1b1Hv9--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
