From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: ac3 in/out
Date: Thu, 23 Mar 2006 18:06:21 +0100
Message-ID: <1143133582.8395.14.camel@localhost>
References: <1142936836.4759.3.camel@localhost>
	 <1142965025.4532.132.camel@mindpipe> <s5hbqvzzlss.wl%tiwai@suse.de>
	 <1143020483.11724.46.camel@localhost>  <s5hveu6yd2u.wl%tiwai@suse.de>
	 <1143024848.11724.64.camel@localhost>
	 <1143063593.3823.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tUhFc5Npyw3Gt4sxtFL/"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1143063593.3823.21.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>, ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-tUhFc5Npyw3Gt4sxtFL/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-23 at 08:39 +1100, Benjamin Herrenschmidt wrote:

> > Ok that's what I figured. Well, it has to change if I shall be able to
> > write a driver for the digital output of above chip.
>=20
> Well, you can be sneaky in the meantime :) If you use small buffers and
> large dbdma command lists, you can have the dbdma command list skip the
> status data but that mean one output command per sample (or packet),
> fairly horribly inefficient if your ratio data/status is not high :)

I don't think so, since the user/channel status bits are interleaved
*bitwise* :)

Though there's another thing I don't yet understand. If you look at the
three datasheets of the topaz chips, you'll notice that one of them is a
receiver, one of them a transmitter, and the third a transceiver! Now I
really wonder wtf apple is doing with them.
But to find out that, I first need to write a topaz module that probes
which one of the chips it is :)

johannes

--=-tUhFc5Npyw3Gt4sxtFL/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCLVi6Vg1VMiehFYAQIy1g//deQw1GCmldWo7KUIfb+DcfSh+Y0kHvs0
AYuZIER2DPZzz/FC98fGhOjyCt4joaD7inAvmvcHA+85Ck3hs15KR8177esGa50i
w9kGd6iX6UrHcSVVYq2IdkBmtDFaJ9AhmHkQnnAVD8vndBzkKK3k3Gk81DGio/O6
VIV1D4+c65VESBzzDSNP9tHLlbxprrdHLqJH2oZJ38aW/OAC5HZ/zMonoVLLOPz1
PU0/Mfa5z3xhdyn61oacDRhtXDsuIDhEaATxRzR35TOY3pikr72mF8LL3uvlIAn4
OCkv4EH1kOw3uHZ3q2fx6e3ZcN91ZfvAYxFtGd9Dztu/YOKUwYeMuzWTThJffhhd
Pn/XQdMKGdwS22iv6aYYGMLpG1Ip+1IeV50S0veq0pTfUjq28+clnQ4n20YKdTp8
BNBRorrXYbWaJ4EbujbNY9hh22FObrrJNDG1bMDqZGc/WtE1gKnrU0Xv/DbNT+Af
LJSM2Ml0BlklERMtVhwOBcjN9H4ovJZ3ENfkeeh2Y3Nadh9LWtrWN0hqrtznH1Hr
0jAhj5afFpzSkPJOZr+pbDVwzD/36vk00DLyQltuZQchim07T61T4jemWq/vVx/k
VwrTgJ3zq41Wwvl7IXji6RjCb88wE/VVEQVoVC9kZOhBBDxkqck4bFTNMSfMaroN
Nq6nOSel4fg=
=aXAD
-----END PGP SIGNATURE-----

--=-tUhFc5Npyw3Gt4sxtFL/--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
