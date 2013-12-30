From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/19] ASoC: soc-utils: Don't set unused
 struct snd_pcm_hardware fields
Date: Mon, 30 Dec 2013 13:56:25 +0000
Message-ID: <20131230135625.GE31886@sirena.org.uk>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-19-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0494776402978084227=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B167D261684
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 14:56:28 +0100 (CET)
In-Reply-To: <1387545625-19240-19-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0494776402978084227==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ou2/pFdZC1wHLsdF"
Content-Disposition: inline


--ou2/pFdZC1wHLsdF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:20:25PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--ou2/pFdZC1wHLsdF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXuGAAoJELSic+t+oim9dm8P/0ElkZackozsqUDfjR1gCKxp
Q8MqGr/1DJe1BGJeoBvUWFFPDSsf/U/uHRuzF+yq/QHppCXJ8EV/wCpv+K0HaUep
4taDbo+3zkIychfRiNeYcpoY5T4vyytW8a67eeRNkyDhjXkeZaKB4d3HmjLZRzwZ
mjJ2tkrPnalEi9VsAK1VcqMUXKMrqf7C2KvtByDGNhVSs/eQMV2SngjlPsc8iGQC
4dBh9Uxf223JEvpQls1E0TCuvhrjyn9KoVX72eNwxo+G8todg7iLwGKuf4fXBfWa
/VcF5tN3/3xC/RAfX+dpeMkJbKBcMaz521vYlkcNxuA48nvChI+qF/LFFf4YsAE0
30nXJIT5Ydaz1S+Xah0RGETwysuE554Z3kaysAt7kVHeQrlbeGjXUBLUq5v4XaQx
GLXNzER9JxBI1NhqkwnPIEmBGEEFCEz/2mNpWQeb89P/pPGHbgr1nXKyQgkvURDi
n9hU5/SGzqBB8m4rh3pSo4kpwVqtCA+VGIyVGTGAaFMFYfMwNmKSid+StQtc7cXI
QtfsBXXHgptOvYIuIp0A8zPeXYP79zHMQUAz9fhamlNqxiBAd6xUq/vG+fIX946F
fcEqOiVX19wmw0e6q23XD8zAIXeK3nuslUGJ0fA2amozltJlF6gWBo73cvm3NStC
QgTsqo3qOmMy2QTr8IRL
=N8O5
-----END PGP SIGNATURE-----

--ou2/pFdZC1wHLsdF--

--===============0494776402978084227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0494776402978084227==--
