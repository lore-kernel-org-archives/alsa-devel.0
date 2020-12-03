Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEABC63777
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 12:39:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AF522206
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 12:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AF522206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 554771807;
	Thu,  3 Dec 2020 13:38:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 554771807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606999146;
	bh=KM4Wr02SXLh1074qzic0DuxRqIuvx9/lq28Lt/Ej2Zc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jTavbeMmghKQcbZfEpyl+OUJVow/pyq6ME0aSkfczLFZevManurbdoOleP9cjzxgf
	 Xh7d+yO36oqL/6xWc0A6AHr+6xlt9KQid7waOO4Z+2Gif91yOoCNPj6igBuA6oUrff
	 BZih/m8rrVGJO3sMbvFebF6ivBv6iBKVfAADboTY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C31C8F80158;
	Thu,  3 Dec 2020 13:38:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9D89F8016D; Thu,  3 Dec 2020 13:38:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33934F80082
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 13:38:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33934F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="D2WfaxuD"
Date: Thu, 3 Dec 2020 12:38:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1606999084;
 bh=KM4Wr02SXLh1074qzic0DuxRqIuvx9/lq28Lt/Ej2Zc=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=D2WfaxuDyy9BGS2+aYJ6wNzZ3OcfDTGe6VTALC0Ofc7wlurod5UVOznLit5Y4zdHD
 7c5IZHk0zxSjW9rnq2z2dObXII3aOczScZ5pZoW+r0mUWyLabJHcibRhbTTBulKxmM
 fExNslHtQSt/7TpwooWVO1pJQmZOP/DBKwM/+tsKu7UPghXSES30GIiwygM7eIjj8s
 MIeVCl8Ig9nf1HsJ3yRW2Wei5mpWj1dUavtxDQxRB4TBfs1xGGS1XdHsjJEbPspcLv
 qXc8sPzfTpLB+9anlbjzyfFmFntf+uLPRLBIKmqdSRNZOMeX3tf8ZUsPRwKkovsOGE
 UFBpmAlJ1C1CQ==
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/4] ASoC/SoundWire: rt1316: Add RT1316 SDCA
 vendor-specific driver
Message-ID: <20201203123802.GD4700@sirena.org.uk>
References: <20201202143845.18697-1-yung-chuan.liao@linux.intel.com>
 <20201202143845.18697-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <20201202143845.18697-2-yung-chuan.liao@linux.intel.com>
X-Cookie: Sacred cows make great hamburgers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2020 at 10:38:42PM +0800, Bard Liao wrote:

This looks mostly good, a few small things below - if I apply please fix
incrementally:

> +static const char * const rt1316_xu24_bypass_ctl[] = {
> +	"Not Bypass",
> +	"Bypass",
> +};

Why is this not a Switch control?  If there's no strong reason please
submit an incremental patch converting it to one.

> +/* RT1316 SDCA function topology */
> +#define FUN_SMART_AMP 0x04

Full marks for picking this constant!

> +/* RT1316 SDCA channel */
> +#define CH_L 0x01
> +#define CH_R 0x02
> +
> +/* Power State */
> +#define PS0 0x00
> +#define PS3 0x03
> +
> +/* Mute Control */
> +#define UNMUTE 0x00
> +#define MUTE 0x01

A bunch of these could use namespacing, at least MUTE doesn't seem to be
used.

> +static const struct reg_default rt1316_reg_defaults[] = {
> +	{ 0x3004, 0x00 },

This should be in the driver, not the header file.

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/I3CkACgkQJNaLcl1U
h9DWtgf/aK/2spBSeZvXa9EZuAdVBoQtuyARgWel+AYQp/3IC1Mbh2cbMRLpj1U2
Msa3b887aiOmg+M5JufhKJztr8bWh7LOzk2qh44k4Spv7+Y9S+Hr9dX4bdVTBNCn
0yN4bbv0KtnOuNL8Yxjs3n296ZwIYhgAEMVTmwf/wnDFg++hHTot1EfVyeAT3WEP
JuzZ+sahPTNZ7EiGuBq2kEUrUKu39wrha79VWAEQqjUy0rG9LMcwUjf4hGRnHdr5
rxnTO2I+rZIsBpvl8mIpZjEZY39PvAvGeIGqjb7Tz3gXiXa38cXe3n4s2wbmps2f
d+B0YQyk44aFKqTscooJX9A6ejGrOg==
=A/j2
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
