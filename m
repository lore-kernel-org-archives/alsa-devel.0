From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: fsl_ssi: Add monaural audio
 support for non-ac97 interface
Date: Mon, 2 Dec 2013 17:37:21 +0000
Message-ID: <20131202173721.GM27568@sirena.org.uk>
References: <1385998143-20196-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0453707669560733033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B5A1264F13
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 18:37:27 +0100 (CET)
In-Reply-To: <1385998143-20196-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============0453707669560733033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="elWSKwo949DbmCL3"
Content-Disposition: inline


--elWSKwo949DbmCL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 11:29:03PM +0800, Nicolin Chen wrote:
> The normal mode of SSI allows it to send/receive data to/from the first
> slot of each period. So we can use this normal mode to trick I2S signal
> by puting/getting data to/from the first slot only (the left channel)
> so as to support monaural audio playback and recording.

Applied, thanks.

--elWSKwo949DbmCL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnMVOAAoJELSic+t+oim9cIYP+wcwWzHsCXV+yHVkVWmWN+SU
eyFiNv5jtKCUl2w6+rOm0hnewTj9L1EA5RkTzjy7zZZMZa5nqXXyvKCKp/ZezMDn
dIYyL9aRFHd+HDL7NLUnfQZf70nA20/OeNGjd4K9OUgMbrjoI1HVRHWDUn/6wFYx
oIrYwGfAC2clzs8nonGSrcqfGqvi7dvKwRpuYtL62avroDnt1qcJk5olLauI1esk
rN/poGG+h5fpoJ8IdUp/kVPUHzPzQiw4YF85ibXB/47NrYHx2MLUfd2yXJ7UBtar
DauBkrvoLvewUbeli/SHpHuCEp9zz1Q2CFIOm/gj8TZ89YAbWwdhka9danaHFYqh
VxZhC5AakFlf7EjFnbGz4+0L+P3QKFUUgF5nQE8E2FkrhvghiKJ3rgNZAtZEKMwP
5te2VTeIQnkdKpzZ5sI3D7xdZv+bRdKu5xVJsHh3KvTaDWstd4aS1Yeb8xMWPc/4
WxSSwvvH6kmFes1VNQhSdf6YeQsWFkh0n3yNrezh0xqMULJ1HCuI+dsOVBoUZQmj
9vj3xEdcZp7/NgwL/BQhzFT0RjozjMxB4goTaqWmX1POwswJuoNYz2jmGVS+lFKF
DFBBtGv318bD/WCbp7UCpSCTMUUjfwGzCAyFO56PCDDOFA181OZhD7WdUW2iCFFn
IFlNFVZyoZQ0XjSZP1ZQ
=3yo9
-----END PGP SIGNATURE-----

--elWSKwo949DbmCL3--

--===============0453707669560733033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0453707669560733033==--
