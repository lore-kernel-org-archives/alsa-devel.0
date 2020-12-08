Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA4C4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 12:14:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC2A2396F
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 12:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC2A2396F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5668B84B;
	Tue,  8 Dec 2020 13:13:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5668B84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607429659;
	bh=mLvA4FB9gzMsXJ8QIezTtXurSP32ina1dgLS7P/tnCs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=anIZnaa1wjeg8Yt428T/VwE0f8cZQ9Q5a7SsXDzVmQEsQJRML7rShyLfMZJi1gzXE
	 jPIO+ufOPGd3fY/HCe4U7yrkpKvrfI0odVDDMLvvEITLP9jbyNVoddcXicg0urBceQ
	 5hyv8VU1lhI9pHoqOb4etcXZSxmw2+VfwhGuq5ks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B56C6F80164;
	Tue,  8 Dec 2020 13:13:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26D34F8019D; Tue,  8 Dec 2020 13:13:27 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6433F8010A
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 13:13:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6433F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZMVHeQyH"
Date: Tue, 8 Dec 2020 12:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607429599;
 bh=mLvA4FB9gzMsXJ8QIezTtXurSP32ina1dgLS7P/tnCs=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZMVHeQyHNSPwCQMbCqYhkTXnoF9Z0QSIOtBEpu8fRMHacmE3u67zGCIb5ThVu1RDq
 vx9/bw7vyu4AOMfQfGcw0JJbrvDtOMBSxVvumIhLuvhrkd0mGhlby6plAJp2GVYPh1
 RrJ2fW2vF0y5dvorTHyn4QwahvD3EH/FikvL63w7v7dnQxaNgw1irKUt4MyUJ5GBhq
 9r3bJfmuDklX/Gu7uAJmWcceeN9m6IOquI/OZ/ex3N7kNjdXBaAMhC8otrZlzCtoQM
 znyHuaX31VvvRQO4Znt/z/ZzBRAsyfnfuEmyxh2BxpVHCKDS0x10yO1x0qxCYzij+y
 QqTB79P6JCkkQ==
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: Re: [PATCH v6 0/6] Tegra210 audio graph card
Message-ID: <20201208121312.GB6686@sirena.org.uk>
References: <1606413823-19885-1-git-send-email-spujar@nvidia.com>
 <160683107678.35139.14772386553150233276.b4-ty@kernel.org>
 <a3541d83-1f2e-c60f-05f8-4fdd8c8f4175@nvidia.com>
 <20201207123131.GB5694@sirena.org.uk>
 <14d2a6cc-9ca6-f6dd-ae83-6fc75d5361eb@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <14d2a6cc-9ca6-f6dd-ae83-6fc75d5361eb@nvidia.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, sharadg@nvidia.com
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


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 09:24:47AM +0530, Sameer Pujar wrote:

> > No, this was sent by a b4 bug - notice the "no commit info" there, they
> > weren't applied.

> Oh I see! I guess review would be still pending then.

I don't seem to have them in my backlog so either there was feedback
=66rom someone else I was expecting to see addressed or some other issue.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/PbdcACgkQJNaLcl1U
h9CqnQf/eMYjgDWfCNyswXGemvr7kIq6mU3xUpEyqfZR+q62DDj64lzHbDh+56qf
IQR1LbQUCVgzig4dhU3+Sz6/mjZx7kxCac+Gp//Px7tcGoG0h5vaCHszxguqF/7Y
TnHTOm76s06tVl8eS9eZf4sN0xbWQWNaq7wk1KYxorUAqpAjQU0giDPhXHDwRJWw
ogelYbCNvEVqxHTKRn8ZoMQsdatgxiyUiUu+ZXHKbUUHhAAqUhxs0cAbSdI5KDOy
Ijqlx7oYx1m6IRQpEJDonQPe4K3EYbZz5umZKB9S8zOYDmd0cGFWpbVhjZfQ/nYx
1uf+VdF8gSYdWzAYO6jkUKPEXF+eVA==
=ZNIG
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
