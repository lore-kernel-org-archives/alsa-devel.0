From: Florian Schlichting <f.schlichting@ucl.ac.uk>
Subject: debugging nm256: some results, many questions
Date: Fri, 24 Feb 2006 02:52:54 +0800
Message-ID: <20060223185253.GA7954@tigerbay>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

spurred by the upcoming removal of the OSS audio drivers and a post on
LKML saying ALSA developers lack access to hardware / testers, I thought
I should get a little more active and find out about the reasons for
frequent hangs when booting my Dell Latitude LS (the 500 MHz version
with 2MB video RAM) - the issue looks similar to
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D328
ie setting another workaround than the default (=3D1) doesn't have any
effect.

I was able to narrow down where exactly it hangs (most of the time), but
have as yet no idea why this doesn't occur with the OSS driver or why my
ideas for workarounds weren't successful. I must say that this is the
first time I'm looking at kernel code and I'm pretty inexperienced with
C, so I hope that some of you who are much more experienced with the
sound architecture have some pointers and ideas for me...

I'm not sure about what "is known" about this problem (or where that
would be documented), so what I write now is fairly extensive...


hangs occur at initialization, more precisely when both snd-nm256 and
snd-ac97-codec are loaded (repeated loading and unloading of snd-nm256
alone is fine) - it never died on me during ordinary use. nm256 is being
initialized via snd_nm256_probe calling snd_nm256_mixer on line 1648
calling snd_ac97_mixer on line 1249. This is identical for all hangs.

snd_ac97_mixer and snd_ac97_mixer_build in ac97_codec.c is a bit more
complicated, as hangs occur in various places when the different
registers are initialized; for me, most occur when initializing the
volume of Phone, Mic, Line-In, CD, Video and Aux. As far as I can tell
there's no pattern what register it hangs at. All eventually call
snd_ac97_read, which returns ac97->bus->ops->read(ac97, reg) which is
snd_nm256_ac97_read which, after some delays and waiting, returns
readw(chip->cport + offset) in snd_nm256_readw. This is as far as I
could trace it, and ALL hangs during initialization occur here.

Is that as far as tracing the source of the problem can go? So what can
be done about this, and why doesn't it occur with the OSS driver?


I did a little searching and found the web pages of the original OSS
driver author, where he says among other things (at
http://web.archive.org/web/20020830005020/www.uglx.org/sony-nm256av-notes.h=
tml)

> (However, I've run into problems with hanging the laptop while writing
> to some of the optional registers; you have been warned. The safest
> approach is to stick with the standard set of registers.)
>
> Also, if you attempt to read too quickly from the mixer, it will also
> cause hangs. Bad juju. The driver caches a copy of the mixer contents,
> and it seems to be successful at avoiding the hanging problem.

I haven't understood how the OSS driver is doing this caching, and
whether the ALSA driver is doing it, too. There are a lot of reads, and
during tracing the hang I had the impression that an increasing number of
printk's is not just slowing down the whole process but also slightly reduc=
ing
the likelihood of crashes. I thus added massive udelay's before and
after the read in an attempt to come up with a fix, but nothing changed
(I couldn't even bring the delays to a point where I'd notice them), so
I aborted this.

The other idea I came up with is that nearly all the hangs occur at
registers I don't need (recording from the mic gets heavily distorted by
the hard drive spinning, and I've never noticed Phone, Line-In, Video or
Aux to do anything, so I really only need Master_Stereo and PCM) and
could perhaps be avoided by telling the driver not to use them. So in
the array mixer_regs at nm256.c:1229 I commented out everything apart
=66rom AC97_MASTER, AC97_PCM, AC97_GENERAL_PURPOSE (which seemed important
for many things in ac97_codec.c) and the apparently indispensable
AC97_VENDOR_ID1, AC97_VENDOR_ID2. Booting with the resulting modules got
me through the initialization very smoothly (I tried at least 10 times),
but it always crashes shortly after completing snd_nm256_probe (on the
console, I still get the new bash prompt before it hangs; on bootup, I
sometimes get a line from the next driver)

What on earth is happening _after_ initialization that's not happening
during normal initialization??? (anything to do with
concurrency/interrupts, and how would I test for that? - notice that in
the above mentioned bug report, the reporter claims that the driver
worked well with kernel 2.6.7, so perhaps it's not the driver but
another subsection, like pci?)


I'm confused, but I hope some of you are still with me and can tell me
whether I've done some things right and what else I could try... I'm
still not familiar enough with ALSA and AC97 to have any idea about what
the OSS driver is really doing differently here (but isn't it
implementing its own mixer??), but since we've got working code it must
be possible to find a solution...

Florian

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD/gSF/R0+cAphf/kRAjMOAKC9XMMjP6tGuFBBGp2yBdYFUTrCrQCfR3wD
8t7S2I2C6oNqj5RXHOeMAAY=
=OuCK
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
