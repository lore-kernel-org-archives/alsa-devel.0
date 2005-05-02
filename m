From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa-lib patches
Date: Mon, 2 May 2005 10:43:51 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505021028020.21377-100000@studcom.urz.uni-halle.de>
References: <42723D60.4030208@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42723D60.4030208@redhat.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Stransky <stransky@redhat.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Martin Stransky wrote:
> About mixer patch - some user had a problem with ICH6 and this patch helped.
>
> +static snd_mixer_t *qsort_mixer;

This will break with multithreading.

> +static int compar(const void *a, const void *b) {
> +       return qsort_mixer->compare(*(const snd_mixer_elem_t * const *) a,
> +                                   *(const snd_mixer_elem_t * const *) b);
> +}

So the actual problem is that qsort() calls us with a pointer to a
pointer to the mixer_elem_t, but the compare function takes a single
pointer.


If we don't want to change the mixer API, we have to use some
pthread_mutex to protext qsort_mixer.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
