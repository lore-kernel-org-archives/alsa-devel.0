From: Mark Cannon <mark@vuenyx.com>
Subject: Re: Re: alsa driver, repeat playback of buffer contents
Date: Mon, 14 Mar 2005 20:14:37 -0500
Message-ID: <200503142014.37841.mark@vuenyx.com>
References: <200503141530.20339.random.bits@rogers.com> <yw1xu0ndj2du.fsf@ford.inprovide.com> <1110846019.15588.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1110846019.15588.28.camel@mindpipe>
Content-Disposition: inline
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

I looked at using the mmap() version, and in fact I=20
implemented it. It's easy to use, and it is the better=20
way to do it, yet I do not see how it solves my=20
problem.=20

How can I send down a short PCM stream, and have the=20
hardware repeat it until told to stop?

Mark

On Monday 14 March 2005 19:20, Lee Revell wrote:
> On Mon, 2005-03-14 at 23:20 +0100, M=E5ns Rullg=E5rd=20
wrote:
> > Lee Revell <rlrevell@joe-job.com> writes:
> > > On Mon, 2005-03-14 at 15:30 -0500, random.bits=20
wrote:
> > >> I have been reading up on the alsa driver. I
> > >> would like to have the alsa driver play a small
> > >> pcm sound bite over and over without have to
> > >> re-write it to the device.
> > >>
> > >> By small, I mean 1.9K in length. I have
> > >> followed the examples enough to get it to play
> > >> the sound bite once, but I cannot figure out
> > >> how to get it to play it multiple times without
> > >> having to make another call to snd_pcm_writei()
> > >> again.
> > >
> > > Why in the heck are you using write() instead of
> > > mmap()?
> >
> > snd_pcm_writei() often uses mmap() behind the
> > scenes.
>
> Right, but AFAICT mmap() should not call write()
> behind the scenes (unless you use the plug layer?).=20
> So if you want to be sure to avoid unnecessary
> copying you should just use mmap() directly.
>
> Or am I wrong?  Anyway, the JACK ALSA driver always
> uses mmap() for example.
>
> Lee
>
>
>
> ----------------------------------------------------
>--- SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users. Discover which products
> truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dcl
>ick _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-de
>vel

=2D-=20
Mark Cannon
VP Engineering
Viewnyx Corporation


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
