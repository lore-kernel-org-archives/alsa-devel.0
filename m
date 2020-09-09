Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F420C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:57:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A3721973
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JHkWgIs2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBNR0Fr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A3721973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB97816D1;
	Wed,  9 Sep 2020 11:56:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB97816D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599645419;
	bh=80y+lBEjqoY3o25Mv/xR+Di0cs1Hb1ZUnm5ahaVP8PQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JHkWgIs2qenRm1lNrBKAPXKm45SUX34CBGpQ7ARKNEFiH929q44NMrulhz3dPHrJl
	 f4UEc+bX1iLovTo5Z1EHfqkkJuH9jhw2bvwkEQQMP9WADKsAXUXD9acBDGXfyCvw66
	 cFs0NvXgthP8AGklHW4DW4OL+ilC8MGlQ3ohtVwY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D5F8F800FD;
	Wed,  9 Sep 2020 11:56:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 439AAF80227; Wed,  9 Sep 2020 11:56:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCC07F800FD
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 11:55:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCC07F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vBNR0Fr5"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2389921973;
 Wed,  9 Sep 2020 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599645356;
 bh=80y+lBEjqoY3o25Mv/xR+Di0cs1Hb1ZUnm5ahaVP8PQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vBNR0Fr5EaMVBJtkkyNq6OjoiTqYMi9y+Ji1xMLsdHYXqNzlDNomM9/8DpSliOBi1
 B0eqPbefVyP9v0r4yh1/f8edYVlU3P4soFFdvKEiM7jz6sf06u9465vJ/o+R4jlp19
 tZ3iZqu2G211WjE0K0HCr9KFPgnkfXVUHe0SzSk8=
Date: Wed, 9 Sep 2020 10:55:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 1/7] ASoC/soundwire: bus: use property to set
 interrupt masks
Message-ID: <20200909095511.GA4926@sirena.org.uk>
References: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
 <20200908134521.6781-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200908134521.6781-2-yung-chuan.liao@linux.intel.com>
X-Cookie: MIT:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, vkoul@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 09:45:15PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> Add a slave-level property and program the SCP_INT1_MASK as desired by
> the codec driver. Since there is no DisCo property this has to be an
> implementation-specific firmware property or hard-coded in the driver.

Acked-by: Mark Brown <broonie@kernel.org>

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Ypn4ACgkQJNaLcl1U
h9Dzggf8CeC4+qObdNWRVoM/vDjBHKmTecphR6nxQIObAN3+iyMQr/XRr1ogE3M7
IP6AkuTmKmE1I6/ux6klzsFt7pjp7I2lIXHQcBni/votOxbQOl6lKmcbnUmyIoBT
7zkyFU7e/TzUNv46LNgmAkq9/RWEuaBm3GZ4XCPsgSzEQgRM5TDgl+CWuipmrQtK
d7gDkReWkFwwcH2o4fPo6IDysPkL35ElClmiTHek94MPhGRZjysrLYc7DEGTz6YP
J0WQD12N9wAo0rKuo4KPKg3mUkKRl2gxHPxzmcg6QhN2cc00uUkm3GtrERX3QRwj
JLQ0OZl5T0MXW2KQVhoqfvZGVLy8+Q==
=VM+6
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
