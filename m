Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D96CC001DF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Aug 2023 11:29:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DFC07F8;
	Thu,  3 Aug 2023 13:28:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DFC07F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691062137;
	bh=94uq0Bo3QnKTETsWRpHX00Zq/UK65SuO7RrYYlFqiPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cdo0hD4tRKtX3nbgw6+PPgOXygZ4N4juN9wzi/5giSuYg69Zd4fhZiUwEFYMOWOds
	 rMMplZ/HbQkEMnWJToGB4T/6zC7B2eMY9w3/QgkCIuoSujcS5/YJWZkG9UBl9b3RAv
	 ab7p2B82eL0kIIwFducgyQxCdH9CbgJfrUc5o/c4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89A89F80535; Thu,  3 Aug 2023 13:27:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C1DEF80425;
	Thu,  3 Aug 2023 13:27:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66941F8025A; Thu,  3 Aug 2023 13:27:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 42865F8015B
	for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2023 13:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42865F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oG0KahOF
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1E1FA61D60;
	Thu,  3 Aug 2023 11:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32ACC433C7;
	Thu,  3 Aug 2023 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691062051;
	bh=94uq0Bo3QnKTETsWRpHX00Zq/UK65SuO7RrYYlFqiPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oG0KahOFGElnYYGp4HYhmQgvg12UxbdCUyxny5SFkjCOEMA5i4Q2UPxt18674wuma
	 Jn8edrfpdKCWlbkX9s6h9Xw0tjVvFCatrcxiOv4ML9SNYiu21qT50URueafImaLgxx
	 YSBZvgGLjfHjyEoK1+2pEP8T+k4Gr27Dk1XFZUO+t+6a5LzuG/SGcWQfW46koHrjQR
	 IdPRrMxlk63w/H541M7W6UFDa+p5zVbXoUmgRIK5vdfuaW4i/PLVd7KhSVDaacjovF
	 ZaE4IorHLntzzTN4qdqb0oyR+cqgz0GnKZ04Ymcdr7DlVE0M92+M1NMJum6uXPdF4l
	 D3aJbsziWhgiA==
Date: Thu, 3 Aug 2023 12:27:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 RESEND*3] ASoC: fsl MPC52xx drivers require
 PPC_BESTCOMM
Message-ID: <9581313f-5340-455d-a75d-dc27d2eb3ec0@sirena.org.uk>
References: <20230803025941.24157-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JtDrcl5vLUX5Kj+l"
Content-Disposition: inline
In-Reply-To: <20230803025941.24157-1-rdunlap@infradead.org>
X-Cookie: One Bell System - it works.
Message-ID-Hash: KELU7ENUJLZ4ZMJD5H4YFQBVBFP6C7R5
X-Message-ID-Hash: KELU7ENUJLZ4ZMJD5H4YFQBVBFP6C7R5
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KELU7ENUJLZ4ZMJD5H4YFQBVBFP6C7R5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--JtDrcl5vLUX5Kj+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 02, 2023 at 07:59:41PM -0700, Randy Dunlap wrote:
> Both SND_MPC52xx_SOC_PCM030 and SND_MPC52xx_SOC_EFIKA select
> SND_SOC_MPC5200_AC97. The latter symbol depends on PPC_BESTCOMM,
> so the 2 former symbols should also depend on PPC_BESTCOMM since
> "select" does not follow any dependency chains.

Take a hint, it's not clear that the patch is tasteful.

--JtDrcl5vLUX5Kj+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTLjx0ACgkQJNaLcl1U
h9APBwf/Xlz8zi+ScLXchSdGVzlpBaygqFFBp+EYQnQuF+pLp1RgI0dzC3kNdV/b
UiYqKfemmWpNm+E/hBv2DgcPPGbB6d1iQQqpTeuymxO4Gloe06zD6Xwa34VJWB7y
lz8fB2dSwxMLTxBCRKo7zQ+ZvOCVHDBZ6TXUFjMtPNM16Mn6P/IurMUh1GT63csu
ssICm8IKAyCnvZqfjYn2SsfwXKzs2M8h6aVsbSCD2WPjJfHBHrE3SN2jIWhHjkPJ
fXZUi2MGJmGHiUD/rPOjHgFfJX1WCmaABpYQVfoZXsPF/Fk015SNCH2AR+8PU1NF
dT/TaWGwdHn4vBWSFTpsk/0yHjL2KQ==
=Baba
-----END PGP SIGNATURE-----

--JtDrcl5vLUX5Kj+l--
