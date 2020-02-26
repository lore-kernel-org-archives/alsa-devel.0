Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1AAC4BA1E
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:37:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48A524680
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DvsmdDbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48A524680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3FB7166A;
	Wed, 26 Feb 2020 18:36:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3FB7166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582738631;
	bh=seBWHwi8JNHmL1iwql4bErhY86dNxZyoyRTvs53SJ5c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DvsmdDbgvwqrJ9r26bDsHVmJGd4DIPgyNCSGHuUv8QVkcySho7jjzOJXcOvM//hBv
	 AJKp2mLKAsIg6+vkpmejQgJIeFjzJvF5DjRj9jNAqsj1mXDVIzgdCpMP3mh2tW5H5w
	 UFQRWxx52YRDTPca52Tu63dt1sQBYaAYu5EfEwb0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52373F800E8;
	Wed, 26 Feb 2020 18:36:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 358C6F8014E; Wed, 26 Feb 2020 18:36:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 77015F800E8
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 18:36:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77015F800E8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A97EA30E;
 Wed, 26 Feb 2020 09:36:13 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F6EA3F881;
 Wed, 26 Feb 2020 09:36:12 -0800 (PST)
Date: Wed, 26 Feb 2020 17:36:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Revert "call
 snd_soc_component_open/close() once"
Message-ID: <20200226173611.GI4136@sirena.org.uk>
References: <20200219182650.1416-1-kai.vehmanen@linux.intel.com>
 <87blput7hh.wl-kuninori.morimoto.gx@renesas.com>
 <alpine.DEB.2.21.2002201103060.2957@eliteleevi.tm.intel.com>
 <87mu9cspyf.wl-kuninori.morimoto.gx@renesas.com>
 <alpine.DEB.2.21.2002211251280.2957@eliteleevi.tm.intel.com>
 <87mu978pob.wl-kuninori.morimoto.gx@renesas.com>
 <87ftey88wk.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline
In-Reply-To: <87ftey88wk.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: digetx@gmail.com, alsa-devel@alsa-project.org,
 ranjani.sridharan@linux.intel.com, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com
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


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 09:55:47AM +0900, Kuninori Morimoto wrote:

> If each component / rtd / dai have "done" flag or count,
> soc_pcm_open() can call soc_pcm_close() directly
> without thinking about "until", because each flag can handle/indicate it.

> The good point is we can reduce duplicate implementation.
> And it can avoid future bug. Because today, we need to care both
> soc_pcm_close() and error handling in soc_pcm_open(), it is not good for me.

That goal definitely makes sense, if we can avoid problems like the ones
here it seems like a useful change.

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WrIoACgkQJNaLcl1U
h9AghAgAhAl+JdOAz0lFwtiL1VLunSoDtHxZoxmJOJNUi0UKzPgzYtZ9rPpDbDSx
+QfpXs++Qhj4FH32ijIS53zpU3M/0suZQr60aiSa13jV1g8KLzeI4PWK4rMcNYSj
LUJXmC/cbcdrsAUtZxXyPWMtpa1HQT9xZcKQ8gpCTvxH+m1/j04tonmkX/moaeln
k6rMD8C1TQZEtQjvJukR8TYERhlBKgJnnsDAwHM89J5ejagZ7blWtkLH+pGLa6oP
Xus9V4HHP6zVLQmbcHrGXRV9L8ND+w0lLgKby1OosBlS+FNsUSdiLouQDQbGCcdF
KiHCRzIS31nmVNNrZ9/xq8vXDN6G/g==
=TcA/
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--
