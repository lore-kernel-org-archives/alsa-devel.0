From: "David E. Storey" <dave@tamos.net>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: 12 Jun 2003 15:12:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055445158.415.24.camel@localhost>
References: <5ec5dab668378a9a0eedac678095e3bb@essej.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-H40Z5AGb4DDNAVTzKIgp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5ec5dab668378a9a0eedac678095e3bb@essej.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jesse Chappell <jesse@essej.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-H40Z5AGb4DDNAVTzKIgp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Different headphones have different sensitivities, and line level
> can get pretty hot electrically.  But I was surprised at how far down
> I had to set it though.  I wonder if I was getting the signal
> from channels 1 & 2 through several paths summing on each other.
> It is a bit confusing.

I believe that the Hammerfall series sums the signal source to a 36 bit
value and the last few least significant bits are truncated to bring it
back to 24 bits. I've been REALLY curious about software mixing and the
RME guys seem to know what they're talking about:

<http://www.rme-audio.de/english/techinfo/hdsp_tmhard.htm>

> David S (or Thomas C), what are the chances the work you guys
> have done (independently) on a UI hdsp mixer could be released?  I think=20
> I'll be needing some easier control.  I'll be tempted to write my own if
> nothing shows up to work with soon ;)

I could release something now, BUT... it's still very much in
development and it's not technically correct. I'm waiting to hear back
from the TotalMix guys with some specifics on algorithms used to render
information back and forth from their UI and the hdsp. My communication
with them is somewhat latent as I'm going through a couple people, but I
do know that my questions have reached the right people. As a proof of
concept, it works. (I started on it a week ago and have been rabidly
working on it in my "spare" time since I got a fairly big gig coming up
with some people interested in going IEM by then.)

It's not really designed to be TotalMix for Linux per se, but rather a
digital IEM mixer. As such, I had slightly different requirements
although the basic ideas are the same. I just got mute and solo working
monday night which I'm really happy about. They're slightly more complex
than I had originally thought since one has to take into account channel
state, but I think what I have is fairly efficient. I also don't have
the playback channels mapping yet and I don't have any real particular
need to for what I'm doing other than for completeness.

d!

--=-H40Z5AGb4DDNAVTzKIgp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+6NCm+5sC2muyxOMRAkMGAJ40bzcw1l0/VUMr1Wi8GAA+sBg66gCfd/Vk
2atbfLKuJPbmnthBH52ZHCk=
=mE5Q
-----END PGP SIGNATURE-----

--=-H40Z5AGb4DDNAVTzKIgp--



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
