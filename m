From: Mark Brown <broonie@kernel.org>
Subject: Re: what is the difference between
 SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S24_3LE
Date: Tue, 30 Apr 2013 14:24:21 +0100
Message-ID: <20130430132421.GA1023@sirena.org.uk>
References: <6B947C8AC4195040A8C6876A496C644A082F1EB2@BJ-MAIL-04.vimicro.com>
 <51667BBC.3070609@ladisch.de>
 <6B947C8AC4195040A8C6876A496C644A082F1EEE@BJ-MAIL-04.vimicro.com>
 <516683FD.4000804@ladisch.de> <5166D659.90505@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0084826635550549953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B3D3626509A
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2013 20:06:24 +0200 (CEST)
In-Reply-To: <5166D659.90505@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org, Zhang wei <zhangwei@vimicro.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============0084826635550549953==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2013 at 08:27:21AM -0700, Gabriel M. Beddingfield wrote:
> On 04/11/2013 02:35 AM, Clemens Ladisch wrote:

> >I do not know how ASoC maps these symbols to on-the-wire formats.

> The SNDRV_PCM_* symbol specifies the format of the audio in RAM, and
> transfers that audio to the digital audio interface (DAI) on the CPU
> side.  (E.g. the OMAP McBSP.)

...

> The CPU DAI is responsible for converting the SNDRV_PCM_* format
> into the serial format.  Therefore, the conversions that it supports
> is totally hardware-dependent.

The drivers should in general be defaulting to using exactly the right
number of bits on the wire, aside from the marginal efficiency gains
if hardware has limitations they tend to be an inability to cope with
extra BCLKs so this improves robustness and compatibility.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRf8X8AAoJELSic+t+oim98EYQAINskLgbFyhGrXzZPvCxLelM
D6M2jcytwZ6nl9EUhh0cUQNCvHbo9L0pkPrcHHaF2Z9HJ/h9IjDcCp9RcYIRHIO/
DvK88vu+RMzFLm+zcPd1VPJxtH+OD95qtRrisGGoFHmj41WwrkZruI8bocQwTonD
UTthdqnwiwHcolyJsyQBGy6hTb39cavKPR2aN1z/o8DyM9mcO9wqU0fwO10T3ofC
QZvlcyxw3TLI4Mo+Z3j1JXudTi7Jo+s78ABRRNLECw49uFONPoC4I+1aCMs7oeYB
ajiJDU7ppLiWU+fwK+Jq8y5uQTKREmqho0FoKtJXaJzP5Qi0rgc/JA0i23inCTDX
Xk680a453ULRXy5L/hrHmKbgo7BB1QWl9aPpmvyG35166nCoR9KIo31WzQgSjfp5
UFUeBopea4lSACHkTG1awAME6Dp7WGvhiKxgVeZfisytgzrAlhqAIUfCpApHfv/V
vhsanaqL5k8EVzEPDbzt6UuveTrrxpaBm3NqFkMMa1C1Ll+Q2R8t//oM26tU/NKr
P6tMyuv3GUhlrW3OlnVirNBwJs8b9wYZDGVpSmv36rl1qdqfpeAdyzfNTY+s9v+n
hUmspw+GWLwvVLpDDdHAi8ID+6c1L2T9V2BFd9C1kw3ei3NZXQcEGxYD3SeR8gVM
dDBXgUdNIGahqMQo0Tsd
=s5mG
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

--===============0084826635550549953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0084826635550549953==--
