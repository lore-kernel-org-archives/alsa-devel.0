From: "Stephen Cook" <siti_veni@lycos.com>
Subject: Patch to fix Pax/Grsecurity Problems
Date: Mon, 12 Jan 2004 12:27:23 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BBDLNOJOGMPLEFAA@mailcity.com>
Reply-To: siti_veni@lycos.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_-=_-PCHDKOJOGMPLEFAA"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
You need a MIME compliant mail reader to completely decode it.

--=_-=_-PCHDKOJOGMPLEFAA
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Length: 996
Content-Transfer-Encoding: 7bit

As you may be currently aware alsa-lib (libasound) does not work very well when using it under a kernel that has the Pax (http://pax.grsecurity.net) or Grsecurity (http://www.grsecurity.net) Patch.

The problem is because there is a function in a function (trampoline) - So gcc generates code that conflicts with pax.  Also there is a text-relocation problem.

So I helped create patch that will fix these problems so alsa will be more usable on a Pax/Grsecurity machine (no chpax work arounds and more security).  Currently this patch is included in alsa-lib-1.0.1 in Gentoo so it is undergoing large scale testing.  For my part I have 2 machines running with Pax and this alsa-lib patch and I have had no problems :)

The code is a work around so if you know of a better way to do it please tell me.





____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
--=_-=_-PCHDKOJOGMPLEFAA
Content-Type: text/plain; charset=us-ascii; name="alsa-lib-1.0.1-notextrel-notrampoline.patch"
Content-Language: en
Content-Length: 1788
Content-Transfer-Encoding: 7bit

diff -Nru alsa-lib-1.0.0rc2-original/src/control/hcontrol.c alsa-lib-1.0.0rc2/src/control/hcontrol.c
--- alsa-lib-1.0.0rc2-original/src/control/hcontrol.c	Mon Oct 13 08:06:46 2003
+++ alsa-lib-1.0.0rc2/src/control/hcontrol.c	Sat Dec 20 13:48:32 2003
@@ -48,6 +48,7 @@
 #include <string.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
+#include <pthread.h>
 #ifndef DOC_HIDDEN
 #define __USE_GNU
 #endif
@@ -409,17 +410,26 @@
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
+	static pthread_mutex_t sync_lock = PTHREAD_MUTEX_INITIALIZER;
+
 	assert(hctl);
 	assert(hctl->compare);
 	INIT_LIST_HEAD(&hctl->elems);
-	qsort(hctl->pelems, hctl->count, sizeof(*hctl->pelems), compar);
+
+	pthread_mutex_lock(&sync_lock);
+	compare_hctl = hctl;
+	qsort(hctl->pelems, hctl->count, sizeof(*hctl->pelems), hctl_compare);
+	pthread_mutex_unlock(&sync_lock);
+
 	for (k = 0; k < hctl->count; k++)
 		list_add_tail(&hctl->pelems[k]->list, &hctl->elems);
 }
diff -Nru alsa-lib-1.0.0rc2-original/src/pcm/pcm_direct.c alsa-lib-1.0.0rc2/src/pcm/pcm_direct.c
--- alsa-lib-1.0.0rc2-original/src/pcm/pcm_direct.c	Fri Oct 17 09:53:06 2003
+++ alsa-lib-1.0.0rc2/src/pcm/pcm_direct.c	Sat Dec 20 13:49:22 2003
@@ -98,7 +98,6 @@
 
 int snd_pcm_direct_shm_create_or_connect(snd_pcm_direct_t *dmix)
 {
-	static int snd_pcm_direct_shm_discard(snd_pcm_direct_t *dmix);
 	struct shmid_ds buf;
 	int ret = 0;
 	
--=_-=_-PCHDKOJOGMPLEFAA--



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
