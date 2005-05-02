From: Martin Stransky <stransky@redhat.com>
Subject: Re: alsa-lib patches
Date: Mon, 02 May 2005 09:43:23 +0200
Message-ID: <4275DA1B.7080902@redhat.com>
References: <42723D60.4030208@redhat.com> <1114796778.21730.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000306060402020107070401"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1114796778.21730.12.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000306060402020107070401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bugzilla link:

https://bugzilla.redhat.com/bugzilla-old/show_bug.cgi?id=146607

We had old patch (it's attached) and it's very similar to your current 
code. It causes some problems, so i changed the patch and it works.

Ma.

> Please give a more detailed description of the patches.  What kind of
> problem?  How about a bugzilla link?
> 
> Lee

--------------000306060402020107070401
Content-Type: text/x-patch;
 name="old-alsa-lib-stack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="old-alsa-lib-stack.patch"

--- alsa-lib-1.0.6/src/mixer/mixer.c.org	2005-01-07 22:37:42.688153791 +0100
+++ alsa-lib-1.0.6/src/mixer/mixer.c	2005-01-07 22:39:49.943579453 +0100
@@ -520,17 +520,14 @@
 	return c1->class->compare(c1, c2);
 }
 
+typedef int (*qsort_func)(const void *, const void *);
 static int snd_mixer_sort(snd_mixer_t *mixer)
 {
 	unsigned int k;
-	int compar(const void *a, const void *b) {
-		return mixer->compare(*(const snd_mixer_elem_t * const *) a,
-				      *(const snd_mixer_elem_t * const *) b);
-	}
 	assert(mixer);
 	assert(mixer->compare);
 	INIT_LIST_HEAD(&mixer->elems);
-	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), compar);
+	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), (qsort_func)mixer->compare);
 	for (k = 0; k < mixer->count; k++)
 		list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
 	return 0;

--------------000306060402020107070401--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
