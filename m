From: Florian Schlichting <f.schlichting@ucl.ac.uk>
Subject: Re: debugging nm256: some results, many questions
Date: Sun, 12 Mar 2006 01:44:21 +0800
Message-ID: <20060311174421.GB7775@tigerbay>
References: <20060223185253.GA7954@tigerbay> <s5hfym8vd0k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hfym8vd0k.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

thanks for your reply, and sorry for not coming back to it in two weeks.
Here's some more about nm256:

On Fri, Feb 24, 2006 at 07:15:55PM +0100, Takashi Iwai wrote:
> At Fri, 24 Feb 2006 02:52:54 +0800,
> Florian Schlichting wrote:

> > there's no pattern what register it hangs at. All eventually call
> > snd_ac97_read, which returns ac97->bus->ops->read(ac97, reg) which is
> > snd_nm256_ac97_read which, after some delays and waiting, returns
> > readw(chip->cport + offset) in snd_nm256_readw. This is as far as I
> > could trace it, and ALL hangs during initialization occur here.
> >=20
> > Is that as far as tracing the source of the problem can go? So what can
> > be done about this, and why doesn't it occur with the OSS driver?
>=20
> The OSS driver doesn't use the common ac97 codec module but its own
> one.  I bet OSS nm256 would hang, too, if it were to use
> ac97_codec.c.
>=20
> Perhaps it's good to trace and record what accesses OSS driver does,
> so that we can comapre the sequence.

I don't entirely understand what the OSS driver does; it certainly does
make some use of the ac97 codec, eg in nm256_resetAC97() it uses
ac97_put_register() to preload mixer settings into the codec's mixer
cache. A comment in the source says:
/*=20
 * Initial register values to be written to the AC97 mixer.
 * While most of these are identical to the reset values, we do this
 * so that we have most of the register contents cached--this avoids
 * reading from the mixer directly (which seems to be problematic,
 * probably due to ignorance).
 */

I noticed that ac97_get_register() will ALWAYS check and return the
cached value, if it's valid. For ALSA, there's snd_ac97_read() and
snd_ac97_read_cache(), and the mixer initialisation makes heavy use of
the latter:

While during OSS initialisation, there occurs ONE (1) read to the mixer
registers (namely, AC97_RESET), ALSA initialisation performs a total of
NINETY-TWO (92) mixer register reads, namely (in the order they occur):

AC97_VENDOR_ID1 once
AC97_VENDOR_ID2 once
AC97_MASTER 	eight times
AC97_MASTER_MONO ten times
AC97_PC_BEEP 	once
AC97_PHONE 	ten times (this one's a popular hang)
AC97_MIC 	ten times
AC97_LINE 	eight times
AC97_CD 	eight times
AC97_VIDEO 	eight times
AC97_AUX 	eight times
AC97_PCM	eight times
AC97_REC_GAIN	three times
AC97_GENERAL_PURPOSE ten times


I think this is clearly a bit excessive - I didn't trace where these
reads occur, but why would you need to read the same register value ten
times in a row - especially since OSS doesn't read them _ever_ and just
gives back the previously written value?=20

So, given that reading mixer registers is what's problematic with this
piece of hardware, I think this is where to start doing things
differently. One question is why the ALSA ac97 codec doesn't use
snd_ac97_read_cache() during initialisation.  Would you be willing to
change that? Or should I rather come up with caching in the callback
function, so that the changes/workaround can be limited to nm256.c?

(And, more fundamentally, do you agree that this is a valid analysis of
the problem?)

>=20
> It might be the buffer address calculation.  But I remember that I got
> crash even with exactly same address as OSS driver uses, too.
> Anyway, it's better to reduce any hang-possibilities.

I didn't fiddle around with that, but I noticed that the OSS author's
web page gives a different address for the mixer status offset (=3D0 if
safe to write to the mixer) than what is currently used in both OSS and
ALSA driver; I played around a bit, and its value (offset 0xa04 or 0xa06
or 0xa08) doesn't seem to have any effect on hangs...


> BTW, can the hang be avoided if you remove the whole mixer section?
> i.e. let snd_nm256_mixer() simplly return 0 without doing anything,
> and try PCM playback/capture.

If I remove the mixer, there are no hangs any more, but I can't play
music (no errors, but no sound either - as if the master mixer was
muted)

>=20
> What about if you skip the whole snd_nm256_ac97_reset() sequence?

this doesn't do any harm, and I've got the impression that it
considerably improves the likelihood that initialisation will complete -
=66rom 1/5 to 3/5, I'd say.


unless anybody has got other suggestions, I would try to implement some
mandatory caching for reads from the mixer next...

Florian



--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEEwx1/R0+cAphf/kRAoyHAKDNzNWFnupbe3vPMiSCCJk97mXeTQCgjUdr
nTz25jcRGO7W63p6Y2FHFaw=
=jPYa
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
