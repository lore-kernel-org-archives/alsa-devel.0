From: Thomas Zehetbauer <thomasz@hostmaster.org>
Subject: Re: [Alsa-user] ALSA / emu10k1 / SPDIF / surround?
Date: Sun, 28 Aug 2005 04:18:07 +0200
Message-ID: <1125195487.2684.8.camel@hostmaster.org>
References: <1124755115.5763.3.camel@hostmaster.org>
	 <1125166820.22285.68.camel@hostmaster.org>
	 <1125168446.25011.68.camel@mindpipe>
	 <1125173150.22285.103.camel@hostmaster.org>
	 <1125174445.25011.76.camel@mindpipe>
	 <1125177706.22285.144.camel@hostmaster.org>
	 <1125178767.25011.86.camel@mindpipe>
	 <1125181627.22285.155.camel@hostmaster.org>
	 <1125183623.25011.102.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nfHOETdJx2K+QoLNxmxE"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125183623.25011.102.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-nfHOETdJx2K+QoLNxmxE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-08-27 at 19:00 -0400, Lee Revell wrote:
> Try this patch.

Please send patches attached, not inline, I had to manually apply. Used
alsa-driver-1.0.9b as basis.

> If you still get both a PCM and a Wave control, and distortion at high
> levels, try removing the "ac97_chip =3D 1" line.

I still got the PCM control and distortions with the "ac97_chip=3D1" line.
Without it I lost many controls including "Master" and could not hear
any sound at all.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Governments, if they endure, always tend increasingly toward aristocratic
forms. No government in history has been known to evade this pattern. And a=
s
the aristocracy develops, government tends more and more to act exclusively
in the interests of the ruling class -- whether that class be hereditary
royalty, oligarchs of financial empires, or entrenched bureaucracy.
                                       Bene Gesserit Training Manual=20




--=-nfHOETdJx2K+QoLNxmxE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQxEe3mD1OYqW/8uJAQIlAQf8DuWrzs1oSyxJOZ/DZcrMjMJiIPmzamjw
QV02whdAIm1AemWM1kQsQ73IFtG3W0VSbeUaFTETt4Klf5F/nHnE/1DCgOusgCz3
XKuYPW0x+8LCRTFMFAe8y7xJhtFUAKNYAhF1xF+X4+Gr1t2KwhmD+G4snr10ycS3
ZccS1oqOU76vsKCqYeAPoKY21/oNTQ8p29rZy7dwyzbMuXBqozHXBKVM0/GzBzuA
d9ikBwoC0xMhPuq8t4DCa34cI85ZykyaZgVeNaP2BCWAgiT6FbiRm02GVnlgqkhX
hFtnHaa+tyOFk5b3jLYGA0TcEL+DpuuuwM9Au1YoRx5jT6g+c4Gchw==
=597G
-----END PGP SIGNATURE-----

--=-nfHOETdJx2K+QoLNxmxE--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
