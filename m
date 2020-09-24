Return-Path: <SRS0=rARa=DB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677EBC4363D
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:58:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650412395B
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kv5xTLSc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLm4Jn9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650412395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEC4617A7;
	Thu, 24 Sep 2020 12:57:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEC4617A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600945124;
	bh=hJuK6eidGEuH4OKBWaGFMIQh1rk6ZkOBQ6avcRUR0+k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kv5xTLScpTKQ09XLRJKuIYWlT5Wd3qz3bIEq98LA4j/42Qpe0ccth1tNU1nHWpKrE
	 GwSAeP9/u/LLdTn28+ZLxftpAC4SsmmwMQXjZxQbX0cXNVbD1VvSk1Sb1VmLZShOg8
	 Db6rmUkmB2vrrSKPn5SlHnxhjjJZS5RpA9KqznHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56658F80229;
	Thu, 24 Sep 2020 12:57:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BB55F80232; Thu, 24 Sep 2020 12:57:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5450AF8015F
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2020 12:57:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5450AF8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VLm4Jn9a"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6C403239A1;
 Thu, 24 Sep 2020 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600945060;
 bh=hJuK6eidGEuH4OKBWaGFMIQh1rk6ZkOBQ6avcRUR0+k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VLm4Jn9aN99ao8Q+cFVaTWZrNbwLjI+wykSTF/cfbTuswtFDK7wd17aCTJAtkFH8V
 nRWHVIzQ7ff7ztbZNoEZm/MBIFoaHc6i6MsOsf4G9/Ih+MlnjsWUlZxAYP8vjMfkYc
 xBBUqbxZFmlfsUh2vrxIRLY1fry+pen0NHXjjb4Q=
Date: Thu, 24 Sep 2020 11:56:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC: SOF: fix kcontrol size checks
Message-ID: <20200924105645.GA4754@sirena.org.uk>
References: <20200921110814.2910477-1-kai.vehmanen@linux.intel.com>
 <160073312817.6173.14263034136602358389.b4-ty@kernel.org>
 <alpine.DEB.2.22.394.2009240841280.3186@eliteleevi.tm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2009240841280.3186@eliteleevi.tm.intel.com>
X-Cookie: Programmers do it bit by bit.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com
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


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:45:30AM +0300, Kai Vehmanen wrote:

> I wonder what happened here...? Patches 4 and 5 didn't end up applied=20
> although they were in the sent series. I can send them again no prob, but=
=20
> wondering if there was something wrong in the original series, so I can=
=20
> avoid the problem in the future.

Do those patches actually apply to for-5.10 or are they correcting
issues that only exist in for-5.9?

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9se2wACgkQJNaLcl1U
h9Dh1Qf9GDCX6d1me6UfrcWauzb4MP/LrULNEZhmctTLK/RTkMEvLDTLHRNpE5wt
I8WXniQM47CsdrBlfv27eyHKA3/6NXrgT1xBZuh6+CKamNXpnaZSuF7cvEgS2BS3
U0J2LblDXgQxh9jWlTUEtB8vZ09IUHvS7H4idElDZBzMXp9J3NVoVqcGuvnWtKr8
eH0pefQZtcfD3zVfO5xHD/+4KTk/JSl7zMqb4bxTPMBQwKpimGK9PeUlFsCYMhxg
T1SdPRh9IVqnNrb5AvdWaTt24U2E/iayply09lJ4zIRe9PKPEaQ7xHEJb0+4v3P3
rX8Ts7rn6H/kAk0+vjviftiGUoF9bg==
=caWV
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
