From: Reimar =?utf-8?b?RMO2ZmZpbmdlcg==?= <Reimar.Doeffinger@stud.uni-karlsruhe.de>
Subject: Re: [Fwd: Re: [MPlayer-dev-eng] AV out of sync with "-ao alsa" in gmplayer, mplayer works ok]
Date: Thu, 13 Jan 2005 15:10:50 +0000 (UTC)
Message-ID: <loom.20050113T160235-955@post.gmane.org>
References: <1104311474.2984.2.camel@krustophenia.net> <yw1x1xd976fz.fsf@inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi,

M=C3=A5ns Rullg=C3=A5rd <mru <at> inprovide.com> writes:
> Lee Revell <rlrevell <at> joe-job.com> writes:
> > OK, I trolled the mplayer dev list, and got this response.=20
> >
> > Are Reimar's statements about memory leaks valid?
>=20
> No.  I regularly run my player under valgrind, and it reports no ALSA
> related leaks.  I also run the same player for weeks on end, and the
> memory usage stays below 4MB, after opening, playing a bit, and
> closing the sound device thousands of times.

And how about opening and closing the mixer thousands of times? I posted =
a
stripped-down sample code that ahould show the problem a few days ago...

> > On Tue, Dec 28, 2004 at 10:55:33PM -0500, Lee Revell wrote:
[...]
> >> What's the deal?  Why is it so hard for the mplayer developers to ge=
t
> >> ALSA support right?  I hack on ALSA a lot, so if there is some probl=
em
> >> with the ALSA API, we would like to hear about it on the mailing lis=
t.
> >
> > Yes, please fix the huge memory leak with ALSA output,
>=20
> Never seen that one.  Could be a leak in mplayer's ALSA support, of
> course.

Well, I didn't say that it was in the ALSA lib. I only said I think so ;-=
)

> > especially when changing the volume (it is cause by the call to
> > snd_mixer_load, but I couldn't find an ALSA function that frees that
> > memory again snd_mixer_free has absolutely no effect  ).  Also
> > the problem is more that the Gui is not well supported.
> >
> >> Or do you all just use OSS still?
> >
> > The OSS interface is actually a lot nicer, so yes it is supported bet=
ter.
>=20
> LOL

Well, maybe it's just because whoever wrote ao_alsa in MPlayer did it the=
 wrong
way, but compare the size of ao_alsa.c and ao_oss.c and you'll probably s=
ee what
I meant...

[...]
> > mixing, no way to use it without getting into synchronization hell
> > because it uses threads,
>=20
> Oh, never forget that the mplayer folks hate threads.

Yep, and it's not entirely unjustified...

> > hundreds of function calls to initialize it, and those memory leaks
> > that to my best knowledge seem to come from the alsa lib (my best
> > guess is that this is because like in conf.c, in _snd_config_make
> > pointers are overwritten without being freed first).  What makes it
> > a bit difficult to use it that it's quite difficult to find the
> > function that is supposed to free things again, they e.g.  often
> > aren't located directly below the allocation function in the
> > headers, and that there is a snd_mixer_load function but no
> > snd_mixer_unload as I would expect it.
>=20
> OK, the documentation could be better.

Well, that's true for most projects, certainly including MPlayer ;-)
I have to admit I only looked at the headers, I didn't look for/download =
the
documentation, but I'm not the maintainer of that code anyway...

> > All these things together made me give up on ALSA.
>=20
> I'll skip the insult this time.

Thanks :-)

Greetings,
Reimar D=C3=B6ffinger



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
