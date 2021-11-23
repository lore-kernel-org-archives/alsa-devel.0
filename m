Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38699C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Nov 2021 07:15:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 657201790;
	Wed, 24 Nov 2021 08:14:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 657201790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637738111;
	bh=d9t+ZRTCK8H/Ezxf7VMaGXM5QRACAAA0uxZgA56l8E0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WT1xu6yWg5EoZbG5Z/pKeDGkageKBMiqYiZx8itx8oRU76tMnPa7nBuSEDxB2CyCb
	 lPaxqgkRcsHCm/2Iz4/HRlKp2uGZuzQb83DK7gOXtV6KY0LUFznziD5CNKa3BWoj+v
	 BnQmJIcyBjbIaJT8cTvkyFyt7PxBt1UUk96Ue1qM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B6ABF805C9;
	Wed, 24 Nov 2021 08:06:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27626F8049E; Tue, 23 Nov 2021 18:59:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B596DF800E7
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 18:59:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B596DF800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bNZBmbF3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D4F56052B;
 Tue, 23 Nov 2021 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637690338;
 bh=d9t+ZRTCK8H/Ezxf7VMaGXM5QRACAAA0uxZgA56l8E0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bNZBmbF3y+P40zNaijOwN98W6E/nbrgj1dOdXuOQVuEyQhVOIuuyQGCIXq/2EEdPU
 +sG2hEI2/1fVfgZsaiBK7pTeWewPN25szGvZseMRNX/+GhlwId4gM1D2ra9aGYn3f5
 e5VfVEwxK7/DYB652JlE2kt2T5z04kCkFA8sop11UvC/yqhuBBLdCz1jfZPCHyDsWo
 KwK4g8OH/KhH2YECZEw6nB/R0rOk6ysyk5DmTGCZZOAA4YgmYd3rsIhYjJhzrNfuZ1
 F9aARDFvFDl2szGxOF0VXGHh01Q9ddsJ2SpbGFEppX+nEBOL/aNsU9c/5+/KaRuav5
 JaUtudF73aLHA==
Date: Tue, 23 Nov 2021 17:58:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH 04/11] ASoC: cs35l41: Create function for init array of
 Supplies
Message-ID: <YZ0r2s1z15yXLVhb@sirena.org.uk>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-5-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WkK+Jw7iuU6ibZtu"
Content-Disposition: inline
In-Reply-To: <20211123163149.1530535-5-tanureal@opensource.cirrus.com>
X-Cookie: A closed mouth gathers no foot.
X-Mailman-Approved-At: Wed, 24 Nov 2021 08:05:53 +0100
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Elia Devito <eliadevito@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 alsa-devel@alsa-project.org, Werner Sembach <wse@tuxedocomputers.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Shuming Fan <shumingf@realtek.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Jeremy Szu <jeremy.szu@canonical.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
 Sami Loone <sami@loone.fi>, Len Brown <lenb@kernel.org>,
 platform-driver-x86@vger.kernel.org, Chris Chiu <chris.chiu@canonical.com>,
 Arnd Bergmann <arnd@arndb.de>, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Cameron Berkenpas <cam@neo-zeon.de>,
 Jack Yu <jack.yu@realtek.com>, Kailang Yang <kailang@realtek.com>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, David Rhodes <david.rhodes@cirrus.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--WkK+Jw7iuU6ibZtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 04:31:42PM +0000, Lucas Tanure wrote:

> +	ret = regulator_bulk_enable(CS35L41_NUM_SUPPLIES, supplies);
> +	if (ret != 0) {
> +		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
> +		return ret;
> +	}

Where's the matching disable, I didn't see anything in the HDA code?  It
is there in cs35l41_remove() in the CODEC driver but there's nothing
sharing that bit of code here that I noticed.

--WkK+Jw7iuU6ibZtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGdK9kACgkQJNaLcl1U
h9DmbQf/WBTOwnGah2RPWstqHbB4KVwvwuQL1bd7ZNWcCo0Tm7mJQ9fZijq/ymRX
dygCYgN8kwNIQVjQ3Z8xagPhs7FHNJ+Iye3MYstcm87rXUabmvqgvLOVJ0H49Ttd
QukPv/bLwugCmcvctZOtEcGv9CnkZ/P74/m+a54Bi4Rz0mnu+bs4AjyCMT4Ql//S
K1B9/giEf7ZKuCcwUOZysoIs7xMK2LV15oQBlgC79XLZ6Q2hgxFoE4pEJZC7fAvo
OQ3akqHcXS5W7KdM9B2TC3bJjEceOguigbs/2ETyg01M2a7Hfgaf5vmUdyM6cM/y
NWZuJ6hwB/rXi6x7Sc6U3vcnduhh7Q==
=bhpN
-----END PGP SIGNATURE-----

--WkK+Jw7iuU6ibZtu--
