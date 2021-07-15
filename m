Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6360EC07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 14:40:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E802F613BA
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 14:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E802F613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAC5B1675;
	Thu, 15 Jul 2021 16:39:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAC5B1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626360041;
	bh=6akoi+UJGcbUN77Z7m34HFx3H3/898DwcnDi5HQu9ls=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e5sRwW5HZkEkZb390oxIBmJXtuy98VbechSmNviN05adbUyGnnYdbdtr5Ilp1VD9S
	 JPGm5sqysZH6UXCiLrg9EJI1R990z4lHDNoX419LwpPHaa7oGdQjOlw7HMrjxOeF02
	 mrGMH7Ls54ydffnPFO4jtc/btq7Qv9mcZxvO9D1s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 822C2F8020C;
	Thu, 15 Jul 2021 16:39:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE0E8F80217; Thu, 15 Jul 2021 16:39:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63667F800D3
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 16:39:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63667F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cQZo14/g"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C0C46120A;
 Thu, 15 Jul 2021 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626359984;
 bh=6akoi+UJGcbUN77Z7m34HFx3H3/898DwcnDi5HQu9ls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cQZo14/g4bjGzV1e9ydnfwm1XkNE6JXNRMd3FFVbhiFENrMTsq8zLTkovG25lAXOZ
 QyencD0xWzkxmEhYsGEwlDcrJ7kTOYQIG8P7x7VSVE2GZ5fO3rLmWqyK1K65eKLOig
 SyPSXLpdcY/yjISfbihek6DdqQihr8dpDW1BKEa70BcWZgPgchwWixphKMur6xA3+j
 CXHzG4EivWAURbB2WRI7Hd3CJXs+QGk9ETcRQlQ5ymtxvUt+PzvALlUXpXbFK0jUQi
 HWV28zMHIsFs+He7haB8jhCpXH5rIEDpEmD4PAz0mj+5rdwuyfzEuMinSNn4FdErqs
 d5cROUgxlihGA==
Date: Thu, 15 Jul 2021 15:39:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
Message-ID: <20210715143906.GD4590@sirena.org.uk>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
X-Cookie: You look tired.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, lgirdwood@gmail.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, daniel.baluta@gmail.com, ranjani.sridharan@linux.intel.com,
 Daniel Baluta <daniel.baluta@nxp.com>
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


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 15, 2021 at 05:18:00PM +0300, Daniel Baluta wrote:

> Introduce two DT properties in dsp node:
> 	* fw-filename, optional property giving the firmware filename
> 	(if this is missing fw filename is read from board description)
> 	* tplg-filename, mandatory giving the topology filename.

These sound entirely like operating system configuration which I'd
expect to be inferred from the machine identification.  What happens if
a system has multiple options for firmware files, or if the OS ships the
topology and firmware bundled up in a single image to avoid them getting
out of sync?  What's the benefit of putting them in the DT?

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDwSIkACgkQJNaLcl1U
h9DkVQgAgXVsnrjYjHZv6DFTtjzttDEGUumT8BnNgP9bXTZrpIO/TVCEoHpZM7Xo
KWysYdzD9T4ORCegCUnRzYk6oa/jo1lXstVKrbKS+MwoOMJwKCmvOjCR6HGCt3KH
De9cA5mDbj34gMitq/qf+EA0etGkqu6hM6/luOtF1r0Lp/xhSMr7xSzawHqreGzZ
xUuijk+KIJ9ft1TnPfZOx+5xxSGcuLetzkbd8k2eHNDrXJK7pXTa/szi38GbGXJv
8QNZfGSechBpl1NvhMQ+GE/jfUFHb2IfjYJRLChkMnemGNFGf+6/g7MUy1JNYANg
XEf4GhN05GgRYC4y9Dt/kz4gcqccuw==
=XWt7
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
