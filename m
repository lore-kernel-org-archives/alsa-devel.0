From: Kevin F.Quinn <co@kevquinn.com>
Subject: Re: Re: alsa-lib patches
Date: Sun, 15 May 2005 22:24:03 +0200
Message-ID: <MDKETX111E5W3.417177801CEUALA@kevquinn.com>
References: <20050515172102.GA13135@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
References: <20050515172102.GA13135@procyon.home>
Sender: alsa-devel-admin@lists.sourceforge.net
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

On 15/5/2005 19:21:02, Sergey Vlasov (vsu@altlinux=2Eru) wrote:
> On Sun, May 15, 2005 at 06:30:40PM +0100, James Courtier-Dutton wrote:
> > What is wrong with the current CVS code?:
> > 
> > typedef int (*qsort_func)(const void *, const void *);
> > static int snd_mixer_sort(snd_mixer_t *mixer)
> > {
> >         unsigned int k;
> >         assert(mixer);
> >         assert(mixer->compare);
> >         INIT_LIST_HEAD(&mixer->elems);
> >         qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*),
> > (qsort_func)mixer->compare);
> >         for (k =3D 0; k < mixer->count; k++)
> >                 list_add_tail(&mixer->pelems[k]->list, &mixer->elems);=

> >         return 0;
> > }
> > 
> > We are not executing any code on the stack=2E This should not effect t=
he
> > NX bit so what I the problem here?
> 
> The problem was cited above:
> 
> > >>So the actual problem is that qsort() calls us with a pointer to a
> > >>pointer to the mixer_elem_t, but the compare function takes a single=

> > >>pointer=2E
> 
> mixer->pelems is an array of pointers to snd_mixer_elem_t, and qsort()
> passes pointers to array elements as arguments to the compare
> function - which becomes (snd_mixer_elem_t **)=2E  But mixer->compare
> expects to get (snd_mixer_elem_t *) as arguments=2E
> 
> However, seems that mixer elements have an indirect pointer to the
> mixer they belong to - elem->class->mixer=2E  So, how about this:
> 
> static int snd_mixer_qsort_compare(const void *a, const void *b)
> {
> 	snd_mixer_elem_t *elem_a =3D *(snd_mixer_elem_t **)a;
> 	snd_mixer_elem_t *elem_b =3D *(snd_mixer_elem_t **)b;
> 
> 	return elem_a->class->mixer->compare(elem_a, elem_b);
> }
> 
> static int snd_mixer_sort(snd_mixer_t *mixer)
> {
> 	unsigned int k;
> 	assert(mixer);
> 	assert(mixer->compare);
> 	INIT_LIST_HEAD(&mixer->elems);
> 	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), 
> snd_mixer_qsort_compare);
> 	for (k =3D 0; k < mixer->count; k++)
> 		list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
> 	return 0;
> }

You also need to make it thread-safe, as Clements mentioned; the PaX team'=
s proposal at https://bugs=2Egentoo=2Eorg/attachment=2Ecgi?id=3D58918 does=
 that as well:


--- alsa-lib-1=2E0=2E9rc3/src/mixer/mixer=2Ec	2005-02-04 19:18:49=2E000000=
000 +0000
+++ alsa-lib-1=2E0=2E9rc3-fixed/src/mixer/mixer=2Ec	2005-05-15 00:10:59=2E=
000000000 +0100
@@ -45,6 +45,7 @@ This is an abstraction layer over the hc
 #include <string=2Eh>
 #include <fcntl=2Eh>
 #include <sys/ioctl=2Eh>
+#include <pthread=2Eh>
 #include "mixer_local=2Eh"
 
 #ifndef DOC_HIDDEN
@@ -520,14 +521,26 @@ static int snd_mixer_compare_default(con
 	return c1->class->compare(c1, c2);
 }
 
-typedef int (*qsort_func)(const void *, const void *);
+static snd_mixer_t *compare_mixer;
+static int mixer_compare(const void *a, const void *b) {
+	return compare_mixer->compare(*(const snd_mixer_elem_t * const *) a,
+				      *(const snd_mixer_elem_t * const *) b);
+}
+
 static int snd_mixer_sort(snd_mixer_t *mixer)
 {
 	unsigned int k;
+	static pthread_mutex_t sync_lock =3D PTHREAD_MUTEX_INITIALIZER;
+
 	assert(mixer);
 	assert(mixer->compare);
 	INIT_LIST_HEAD(&mixer->elems);
-	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), (qsort_fun=
c)mixer->compare);
+
+	pthread_mutex_lock(&sync_lock);
+	compare_mixer =3D mixer;
+	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), mixer_comp=
are);
+	pthread_mutex_unlock(&sync_lock);
+
 	for (k =3D 0; k < mixer->count; k++)
 		list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
 	return 0;




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
