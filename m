Return-Path: <SRS0=Hwo1=HL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B0BC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Feb 2021 22:31:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A872A64DE7
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Feb 2021 22:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A872A64DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 068C216C3;
	Tue,  9 Feb 2021 23:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 068C216C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612909903;
	bh=aElboiqUnwR60IIieAwxZ0/UogaCICdYpqt/BDC5xaQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cb+b5G7H/hVIOa9V88wUUeukEWzEsG2EtNJCFPp51aIpqyiP9zsmx8vCZCJ70ljjN
	 R9/TLwAHZrXge5/RDEseoQKFFDPQZHHnwt/xR/oNyIbzUebxLst7MceC3jY/9Kywb3
	 FxI4fdupwSI6BpqqhR8ndwZHQOnPekyQmflwsMJ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89524F8016B;
	Tue,  9 Feb 2021 23:30:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D126F80259; Tue,  9 Feb 2021 23:30:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66417F8016B
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 23:30:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66417F8016B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BKFMhqjR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F26A64DCF;
 Tue,  9 Feb 2021 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612909845;
 bh=aElboiqUnwR60IIieAwxZ0/UogaCICdYpqt/BDC5xaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BKFMhqjRdwMrFoFFLkOj2yPtqpuqDT/GMWk+myP7cSptzE+Er4bomoT8tCrcpQCfk
 uHtrZFcQYPbUh4e649w5HEj9scECzBRpVwwqEcylAxQorsP39a76Th42S/+9wtbrYT
 sX/dgfaYhvMT1fW/ay7NRhiqzmKc235luf6B+ocqTQ9qNuoJZb54vmJ1kG792QuYEH
 z0V8030k94Ht4PSKt96eINydx2ReggFZT2PxWEo0rMwcAbhpPFV6ZhzkH2wtY9+f6G
 04LNghwVNW/tjlGCktHNoj3g80Moh7fyFzpZeSyY4X661b4tpC+v4Md3fu75wB+PDR
 wyw3Iy2cgtwOQ==
Date: Tue, 9 Feb 2021 22:29:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio
 base on rpmsg
Message-ID: <20210209222953.GF4916@sirena.org.uk>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
 <20210208115112.GD8645@sirena.org.uk>
 <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
X-Cookie: Put your trust in those who are worthy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
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


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 09, 2021 at 05:16:16PM +0800, Shengjiu Wang wrote:
> On Mon, Feb 8, 2021 at 7:53 PM Mark Brown <broonie@kernel.org> wrote:

> > hw_params() can be called multiple times and there's no need for it to
> > be balanced with hw_free(), I'd move this to a different callback (DAPM
> > should work well).

> Which callback should I use? Is there an example?

Like I say I'd actually recommend moving this control to DAPM.

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAjDOAACgkQJNaLcl1U
h9BfxAf/fm751rk1InZcdQUy/P0JjMUL41sYCGQ90Gg1k2R3RCuWuoeTeCO0a0Yb
l474cbyVRak4jHTNNgBjRryRcKW9r/NvV+WOdVVUKdVRJ+PpL3VzFLu0nSll9vDg
aF/J74dcRx2+yj/+Ey8kDwbANEmjGKHdYd9NuJcPcPk+owkE9h0h48n4DpuFucQj
O7anqyPPxnh1mW/gKSE1Sn0f8MhSWelw+xdX5PlWrMw/gbuW+OyAhwt1DyOMgakW
xooN5vm0ALYQtVOM1RnKsKta5TDZjlRkI6Zkv4mojbihSKV/rxTju0sLoblIQ/Ju
0jO/4lAwVhqvokUPYs1HmRwF9Sat4A==
=1sE+
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
