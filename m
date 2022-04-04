Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE3C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Apr 2022 07:42:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B6D416F1;
	Mon,  4 Apr 2022 09:41:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B6D416F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649058139;
	bh=SFEBOkVBt2v7eUVd6t7tUEMAgkCh+TwoOUWan0N1Hos=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aSBZFVnctouI/X84c0jJR2OogNvAEU3nI30qsJn9KbiuHh/0okkdmV5zYB4a+BNpE
	 /toWrAYVDUJUve2HGcLxaxLo6E+47AoxqWAQeBjkcdZ9nZaqZJ31koT6mAaWZLQH6x
	 spWbLzV9AZV44IdbghoLyI7vLCDUdws9Sjnz7bJ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29105F8012C;
	Mon,  4 Apr 2022 09:41:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF3A6F80162; Mon,  4 Apr 2022 09:41:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78734F80100
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2022 09:41:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78734F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k35KrcyP"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 79D7561249;
 Mon,  4 Apr 2022 07:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298C9C2BBE4;
 Mon,  4 Apr 2022 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649058081;
 bh=SFEBOkVBt2v7eUVd6t7tUEMAgkCh+TwoOUWan0N1Hos=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k35KrcyPmVFXi+Gy2GWiGVFUahIER0Mp79Rv4sRPCzurenul1pPyA3KyvosugQcTS
 1+U+my+IW7vsGQkB101wUgRGopoe3W6hwqsnlrk+cyQ0w1KWqrapbpTXU9huTNI55l
 5+j4pPfyXEhouT+Tug+qkeZfesxoQXOvH69b/TkD6SsQTst/lkSYrIeHQDZ+wTWV8I
 BT4L/ZteXWbk7077YCQcQDJZG8kvn5viavEgZlv894QuZU470ZY90w9wuEItr4SU9B
 XWIJrmDy6A+DkA2+ho3qluOUaZJrVaqoCHTVOB53PzqkSYJtAk7C1hgtQZlvsQvq95
 M6mphAauWj74Q==
Date: Mon, 4 Apr 2022 08:41:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v2] ASoC: amd: Fix an ignored error return from
 platform_get_irq_byname()
Message-ID: <YkqhHLwwhlJxqgmJ@sirena.org.uk>
References: <20220304004543.11797-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZxoYiHOv0fHvjypM"
Content-Disposition: inline
In-Reply-To: <20220304004543.11797-1-yang.lee@linux.alibaba.com>
X-Cookie: A rolling disk gathers no MOS.
Cc: alsa-devel@alsa-project.org, tangmeng@uniontech.com,
 Abaci Robot <abaci@linux.alibaba.com>, tiwai@suse.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org
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


--ZxoYiHOv0fHvjypM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 04, 2022 at 08:45:43AM +0800, Yang Li wrote:
> The return from the call to platform_get_irq_byname() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'adata->i2s_irq', so assign the value to 'ret' concurrently
> to solve this problem without affecting other functions.

This doesn't apply against current code, please check and resend.

--ZxoYiHOv0fHvjypM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJKoRsACgkQJNaLcl1U
h9BT8gf8CSb8vfR5YFVec3em+YC6KNuko+8bu/rJE2FhxYDaW0+TitAAQbNhfhR+
/2NrU8KwenZTLE32B0MAOFYEPpXCITV+6ObDeXiDRQ773oBso8cMdEt87sh+nQNj
16ld/gg6nGG5Eym/8gwsMZ0tOkOAlLMwW3ZTeSnspZNFykPne0/8UPC+rpigHY2o
Nk1Jg1/XlihxB9I1yzvZQDTZKErxmVxsKWiYzVDyxQrB7/rroV/TfARFipOOcsPy
mOiuj+jtbl/lIRToLcravIOG8qRNCZaO5Eaqc9GtfAV1B7FZAAGBAC6bxHq5tbwy
xCj2phXjjXH0PqU8sAm4Mu2THhCsHA==
=mzRX
-----END PGP SIGNATURE-----

--ZxoYiHOv0fHvjypM--
