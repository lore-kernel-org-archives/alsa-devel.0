Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2817EC433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:49:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DE320732
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X0+2IzAL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYirXbcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33AC783D;
	Fri, 21 Aug 2020 13:48:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33AC783D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598010555;
	bh=Mf4nEuCCfFrSmxx0U2qLL0U3c8Gd0CBPiRIMYS2v0QU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X0+2IzALWFkNJHmJNofQ6W/MewDBwWEO3fnLW0530Sbrheg9TUsuHjBzElv805ZJw
	 bNuNf1044cJEBailsLrup1zyPKODVF7TdiXaJJHQc7OlbK4s9ZsXMnhKfhmZnAg/1W
	 wlO6v7aPPOih2VcDldHGacb7WpQ+EvfFYpXiBlJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB040F80216;
	Fri, 21 Aug 2020 13:48:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B735FF80218; Fri, 21 Aug 2020 13:48:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 982E9F800D3
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 13:48:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 982E9F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gYirXbcj"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 30357204EC;
 Fri, 21 Aug 2020 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598010489;
 bh=Mf4nEuCCfFrSmxx0U2qLL0U3c8Gd0CBPiRIMYS2v0QU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gYirXbcjD1r6AQs5kexWu86DAm3Ip6ybEloQlUSHtVIMnRYRubvcScfLTxqWfRZYn
 KGDnGNJ14csOiWG06WT/XyQ8lYxOVFF7dTl/MBHFEGnx7UrjWrzCOKDXSjWLfSVoGh
 COWpNKfB+GOPQfbQusUv/fVJvuGQ3N7a96Z8CH6g=
Date: Fri, 21 Aug 2020 12:47:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: More Generic Audio Graph Sound Card idea
Message-ID: <20200821114736.GD4870@sirena.org.uk>
References: <87k0xszlep.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZCsy+QiMpCCRPNF-BUcjaT+UVE2B_a6Bd48f8tRqXTpOA@mail.gmail.com>
 <87h7swzclq.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <87h7swzclq.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: divorce, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Sameer Pujar <spujar@nvidia.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 21, 2020 at 04:25:53PM +0900, Kuninori Morimoto wrote:

> I'm not sure we need to update simple-audio, too > Mark ?

I think it's fine to not update simple-audio-card for new stuff, new
things are supposed to be using the graph card anyway.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8/tFcACgkQJNaLcl1U
h9BzuQf/cNhMoIV/n1f2rsPF933QLzGg9Y5W4++lzelU+tKbLC4ZebtMnwgpVxGN
VZ3Yz8wfy14ZO9GllKIbYhkR70l2wztDxr966sBK/mCQ6X28CvMhymod2Ng9w9Mp
4YVyMggTrfSCsW8tPqn/gNd0ECMnQYEokoXtzz1SuzIULVbEjxnXPODWC2oxTWiE
uMhRd0idsgBdLR5WUxTsmrwTT22zM83AeKFVUUkvaibp0cbOIb3ju0ENrGqCMsV3
ZjdcpG5nBXf/a42ddYS+TeiWuvQNgr2p3F+RnJFnTL6yPf+aYgcsVGpwOUXxQvPS
QtVCLtrJTPM1ft7PhXGTqZI2NRVLNQ==
=Z0oX
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
