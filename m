Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6952FA372A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:12:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45F62082C
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hf8Jjjjj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KfPKdlCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45F62082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD8BB83E;
	Thu, 17 Oct 2019 13:11:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD8BB83E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571310756;
	bh=nwWS596P23irVtLDxnWaH+m1RD8SZ3SAi7K6zU8VfoU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hf8Jjjjjx+ah2wMrPduTIKxf7Oteee7RE4zbhIfN/8ObL8OAt9ay1wfc/hmJqMHio
	 pPKHEpEsKD9VaQuoT+pSCSDj2aSIkYWM1PxPRIxluud7N/q9MfBgbl4x6YmGJdcikE
	 4N+l2t2Mwnlg8DAf5biIS1kVBToSLvFaE6VY94dA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22002F804A9;
	Thu, 17 Oct 2019 13:11:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7DFFF804AA; Thu, 17 Oct 2019 13:11:43 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73581F80276
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 13:11:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73581F80276
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="KfPKdlCJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hu92kkg/rOG7H1uhawHnfkVXpSc0yt/8yzcgxVqHn6M=; b=KfPKdlCJZtg1+QqDDMACBohJ4
 nOwvwQT3jnWe3ml7rxiHpiVcbuGR+fqnkoG5zya3ECIaBTvmCLivMwizmQGeeUucAcJ60vhQtDoRL
 bnGGNVwtaW4lV4rx5OMTfMLV+okrJpZxuEVrgZc1ENumUN71ugIMVxf5K9kTcImU/KsWI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iL3gv-0000mV-PU; Thu, 17 Oct 2019 11:11:37 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 200EC2742BAC; Thu, 17 Oct 2019 12:11:37 +0100 (BST)
Date: Thu, 17 Oct 2019 12:11:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <20191017111137.GB4976@sirena.co.uk>
References: <20190928081641.44232-1-yuehaibing@huawei.com>
 <c0a0ddc9-5ae4-8b5e-1d77-b322970651bd@huawei.com>
MIME-Version: 1.0
In-Reply-To: <c0a0ddc9-5ae4-8b5e-1d77-b322970651bd@huawei.com>
X-Cookie: Shut off engine before fueling.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, mirq-linux@rere.qmqm.pl,
 nicolas.ferre@microchip.com, tiwai@suse.com, codrin.ciubotariu@microchip.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH -next] ASoC: atmel: Fix build error
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
Content-Type: multipart/mixed; boundary="===============6459780822693721225=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6459780822693721225==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 03:32:01PM +0800, Yuehaibing wrote:
> ping..., this issue still in linux-next 20191017

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2oTGgACgkQJNaLcl1U
h9DLQgf/bpKGur09JNKSVcz4fizyK0a7jmcFtSjI2sF5Yi7dqr8rGWgMJuQ6lXnd
yKAo3kNfJkakIcpLAe+5JFWjvLSfOPdlbn+pvA9DO30LWUU9yfZpiwJh8DCCmzHf
VtLwbaYEn2Lz3+7pfSQ+vOjqA07HaBXLvpgu+eL+HcGCAQQ0xiBSEBW0/X1k6Nzi
raR3jYrrFXeqn03GlAdjfcwa0MOx3HO134aU2hDCRLoi0DZsi8mjsEmi5eTW+lTg
BSmJmUTgMBX0EKsscrwJnR66qX+Slx9d2pL0DO48viIRUqz84Ro0I3w6XlBT02Fi
YCa34N8RkRi0nIf++MH8GlzSZYp67w==
=StwZ
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

--===============6459780822693721225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6459780822693721225==--
