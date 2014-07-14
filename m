Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Mon, 14 Jul 2014 12:31:18 +0100
From: Mark Brown <broonie@kernel.org>
Message-ID: <20140714113118.GE6800@sirena.org.uk>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
 <1403108551-25058-2-git-send-email-s.nawrocki@samsung.com>
 <20140630184658.GE23300@sirena.org.uk>
 <53C3BEB9.7000706@samsung.com>
MIME-Version: 1.0
In-Reply-To: <53C3BEB9.7000706@samsung.com>
Subject: Re: [alsa-devel] [PATCH V2 1/2] ASoC: samsung: Add machine driver
	for Odroid X2/U3
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4711213716687016468=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, pawel.moll@arm.com, zhen1.chen@samsung.com, kyungmin.park@samsung.com, galak@codeaurora.org, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
List-ID: <alsa-devel@alsa-project.org>


--===============4711213716687016468==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2014 at 01:27:53PM +0200, Sylwester Nawrocki wrote:

> Too bad, I noticed this comment only just now.  I'll consider this and
> will try again and see how simple-card could be used.  There is also the
> samsung-i2s-sec secondary 'overlay' CPU DAI that would need to be handled,
> and we have it now internally specified in the machine driver through
> cpu_dai_name, rather than cpu_of_node.
> There might be some more work in the driver needed to support the
> secondary I2S interface generically with DT.

You should be converting the device to DPCM for both that and the
compressed audio path.

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTw7+DAAoJELSic+t+oim96UYP/RkReXbBb6THPBdOv4kXm0kk
5sEjYy8O5VD0bppMmrbhO03dSKH7uF608z04FpD3KNCm4sOJCsKYwqsWY+aSTU43
xW7mDCdOXgLK6tmxyCX9pTDEadkg3rZIOeVcmTP/YdUyEgc4TSyxyWFjCGqRIzr7
wRYdIMb8Br4BK/MMoJc8hcQ6aZZZHGkGVMZ3a6Gr02WLSIk1R3tfqWCJgTr3PO+d
gX2OotvwPBgw3bFboTVKYU1Rrl3uu7QUB46UAqRUAVyAV5aqLxSK1B9rQxT7G45I
xzpeqBcS7aYGavtcG28gxq2NtElBfGch/9KPCnum8PwgieL01/AYYYIFyLKpXIKQ
/r19JzEir6uI1rr4OQJZUy/0RjGIb2CGmyCRYEnfPEuzdL8e6Obwl5MdsHY9pKYt
Mqti4sU96k5a3qhGUbLnCHnAyPqqVGPD+g+FuQedCKLSqZFGonYKSonSlUy45EeH
Aq49T59yNUhcIY8tBw4eucskCQC9z14sAZ4KTE12gWZuHAJkEyFCXB7TkVBouMQz
u/VdMolsItZjUAtK2ITPoyVU4oD5oFn+sqrSMUgeXhoAX31j6EMKze1WOr2huu4D
UTxETrqrjfMFDKPv20CFWv06akWeK4yFoInfecyIXOxVKeDaYKbdZR03hZ6k4Ymk
a2vKlC6r9FZuZ11mg/nM
=9i8a
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============4711213716687016468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4711213716687016468==--
