From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Re: alsa-lib patches
Date: Sun, 15 May 2005 20:04:08 +0100
Message-ID: <42879D28.9060904@superbug.co.uk>
References: <4VSQHX111E5W3.1736062366PHUYD5@kevquinn.com> <42878740.30103@superbug.co.uk> <20050515172102.GA13135@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050515172102.GA13135@procyon.home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: "Kevin F.Quinn" <co@kevquinn.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sergey Vlasov wrote:
> 
> mixer->pelems is an array of pointers to snd_mixer_elem_t, and qsort()
> passes pointers to array elements as arguments to the compare
> function - which becomes (snd_mixer_elem_t **).  But mixer->compare
> expects to get (snd_mixer_elem_t *) as arguments.
> 
Ok, so not a security issue, just a messed up pointer issue.


> However, seems that mixer elements have an indirect pointer to the
> mixer they belong to - elem->class->mixer.  So, how about this:
> 
> static int snd_mixer_qsort_compare(const void *a, const void *b)
> {
> 	snd_mixer_elem_t *elem_a = *(snd_mixer_elem_t **)a;
> 	snd_mixer_elem_t *elem_b = *(snd_mixer_elem_t **)b;
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
> 	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), snd_mixer_qsort_compare);
> 	for (k = 0; k < mixer->count; k++)
> 		list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
> 	return 0;
> }

That seems like a better solution. This sort routine does not have to be
high performance as it is not used often.

I suppose this begs the question, why has it work ok up until now?

James




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
