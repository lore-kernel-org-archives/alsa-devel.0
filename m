From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Fwd: Re: [MPlayer-dev-eng] AV out of sync
	with "-ao alsa" in gmplayer, mplayer works ok]
Date: Thu, 13 Jan 2005 15:11:15 -0500
Message-ID: <1105647075.3457.18.camel@krustophenia.net>
References: <1104311474.2984.2.camel@krustophenia.net>
	 <yw1x1xd976fz.fsf@inprovide.com>  <loom.20050113T160235-955@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <loom.20050113T160235-955@post.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Reimar =?ISO-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@stud.uni-karlsruhe.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-01-13 at 15:10 +0000, Reimar D=F6ffinger wrote:
> > > hundreds of function calls to initialize it, and those memory leaks
> > > that to my best knowledge seem to come from the alsa lib (my best
> > > guess is that this is because like in conf.c, in _snd_config_make
> > > pointers are overwritten without being freed first).  What makes it
> > > a bit difficult to use it that it's quite difficult to find the
> > > function that is supposed to free things again, they e.g.  often
> > > aren't located directly below the allocation function in the
> > > headers, and that there is a snd_mixer_load function but no
> > > snd_mixer_unload as I would expect it.
> >=20
> > OK, the documentation could be better.
>=20
> Well, that's true for most projects, certainly including MPlayer ;-)
> I have to admit I only looked at the headers, I didn't look for/downloa=
d the
> documentation, but I'm not the maintainer of that code anyway...
>=20

Are there any plans to fix the ALSA output so that it doesn't reset the
stream with every xrun?  Since you don't use a realtime thread to handle
the audio there are certain to be some xruns, for example whenever using
the GUI controls in any way or moving the mouse.

http://sourceforge.net/mailarchive/message.php?msg_id=3D8437146

I am still forced to use the OSS emulation for this reason.

Lee



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
