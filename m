Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC2C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:54:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED7420829
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vGMST0DA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7LfU6pZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED7420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B08371612;
	Tue, 11 Aug 2020 11:53:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B08371612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597139646;
	bh=sI0IAx+x+pW9trF7P8+IWqAebWS8b5QWPt9UV6GjZ2Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vGMST0DAH1+jy5unxkFG5my7Fbx7Xw/i0yRZSMsvZdnG/UAMfhE8WQBwvgRwSohT2
	 Awav6og5UF8tCL6xUgZD1kKvgcFoK3atm37r4c/vpzn0B1NHGs2xU4kxSXI0kccYh7
	 P5ZIGyMc9ygLrJaMAc97kWgrKJjc53+HWpyruxo4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41EF9F8014C;
	Tue, 11 Aug 2020 11:53:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B28EF8015B; Tue, 11 Aug 2020 11:53:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30FDBF800D3
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 11:53:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30FDBF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="D7LfU6pZ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D78A20829;
 Tue, 11 Aug 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597139587;
 bh=sI0IAx+x+pW9trF7P8+IWqAebWS8b5QWPt9UV6GjZ2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D7LfU6pZy5EILhRmPt0vpv03HOm8F8LPYuPUIDCoHnJeZnUlDYKROToZNqCAw2cxU
 PzPwrN72q2XnwQHQ3GISMmdCdRyB9b1pIjI52EvC0gyKhMoIpSGgw47WnGH0z9HBaD
 C05u3II/QfWSEWzTBJfyr63mxgOyYgFyA3IjhKA4=
Date: Tue, 11 Aug 2020 10:52:40 +0100
From: Mark Brown <broonie@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] ASoC: Make soc_component_read() returning an error code
 again
Message-ID: <20200811095240.GC6967@sirena.org.uk>
References: <20200810134631.19742-1-tiwai@suse.de>
 <CALAqxLU_wTTqn9=0O2kaeOOTnGAuwOtWfupr9MusX=TceKW=hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <CALAqxLU_wTTqn9=0O2kaeOOTnGAuwOtWfupr9MusX=TceKW=hg@mail.gmail.com>
X-Cookie: Gravity is a myth, the Earth sucks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2020 at 09:45:14PM -0700, John Stultz wrote:
> On Mon, Aug 10, 2020 at 6:53 AM Takashi Iwai <tiwai@suse.de> wrote:

> >         if (ret < 0)
> > -               soc_component_ret(component, ret);
> > +               return soc_component_ret(component, ret);

> So oddly, using this instead of just "return ret;", doesn't seem to
> fully resolve the issue for me. It's baffling!

> My only guess is at boot up I get a *ton* of error messages:
>   q6routing remoteproc-adsp:glink-edge:apr:apr-service@8:routing:
> ASoC: error at soc_component_read_no_lock on
> remoteproc-adsp:glink-edge:apr:5
> which I suspect is causing other failures due to timing issues.

Seems likely.

> Srini sent me a patch to provide dummy read functions for the routing
> and dai components that were missing it, and that seems to properly
> avoid the issue.

Hopefully Srini will post that soon then.

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8yamcACgkQJNaLcl1U
h9Akgwf8C0ToovqiasAMw/JxiNNN97Wd00obYgmVUA2lWNcDPvTsgxptD+zWtiYB
+FvWx5udIBFiqXGXSTZwOdrNyC9Qyfrqn44upXMiB6sFYHMJMyH4bC2T63f/1x5e
jpfEuDf5NRm+Hk0zBcKorznmL1E4jDxTfn3g4PfH0TN9WTDY89DsdwnkNOwCbYzT
mtAywseabAKPP53gbIjtP2xOU+wKz7R9X5uNDp760Zg+QHhrrax8ikuHQpt8MJ0z
kfcvemU8bk11E0XY7nxN2nii0IW010LfyWnvRuL9H9YqQvRuoLvJX/4plqGETpFC
QR7z+D7aiNQ96aSwuISByUlNXI16bw==
=+ZZY
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
