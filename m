From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Thu, 26 Sep 2013 20:43:50 +0100
Message-ID: <20130926194350.GU19304@sirena.org.uk>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9122034958478779790=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ADEC1261AC7
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 21:43:52 +0200 (CEST)
In-Reply-To: <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9122034958478779790==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9AazSAFPVKSPmRXK"
Content-Disposition: inline


--9AazSAFPVKSPmRXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2013 at 12:33:33PM -0700, Andrey Smirnov wrote:
> On Thu, Sep 26, 2013 at 11:34 AM, Mark Brown <broonie@kernel.org> wrote:

> > A better and more idiomatic approach would be to have the MFD manage the
> > cache, making the device cache only when it powers things down. This also
> > allows ASoC to use the standard regmap helpers for the device which helps

> Correct me if my understanding is wrong but using standard helper
> function would mean using hw_write and hw_read from soc-io.c. Looking
> at the source code of those functions I don't believe the are
> performing any sort of locking(once again I may be wrong) and rely on
> regmap_* implementation to do it internally. With si476x driver it is
> not the case and it is important that codec write/read functions
> perform si476x_core_lock(core) before they call regmap functions. If
> that is not done it is possible to wreak havoc on I2C bus by trying to
> access the registers of the codec and doing some V4L2 operations on
> the corresponding radio device.

> Although I completely agree that cache managing should be moved to MFD.

What exactly is the locking you're talking about here?  Both regmap and
I/O have locking at those levels, if you try to do a bus interaction
using them it shouldn't conflict with any other register write.  If it's
something higher level then shouldn't the locking be higher level too?

The way the code is written it looks like the lock is being held to
ensure there's no race due to a power state change.

--9AazSAFPVKSPmRXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRI5yAAoJELSic+t+oim9KKUP/R0FwAbEWbz4Ua73fX4jzEZ2
Cb9jz5Ml15Mi5V5GUTe2kiwy/4tlrWO1hPrsEZkQW7hC8JRb8ICYtqFtcuwh7VMu
Ac/uk5Y3FTlAq0Q02Latp3pIqDpj3NgwfftVHBFB16VmkZ6ZspFUvmSWXyefVwIv
0jR3FB18jqt0jYG4NxAiE6ksNHpropXCLPuZbFx8jJS8uPQC5e7YQD4R8x8hU1BU
v9RsiKTRSCKo42GJuWNaRWBn0ktolJYz4KDZruEFtQmChY2LjzFtzgZpAkoNpjnT
Y5U9187HLqtHKgyHriejEaIuPp616pp+xvrg4UXoFNCqQmMhN+IlVIyG1vSdlCfC
EEyon2wOMGhx6fwH9EpZAlUFjVWek7JdfkoOSEdnyDZJuvnGTurifxOzGy5+1xeu
lh26CAgCdd15B3FckFEoGRBQTjDijaoIinE/qNFk0r/1wgreKUEmZ3pETBoXdaZ4
j3B25elREzAcapb8UZ9TA1hEb2rhj4OpBEXsxJ0dVFdxoNcR2GuQT/8YCjaTZqhS
CyDb+1bBTDDyly2KHpKBBKO+3XMLdWjJvcScXW3MxCjwb20dhadGdRJ8rGOaFT8W
v22ZBih5PiBpBd1FjacNx1RVegXXXsj/ge1SZUHrdIuj/TsxqPHhEl0Sg3StLiEw
4F72MYoDbomiutWPyA8e
=Kfj3
-----END PGP SIGNATURE-----

--9AazSAFPVKSPmRXK--

--===============9122034958478779790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9122034958478779790==--
