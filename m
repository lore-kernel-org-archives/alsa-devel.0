From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio Miniconference 2013 schedule - Edinburgh
 21st October
Date: Mon, 7 Oct 2013 18:44:48 +0100
Message-ID: <20131007174448.GT21581@sirena.org.uk>
References: <20131003181754.GE27287@sirena.org.uk>
 <5252EDE2.9070902@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1497413242507511566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DD52F265162
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 19:44:57 +0200 (CEST)
In-Reply-To: <5252EDE2.9070902@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1497413242507511566==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="53TzBEXPl5+8hjUY"
Content-Disposition: inline


--53TzBEXPl5+8hjUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2013 at 10:22:42AM -0700, Patrick Lai wrote:

> Lately, there has been a lot of emphasis on reducing cold start latency
> which audio hardware path setup takes up good chunk of time. I found
> DAPM takes up quite a bit of time finding path to enable. In addition,

What are the problems you're seeing here?  This used to be a big
problem for modern CODECs with big sets of widgets and routes but the
optimisations I did a while back (which made it into v3.4 so I think
everyone is using them now) and the work that Tsutsui-san did in v3.10
on improving the graph reset got it reasonably under control for the
systems that I was aware of having trouble.

The commits from Tsutsui-san were:

   0e669246dcd1 ASoC: dapm: Remove redundant clear_walk() for supply widget=
s=20
   1059ecfa0f1e ASoC: dapm: Only clear paths we've walked

(mainly the second one).

> DPCM could be enhanced to save on cold start latency by enabling
> front-end & back-end in parallel if underlying hardware can support it.

Hrm, nobody mentioned any problems with CPU side startup times
previously.  What exactly is taking the time with this stuff - is it
something that could be pushed into DAPM and use what's there already
(or alternatively then be optimised and used for CODECs too)?

> I would like to see if we can have some discussion on optimization.

Well volunteered :)

--53TzBEXPl5+8hjUY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUvMNAAoJELSic+t+oim9L3IP/jeNlu5yGXI1iSEnh1JkV1R3
hlmEzx/OXBiEtbapHQ6hqPu5hKSrRgifp+oh5XkomXc0QZlsCkplyP0FIauHfiU3
5jVaRCiLf58xi2iUud6ILAPQrQcFfil/JUfGEiFXLm5DsECPjBB9tfY339aqvgWQ
bMNZqzGGT1w1D/nMveQhNtxF1ezsDpIqktrdQRO+ECGmI5h6hrJOMJkZm3BvAD/J
vDEzscznChvWelZvikd2BXJ1mbhCuN4IhGwvOhU8n1/VCcCA1cs+ff7sQE2h0tmC
bjWTSHcTOSODNaHoox45w6qmAibQ3G/DWREA2J34TVho2uuIoIGrvkSQ8egon/+T
mvJLbTELD/2O7IR+m5Z6CBJpAcQCsgYghi+CocRciJcAFVnYYXxhcj98C83H/hfZ
sir/zJ35hCLubkbinDWnmJXOG1nhaNOHnDvihytnov1RZfhilmSEPw4MEs5R15fW
OZR/bUdi/PAmX01dexkYetITuaotuasgUyCz+a/SThtrccL1RWOajMm18BHRuyrR
xQX+HIq2Ks/DcSMpAu+vpf0k2Wjjsng/3ASr/Hh1RH53HXFhy1D6NrD9uLp5glVK
D5tnggQOj1N0YWfMfT+ssevX4FEbw0Ou0It7GWRvX8H/Q7C1e2lifiRLDoY0lp5q
A0clPo5Ir7B72hGFCrOO
=WoF9
-----END PGP SIGNATURE-----

--53TzBEXPl5+8hjUY--

--===============1497413242507511566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1497413242507511566==--
