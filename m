From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 20:08:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311172008.28812.pwk.linuxfan@gmx.de>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com> <200311171924.40388.pwk.linuxfan@gmx.de> <Pine.LNX.4.53.0311171944280.16992@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0311171944280.16992@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

WARNING: Unsanitized content follows.
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 17. November 2003 19:50 schrieb Jaroslav Kysela:
> On Mon, 17 Nov 2003, Peter Kirk wrote:
> > WARNING: Unsanitized content follows.
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Am Montag, 17. November 2003 18:16 schrieb Mark Hubbard:
> > > Peter Kirk has an important point. Default dmix ("smart" could be a
> > > misnomer) will only work as the default pcm, therefore if one
> > > application is set-up to use surround51 and another set-up to use
> > > default, then nothing is going to be mixed. It would be better, for the
> > > sake of simplicity and ALSA's target user, to abandon the various pcm
> > > definitions and only use default which would work with all set-ups....I
> > > believe this is what Peter means by "smart".
> >
> > Well,
> >
> > no smart dmix is no "misnomer". What I mean with it is: a implementation
> > of dmix that only starts to mix if there is a need to do it - as long as
> > the soundcard can handle streams without mixing the smart dmix will not
> > do anything, except pass untouched streams to the hardware...when the
> > first stream that would exceed hardware limitation is sent to the sound
> > device, smart dmix would start mixing this stream into one of the
> > existing ones.
>
> The problem is that it's not possible. If you have one application which
> settled parameters with alsa-lib (and alsa driver) we cannot reroute this
> stream to dmix. The dmix plugin works with some assumptions (predefined
> parameters applied at start of first application) and all clients
> (applications) must share same parameters, of course.

Ok,

what you say seems to be valid to me, but not if you implement smart dmix the
way I said =). The way I suggested *every* application would connect to smart
dmix, and none directly to alsa lib (except those that use devices like hw: -
and those should never be mixed). Since every stream is connected to smart
dmix, there is no need to *reroute* anything in the case of needed mixing.
The only thing that has to happen, is that the new stream, that has to be
mixed into the existing one due to hardware limitations has to be resampled
etc. to make mixing possible.
>
> > You name a device I didnt know... "surround51". But, since this is what I
> > call a "consumer app device", smart dmix would lure behind that too, and
> > apply mixing magic if necessary.
>
> It's not too easy.
>
> I think that we should go in another direction. In my eyes, the best thing
> would be to create a very user friendly (graphical) configuration tool for
> alsa-lib which offers with a few clicks to choose dmix, plug or raw access
> to devices. Many users want to do also some "additional" things like
> stereo stream expansion to rear speakers and so on.

In my eyes, configuration should only be necessary if there are any downsides
to an automagic sollution. As long as you dont convice me of some severe
missfeature my suggested smart dmix would impose on the users - there
shouldnt be any need for configuration.

Peter
- --
Always try to do things in chronological order; it's less confusing that way.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uRyqg2ieGvTmHiURAhChAJ9JRoy1JtgbguMN8uBfDXNCxyBcVgCghw10
EvsraioHl1UOyiSPQzgcdsQ=
=1+6V
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
