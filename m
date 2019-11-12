Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013A0C17440
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:47:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DAA21783
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iyn2TZbm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wJVwryib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DAA21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BA45846;
	Tue, 12 Nov 2019 19:46:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BA45846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573584424;
	bh=Gotq556V7CQIA+dtoHUl3Rwa79rfizC1YF5+RTipjgI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iyn2TZbmbduy0yjnxvSsiu3yuPdBfBC4q4koQ10c/id5d1sium//DwoMcfVlDcFQs
	 l/0XQjJlPnzFWwwlAzdNY3UN51b2M4504BTuVYzUzVeFQ+0vnDQ1sCRYFhkS0PqSCM
	 IYhPxJoAUfbCjFSsUZCPM1Ms95Wa6Bx3+nCNZkaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5471F8044C;
	Tue, 12 Nov 2019 19:46:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D54AF80483; Tue, 12 Nov 2019 19:46:12 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8528DF80144
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 19:46:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8528DF80144
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="wJVwryib"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H2zgmOqXkYg8iy8uWQO+EpOe3Vy9Px8cot1jB+YiOKQ=; b=wJVwryibYHXux5oVjHUjceP8w
 Cpd7/zG50PBDjhEfkQbd0CXR0rtDBuJ4QV4HzyOu7s/7bYMbhmkM8JpY9SYh5QK/MxZ8ehgL+9qnF
 bZK+XIgf/wGesEqCBrj6ZuhhQqgifzwMjRoS4mwQFu3jmaJq4fIr/5Oz4Ob70PqA2H+Dw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iUbB2-0008WA-AD; Tue, 12 Nov 2019 18:46:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 44D38274299F; Tue, 12 Nov 2019 18:46:06 +0000 (GMT)
Date: Tue, 12 Nov 2019 18:46:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID: <20191112184606.GA49098@sirena.co.uk>
References: <87wocdhkz6.wl-kuninori.morimoto.gx@renesas.com>
 <87o8xphkwt.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
In-Reply-To: <87o8xphkwt.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Being ugly isn't illegal.  Yet.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 6/9] ASoC: soc-core: merge
 soc_remove_component() and soc_cleanup_component()
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
Content-Type: multipart/mixed; boundary="===============6037365592952674256=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6037365592952674256==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 10:07:46AM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> having both soc_remove_component() and soc_cleanup_component() is
> very confusable. Let's merge these.

This doesn't apply against current code, please check and resend.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3K/e0ACgkQJNaLcl1U
h9CTjQf/WAAFbUJjiWiEvF0ABqT2CR8PMewmLsydBb/4WUGHjgOTf+hiUCbv6i/a
/Cy81EW8k67g8aP9jrmwgHL65EIdUOy9HhVrZqGtqWsshVOtk1wBhRUQtR2ZJ1ub
YXDcn7hrC003KACg6Cmzax8LNlEGS3kaQY4WnDAC/9nOW+yiF3+T2ZImas+/hu7T
BYiM/QJq6mG+b7imIThD2rIg4zRGe1YPydsgOiIX4QCS2zFlBux/yjC02dHpgl/W
+vRCfMHriRlKaQ/Uo30/gthLmN2Iuu+EMfYjbyy/vsgbvzHQ9n0v60g5pwrOpRBG
ZPJKJ4mqX6sBSu8rIoY1p9TpahFf0g==
=vJE0
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

--===============6037365592952674256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6037365592952674256==--
