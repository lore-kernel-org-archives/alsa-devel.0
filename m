From: Kevin F.Quinn <co@kevquinn.com>
Subject: Re: alsa-lib patches
Date: Sun, 15 May 2005 16:57:39 +0200
Message-ID: <4VSQHX111E5W3.1736062366PHUYD5@kevquinn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Clemens Ladisch wrote:
> Martin Stransky wrote:
> > About mixer patch - some user had a problem with ICH6 and this patch h=
elped=2E
> >
> > +static snd_mixer_t *qsort_mixer;
>  
> This will break with multithreading=2E
>  
> > +static int compar(const void *a, const void *b) {
> > +       return qsort_mixer->compare(*(const snd_mixer_elem_t * const *=
) a,
> > +                                   *(const snd_mixer_elem_t * const *=
) b);
> > +}
>  
> So the actual problem is that qsort() calls us with a pointer to a
> pointer to the mixer_elem_t, but the compare function takes a single
> pointer=2E
>  
>  
> If we don"t want to change the mixer API, we have to use some
> pthread_mutex to protext qsort_mixer=2E

Some of us have been watching this at Gentoo, as we agree the patch applie=
d to remove the nested function in src/mixer/mixer=2Ec is broken=2E

See https://bugs=2Egentoo=2Eorg/show_bug=2Ecgi?id=3D82242 (skip straight t=
o the end, comment #13) where the PaX team have supplied a patch that ough=
t to work, along the lines of a change made to src/control/hcontrol=2Ec ov=
er a year ago which fixed the same issue there=2E  Patch at https://bugs=2E=
gentoo=2Eorg/attachment=2Ecgi?id=3D58918

Cheers,
Kev=2E




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
