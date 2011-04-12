From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: pls help to debug / patch ALC861 on Uniwill L51RI
Date: Tue, 12 Apr 2011 15:41:19 +0200
Message-ID: <1302615679.4323.113.camel@mattotaupa>
References: <loom.20110410T104313-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1556427051752352718=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id C3A4E1037F2
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 15:41:21 +0200 (CEST)
Received: from f053043024.adsl.alicedsl.de ([78.53.43.24]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q9dqY-0004zf-6a
	for alsa-devel@alsa-project.org; Tue, 12 Apr 2011 13:41:34 +0000
In-Reply-To: <loom.20110410T104313-232@post.gmane.org>
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


--===============1556427051752352718==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-KYztM3XptpSonJskTJOx"


--=-KYztM3XptpSonJskTJOx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Florian,


Am Sonntag, den 10.04.2011, 08:51 +0000 schrieb Florian:
> I have a laptop (Uniwill L51RI [Gericom Hollywood Advance]) with HDA ALC8=
61.
> On initial installation of Ubuntu (any from 8.x - to 10.10) sound output =
works
> with ALSA without problem, input not at all.
> I have managed to get the microphone sound (int. or ext. can't remember) =
played
> back via speakers using HDA-Analyzer,
> not managed to get it to record etc.
>=20
> My plan:
> >From a clean install (preferable Ubuntu 10.10 or 11.04) compile newest A=
LSA;
> then what are the first steps to do to be able to trace my steps and to g=
et
> support here or somewhere else?
> Who can help me to debug the whole thing and make it available for everyo=
ne?

since you are using Ubuntu, the easiest way is to follow their
instructions to solve sound related problems and report it to them using
`ubuntu-bug audio` [1]. There are several developers working for(?)
Ubuntu who will probably be able to help you really quickly.

> Where should I put output from alsa-info.sh,

The developers prefer it, if you attach it to your message to the list.
But you can also *additionally* upload it to the ALSA site.

> who can help me make a new model for snd-hda-intel module?

The developers if they have time. I guess for this it is better to bug
them on the IRC channel.

> How do I use the codecgraph?

Sorry, I do not know.

> (I'm happy to get some direct links for specific pages, however, I gave u=
p on
> google, followed everything I could find. Most sensible seems to me try
> HDA-Analyzer together with someone who can help me get a bit further [if =
I get
> mic sound to output, how do I get it to record etc.])
>=20
> UPDATE:
> Currently I use Ubuntu 10.10 32bit, with HDA Analyzer I managed to play a=
round a
> lot and can output the mic-input (int+ext) directly to speakers and headp=
hones,
> however, I cannot find a way to send it to any software/make it available=
.
> in the standard gnome audio capture software (forgot the name) I can reco=
rd
> software output (eg. mp3's) when i switch the used audio device to "Analo=
g
> Output" and then back to "Analog Duplex" (then nothing is selected in cap=
ture
> device - the moment I select the only available device, "mic", there is n=
othing
> to be captured any more).
>=20
> any hints, advice?

I am sorry to not be able to help you right away.


Thanks,

Paul


[1] https://wiki.ubuntu.com/DebuggingSoundProblems

--=-KYztM3XptpSonJskTJOx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2kVn8ACgkQPX1aK2wOHVhw5wCfXuA13+PxjR0dwBM8vRBcXJW7
vhQAn2SJLz/+3r+bMI4NcdM5fin9AIsx
=Dzr3
-----END PGP SIGNATURE-----

--=-KYztM3XptpSonJskTJOx--


--===============1556427051752352718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1556427051752352718==--
