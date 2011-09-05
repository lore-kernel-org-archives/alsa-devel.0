From: Olivier Trichet <nive@nivalis.org>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH=5D_snd=5Fmixer=5Fpoll=5Fdesc?=
 =?iso-8859-1?q?riptors=5Frevents=3A_iterate=09over_all_descriptors?=
Date: Mon, 5 Sep 2011 13:59:01 +0200
Message-ID: <201109051359.02005.nive@nivalis.org>
References: <201108041206.19476.nive@nivalis.org>
	<s5h8vr49xr3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bise.nivalis.org (can59-2-82-224-119-179.fbx.proxad.net
	[82.224.119.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 389D4103810
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 13:59:05 +0200 (CEST)
In-Reply-To: <s5h8vr49xr3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le lundi 8 ao=FBt 2011 09:18:56, Takashi Iwai a =E9crit :
> At Thu, 4 Aug 2011 12:06:19 +0200,
> =

> Olivier Trichet wrote:
> > [1  <text/plain; utf-8 (7bit)>]
> > Hello,
> > =

> > Reading the method snd_mixer_poll_descriptors_revents, it seems to me
> > that the iteration over the array 'pfds' is wrong.
> > Shouldn't the attached patch be applied?
> > =

> > Regards,
> > Olivier
> > [2 0001-snd_mixer_poll_descriptors_revents-iterate-over-all-.patch
> > <text/x-patch; utf-8 (quoted-printable)>] diff --git a/src/mixer/mixer.c
> > b/src/mixer/mixer.c
> > index 85d843f..c3269ea 100644
> > --- a/src/mixer/mixer.c
> > +++ b/src/mixer/mixer.c
> > @@ -744,7 +744,7 @@ int snd_mixer_poll_descriptors_revents(snd_mixer_t
> > *mixer, struct pollfd *pfds,
> > =

> >  		return -EINVAL;
> >  	=

> >  	res =3D 0;
> >  	for (idx =3D 0; idx < nfds; idx++)
> > =

> > -		res |=3D pfds->revents & (POLLIN|POLLERR|POLLNVAL);
> > +		res |=3D pfds[i]->revents & (POLLIN|POLLERR|POLLNVAL);
> =

> You mean idx instead of i, right?
> =


I even meant pdfs[idx].revents instead of pdfs[i]->revents.
Sorry.


Thanks for having a look.
Olivier
