From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Tue, 18 Nov 2003 06:51:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311180655.02528.pwk.linuxfan@gmx.de>
References: <200311171936.hAHJaW1B013634@oud.linuxaudiosystems.com> <200311172128.34259.pwk.linuxfan@gmx.de> <3FB9449E.3030904@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FB9449E.3030904@superbug.demon.co.uk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

WARNING: Unsanitized content follows.
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 17. November 2003 22:58 schrieb James Courtier-Dutton:
> Hi,
>
> Just a general comment on dmix/dsnoop.
> 1) It is not bug free yet.

right. It would be great if you guys that have some overview would map out=
=20
some basic "TODO" - where all outstanding bugs and all missfeatures that ne=
ed=20
fixing would be listed. That way progress could be monitored, and people th=
at=20
would want to help on this task would quickly see what there is to do.

> 2) For smart dmix/dsnoop to be really user friendly, we will need a
> version of it that works in full duplex. I.E. Multiple applications able
> to record the same stream as well as play to it at the same time.
Well,

what I gathered from talking to people, dmix is for playback and dsnoop is =
for=20
capture. Thats why I suggest to implement this using those two=20
plugins...because I thought this would give us full duplex. So yes, full=20
duplex support for as many application as the user wishes is definetly=20
something that my feature suggestion should achieve when implemented.

> 3) If one application wishes to play to "surround51" and a different
> application wishes to play to "front", dmix will have to be clever
> enought to mix the two.

correct.

> 4) If one application wishes to play to "front" and a different
> application wishes to play to "rear", the mixer should be able to mix to
> get 4 output channels.

agreed.

> 5) I think that this sound mixing problem might be better served by
> sound servers like jack.

Hmmm,

actualy I did have a very close look at jack, but the problem that I saw=20
(correct me if Im wrong here), is the fact that jack only works well if the=
=20
applications are specificaly geard to work with it. To quote the FAQ:

#How can I make my app use Jack?
#Your app must be callback-based. This means that you shouldn't block on=20
#writes or reads from a PCM device; rather, you should have your app be=20
#"driven" by a function that gets called at regular intervals. This is a=20
#design decision. Then, take a look at the simple client code, and do your=
=20
#interesting stuff inside the process() function.=20
#Note that code written for any callback API can generally be ported to any=
=20
#other callback API fairly easily. Code that is written around a "blocking =
I/
#O" model generally needs to completely redesigned to be used in any kind o=
f=20
#callback API.

Because of this I tossed the idea of using jack for this asside - and found=
=20
dmix/dnsoop. Now you might say: Its open source, just wait until all the=20
applications are adapted to use jack. But, even if everybody would be=20
convinced of the necessity - it would take a long time. Also one of my main=
=20
interests for this whole mixing thing is voice-communication alongside with=
=20
games. And you might know that (closed source) games like quake3, unreal=20
tournament 2003 etc. will just NOT get any special jack support in it=20
anymore, especially since theyd needed to be "completly redesigned".=20

> 6) software mixing is ok, but software resampling is not a good idea to
> do in alsa-lib, because a) It cannot do good quality resamplings because
> t is trying to keep latency low. b) A audio/video application could do
> resampling better because it could do it at the decoding stages, before
> latency and audio/video sync is a problem.

Ok, Im not the guy that knows about the workings of alsa-driver, but I gues=
s=20
currently  a application like xine *knows* what sample rate the soundcards=
=20
supports, and then gives alsa-lib a soundstream that is sampled to that=20
specific rate ? If this would be the case, then nothing would change if sma=
rt=20
dmix/dnsoop would be implemented. If the only playback stream is already=20
taken, with sample rate "X", then alsa-lib would tell xine, that the=20
soundcard [currently] only supports sample rate "X" in hardware - and xine=
=20
would do the resampling to "X". Only if a application that doesnt care to=
=20
investigate what samplerates are supported just sends sound to alsa-lib, in=
=20
sample rate "Y", then resampling would have to be done.
If I understand it correctly, then current alsa-lib will resample if=20
necessary. To quote the .asoundrc wiki:

#Which automatically converts your samples to a 44.1 kHz sample rate while=
=20
#playing. It's not very useful because most players and alsa converts sampl=
es=20
#to the right sample rate which your soundcard is capable of, but you can u=
se=20
#it for a conversion to a lower static sample rate for example.

There would be no change in this behavior, except that it might be necessar=
y=20
more often (in the cases where alsa-lib currently says "no way stream,=20
soundcard is full").

> 7) For mixing, each open of the alsa multi-open device should have it's
> own volume control per open, and not just the hardware backend volume
> controls. The application could easily control their own volume, without
> effecting other application's volume.

This extends my feature suggestion, but its IMHO a great idea. If this is=
=20
possible and viable, go for it too =3D).

> Summary: -
> An application should be able to use device names like "rear", "front",
> "surround51" and then have a separate control to tell alsa whether it is
> allowed to do resampling or not. Then at least the more advanced
> application could decide for itself whether to use alsa-lib's low
> quality resampler, or implement it's own multi-tap interpolation filter.
> For a video/audio application like xine.sf.net, being able to open the
> alsa device in such a way to ensure we know where the sound will be
> routed(which speakers sound will come from) is useful.

sounds right. I realy hope you guys can do this.

Peter
- --=20
Everyone wants results, but no one is willing to do what it takes to get th=
em.
		-- Dirty Harry
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ubNvg2ieGvTmHiURAmt0AJ4suWE18CpAVTd0bWwwJw6qYN9KiwCfbKoD
JUquoVkakeAfLrm26zVff78=3D
=3DFn3b
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
