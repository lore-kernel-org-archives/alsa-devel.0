Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F4C43460
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 16:57:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE02161369
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 16:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02161369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDA30168E;
	Tue, 13 Apr 2021 18:56:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDA30168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618333038;
	bh=BMzJR4VJ6S1chDRuLo9fNI6baCLetujlMTgG9T1hBTA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fokIlRMfMkAwSvuI6wHQMlBa1sgHTGilmHoAFl4zJoAskxOEFqcKwmWJkDygEh4Gs
	 C2bYK44KZaM54UYlaZG2uAWUy3+xDGzOzSKDHUL89ZRVDPOsdQgmvl/TCPg18NZKV3
	 zWJVnwM4Yz4+iJSkfz3W7VblSbeO6AxnadabHqEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 508A8F800EB;
	Tue, 13 Apr 2021 18:56:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79949F8021D; Tue, 13 Apr 2021 18:56:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4701F800EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 18:56:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4701F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="H1+F6QWK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FE5F61369;
 Tue, 13 Apr 2021 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618332980;
 bh=BMzJR4VJ6S1chDRuLo9fNI6baCLetujlMTgG9T1hBTA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H1+F6QWKSDbw99N9oHLwneBEHm7z2DLMLXAPn+TicXytB6qyUrMKJTzH/1BOi1Kjm
 q0FSLD/sX3Y0PXgIrqaIngI6mOcmUVsfkjK/2x2RfHhW0GFQ6gwldtvXNWyshYcwDx
 F8kQc+lf9kN1CJuq/CXgy38FmRkYBwnsW48PxFrcyTJ8UoDYNg42/qK++/stJwStJ+
 OW7V9M7WPAw/EKI3N5X9ysBAJdGLrn3WuSsVMDLbacrCWTA5q96+ep+lYJSZOm096l
 +85NzGjWUtucRFaxt6R/ci4pFFM+8wKJITk+XEXbDowX+0nH2uefjWmOL65rbRMcl0
 cGNq9OGI9h8Ow==
Date: Tue, 13 Apr 2021 17:55:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: cs35l35: Fix an error handling path in
 'cs35l35_i2c_probe()'
Message-ID: <20210413165558.GH5586@sirena.org.uk>
References: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
 <20210413124323.GD5586@sirena.org.uk>
 <3f276ab6-1704-84ed-3681-d639ba1e0010@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
In-Reply-To: <3f276ab6-1704-84ed-3681-d639ba1e0010@wanadoo.fr>
X-Cookie: Shake well before using.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, tiwai@suse.com,
 kernel-janitors@vger.kernel.org, lgirdwood@gmail.com,
 james.schulman@cirrus.com, david.rhodes@cirrus.com,
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


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2021 at 04:02:21PM +0200, Christophe JAILLET wrote:

> What do you prefer:
>   - you fix the subject?
>   - I send a v2 with a new subject?
>   - we leave it as-is as this patch is a no-op in the real world? So it
> doesn't really mater.

It's fine, I already queued it - more a note for the future.

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB1zR0ACgkQJNaLcl1U
h9BJwgf9G8n6zatxyWi95NrgjszQW2bkdnOdAhkOym0X/xyrH6kURNsAR7zrPGkT
LEv2oUZTXBFc11NJy2/g/W7+MMOTA9+E4vYmqJUZQbZ6uinJZFGxgvIlgUsKy4d/
26uCsV8bnzRYmeH0iw9G+tE41Zm+cA/TF6DSGowoyvg1OoLROp6/0aHhCjQwEnW4
Wj263Eb88PcVN3XpXCIAbRCHJ9TnO8asSUzyMXTadQnJNxdCvg8I5fVahDLekp+U
mAsyyd9VyL2lAgAjfjGvfglXwOLWjMNKi+ySQJhysOGZqIJ7JYxdIMY1lZNQWeJ/
TQmnbD4Jigu7mg0wyoNNLOQ7bepCPA==
=XUD+
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--
