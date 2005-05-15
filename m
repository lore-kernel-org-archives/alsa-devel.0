From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Re: alsa-lib patches
Date: Sun, 15 May 2005 18:30:40 +0100
Message-ID: <42878740.30103@superbug.co.uk>
References: <4VSQHX111E5W3.1736062366PHUYD5@kevquinn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4VSQHX111E5W3.1736062366PHUYD5@kevquinn.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Kevin F.Quinn" <co@kevquinn.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kevin F.Quinn wrote:
> Clemens Ladisch wrote:
> 
>>Martin Stransky wrote:
>>
>>>About mixer patch - some user had a problem with ICH6 and this patch helped.
>>>
>>>+static snd_mixer_t *qsort_mixer;
>>
>> 
>>This will break with multithreading.
>> 
>>
>>>+static int compar(const void *a, const void *b) {
>>>+       return qsort_mixer->compare(*(const snd_mixer_elem_t * const *) a,
>>>+                                   *(const snd_mixer_elem_t * const *) b);
>>>+}
>>
>> 
>>So the actual problem is that qsort() calls us with a pointer to a
>>pointer to the mixer_elem_t, but the compare function takes a single
>>pointer.
>> 
>> 
>>If we don"t want to change the mixer API, we have to use some
>>pthread_mutex to protext qsort_mixer.
> 
> 
> Some of us have been watching this at Gentoo, as we agree the patch applied to remove the nested function in src/mixer/mixer.c is broken.
> 
> See https://bugs.gentoo.org/show_bug.cgi?id=82242 (skip straight to the end, comment #13) where the PaX team have supplied a patch that ought to work, along the lines of a change made to src/control/hcontrol.c over a year ago which fixed the same issue there.  Patch at https://bugs.gentoo.org/attachment.cgi?id=58918
> 
> Cheers,
> Kev.
> 

What is wrong with the current CVS code?:

typedef int (*qsort_func)(const void *, const void *);
static int snd_mixer_sort(snd_mixer_t *mixer)
{
        unsigned int k;
        assert(mixer);
        assert(mixer->compare);
        INIT_LIST_HEAD(&mixer->elems);
        qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*),
(qsort_func)mixer->compare);
        for (k = 0; k < mixer->count; k++)
                list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
        return 0;
}

We are not executing any code on the stack. This should not effect the
NX bit so what I the problem here?

James


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
