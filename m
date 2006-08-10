From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: underrun!!! (at least 0,
	249 ms long) was (struct snd_pcm_hardware_t values)
Date: Thu, 10 Aug 2006 12:15:01 +0200
Message-ID: <d9def9db0608100315j273dc3f9i1eab93f467356c71@mail.gmail.com>
References: <d9def9db0608071809x648b8febsbc6feba4930e5cfa@mail.gmail.com>
	<s5hac6fr0bv.wl%tiwai@suse.de>
	<d9def9db0608090308u7eb538e4y9ca7db9c212b07d1@mail.gmail.com>
	<s5hlkpydx0h.wl%tiwai@suse.de>
	<d9def9db0608090357m68e51f06xc5f75ae898696963@mail.gmail.com>
	<s5hejvqdv7k.wl%tiwai@suse.de>
	<d9def9db0608090446i26c25eb7yb73b3eadc2eb4ff5@mail.gmail.com>
	<s5hac6eds7x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9554218D
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Aug 2006 12:15:05 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id b29so452720pya
	for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2006 03:15:04 -0700 (PDT)
In-Reply-To: <s5hac6eds7x.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/9/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 9 Aug 2006 13:46:12 +0200,
> Markus Rechberger wrote:
> >
> > On 8/9/06, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Wed, 9 Aug 2006 12:57:08 +0200,
> > > Markus Rechberger wrote:
> > > >
> > > > > > the driver was always available uppon request... thought it would
> be
> > > > > > nice to host it in an alsa development tree or so but I haven't
> got
> > > > > > any answer regarding this a while ago.. I put it into my
> video4linux
> > > > > > development tree now..
> > > > >
> > > > > We can put it to alsa-driver tree and later push it to upstream when
> > > > > the code is well brushed up.
> > > > >
> > > > > So, could you post the code, or as a patch, to alsa-devel ML?
> > > > > The post is easier for reviewing and correcting some issues.
> > > > >
> > > >
> > > > have you seen how the devcode is managed on linuxtv.org? Think
> > > > something like that would be very nice for alsa too...
> > > >
> > > > http://linuxtv.org/hg/
> > >
> > > http://hg-mirror.alsa-project.org ?
> > >
> > > Anyway the HG web interface is not suitable for interactive discussion
> > > and review to add comments and correct codes.
> > >
> > >
> >
> > no it's just every developer has it's own tree there. And as soon as
> > one developer finished some things it gets merged to the master in
> > case of linuxtv it would be v4l-dvb.
> > I'm just writing about that because alsa also uses mercurial maybe it
> > would also be nice to have it like that there?
>
> Well, it's a bit different development style.
> Yes, we can have individual repos and the main repo for merging like
> kernel development, and I like that style, too.  But the current style
> works well, so no urgent reason to change it right now.
>
> Anyway, what I mentioned is that the version control is totally
> irrelevant from the review process.  The merge process like above
> works only if the detailed review can be skipped (i.e. push from
> trusted subsystem maintainers).  But it doesn't work if you want to
> review and correct codes.
>
>
well I'll keep the code in my repository till I'm done with it..

I fixed up the playback for 40 seconds now, afterwards it adds some
buzz again.. (there must be some kind of synchronisation in it ..)
I disabled recording for adding the playback .. I also need to fix
this up again..
Not sure if that device supports to adjust the volume.. I'll check
what the windriver does when moving the sliders...
So far everything looks promising with the reverse engineered specs :)

Markus

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
