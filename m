From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: max98090: add digital mic mux to
	record path
Date: Fri, 17 May 2013 12:07:33 +0100
Message-ID: <20130517110733.GK1627@sirena.org.uk>
References: <20130516175241.GF1627@sirena.org.uk>
 <1368731034-30135-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4618520528473037017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FC8326031A
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 13:07:52 +0200 (CEST)
In-Reply-To: <1368731034-30135-1-git-send-email-abrestic@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: alsa-devel@alsa-project.org, Matthew Mowdy <Matthew.Mowdy@maximintegrated.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Evan Ragsdale <evan.ragsdale@maximintegrated.com>, Sachin Kamat <sachin.kamat@linaro.org>, Ralph Birt <ralph.birt@maximintegrated.com>, Dylan Reid <dgreid@chromium.org>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org


--===============4618520528473037017==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2013 at 12:03:54PM -0700, Andrew Bresticker wrote:
> The max98090 driver currently treats the digital mic enable as a supply
> on the record path, causing the digital mic enable to always be turned on
> when attempting to record.  This is incorrect, however, since the digital

Applied, thanks.

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRlg9yAAoJELSic+t+oim9yUMP/0wVoSZeTeV284+q1Mx+92iq
khkdszgBpjuyHhZcdxOcsIK11A6SYkfR4gcHJee4MD8q1i6XRAnfrhdDt4EKfc9D
O3TioJb2HW1xfSY7f6OxDYzpmWYULksg7FJvJL4CVdjz3NhmohleLvCYlwJgfF5Z
NusRkc2HMVprfa7+7ixTuM1ntndVNSMu1soWPaPypqsLkGCKku2jD9d5mdtDI63p
c3ugz2dd4sLDxkzp9BVyfXwE+CQJrvhJ2CFiSInt6P4YMM30OHpdQ8Hsb97QdBhO
k2LbgFI+oC72Z8KXmppEzYmjhJMDBfrQsvu+CMV8+LYY9a1lW6NysCuzsr1geprA
LriVRVzTX6fB0R0HbNnq6i5TzT/euBH/1LrqpT14EVobQfsu4Z59PbZhjPFtTyOC
4GkQZqqLe8R2T1nMC38NeJpOxwCQW0XETq0pvQcYm81cYLyQ9/wrDO+DTRBh6chA
MxqOTCW1LzaNNA+xTCMPcds/2mb4vuDO2bvPUQUAO/fuTbiClVy0cRHI7j5aKzrX
uKivlObwunuCVrWBkm00ts07/TqaqDWNumCbvnJZ89JgVJxkB6w5I8I89uaiY5yO
0jixnItwjkvj7MJ4mEvKgWn1GZnq+cOI4SaACOSRTnOd+gILAtQAgJWtyuxYAeC6
2L/SHPp1p3qt8rsn1y5j
=kkJU
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--

--===============4618520528473037017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4618520528473037017==--
