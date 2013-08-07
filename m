From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: bt-sco: enable OF support
Date: Wed, 7 Aug 2013 15:46:28 +0100
Message-ID: <20130807144628.GC6427@sirena.org.uk>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
 <20130806170430.GL6427@sirena.org.uk>
 <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2572675331724183973=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D1B2B265506
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 16:46:32 +0200 (CEST)
In-Reply-To: <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Workgroup.Linux@csr.com" <Workgroup.Linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============2572675331724183973==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="POjlveFHrWq2ZO+N"
Content-Disposition: inline


--POjlveFHrWq2ZO+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2013 at 03:59:46PM +0800, Barry Song wrote:

> For 1, what kind of codes will have in the codec driver if adding a
> link to UART in codec dts node? UART is very generic to transfer path.
> it even doesn't know bluetooth is running on top of it.

> For 2, if the case is that we add codec subnode in UART node,  the
> UART driver will need to walk child nodes and extend platform device
> for them, it seems it is not uart driver likes.

I don't know what 1 and 2 are (they weren't numbered in the mail you're
replying to)...  I'd expect that any intelligence would go into
frameworks or into the device for the BT so for example if the BT device
was hanging off the UART then the kernel would have generic support for
parsing the DT and knowing that a fixed device was connected to the UART
and be able to handle that - AIUI line disciplines are often used for
this stuff.

--POjlveFHrWq2ZO+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAl3BAAoJELSic+t+oim9mSAP+wYJujXjckbLy6DBh2OJb5ii
UbaknpkM4Pg/IInNnYOU1nBVpD3Nb5X2OgXj5Cfz8if7nNQV59bOggqD0X79iyV0
TPAOEQGl7sALr15JgNpEzBCq87KFZJu7wMlBJ/cOLnwl5KjjqwsLniuGi4Oxadyf
TEC1cz47MTe96c3iHzMs5U6bTCwp9GLnQXXn3fnOs7Z0zmeHeESBskHFpcNpUrYs
fSObw/U1Rt6Jb2yz45QbpoIa8GL8O1VjyhfiVy2rJcrhgZtWdIXV7Tio+vVR+tPz
Eg5xVX9S2Bj5qs9/HO66YWcgvA/m4N2cGY9/opIU7pk7TuI5rILrECOmD2ekBRRm
JA9OAWKMPWV1J4JBF5YqFQrtVQhZNGGiVCmBHve9VYa/b/rXF5UguAs5aLG5VBD/
2ss1PzLu/JNknw+4C+mBg07NI7PY/LiuY+5mXJnJu1uMSDm/EyH1ySmaj8YRpg5w
cz5AD6PJUQMNnvGQ15wtfDlltpPLuLw4S9IHtdxCHvae7VU9NP9cZRWCrKxciD7i
vtP3qzI34EiHQmiEHGqIFPe412ZPfV9wCjdQ0EY7QqFMFRHx80vvpMdPi+PhHMM1
cQ0+CgIOr3CHtf5F4aeMeLzMR4oWlYZh+0FV1KpMu/TQVgudroA0asjDkDvjSDkE
I//aT39QqIVrBiDQN3pL
=mO//
-----END PGP SIGNATURE-----

--POjlveFHrWq2ZO+N--

--===============2572675331724183973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2572675331724183973==--
