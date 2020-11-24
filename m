Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4EEC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 16:15:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FB520715
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 16:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZwQ+GXLf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDGZSf8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FB520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAD6216C6;
	Tue, 24 Nov 2020 17:14:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAD6216C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606234540;
	bh=D+VOLNIUYmLlf9Ah2kJxu796igckWvVd2iVepDXrEkY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZwQ+GXLfmxDyF9IEGF6NqBhYvUAMKOUhv0DSORnpYExNOUct8QmdzgPSBDkx5KzIJ
	 6hI9wFocKbdZ1zqLYDSq9l9t8AkENhWUFiKy62FO0m6GGlJzZ2AgKiFHPt9siC0FsF
	 TSVhIxDau1/FdqWyPDH+MIjeC+WMXPAlGkrG6GFs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76D89F8015A;
	Tue, 24 Nov 2020 17:14:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A62F8F8016A; Tue, 24 Nov 2020 17:14:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4BB62F8015A
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 17:14:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BB62F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EDGZSf8X"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7CB0B20715;
 Tue, 24 Nov 2020 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606234483;
 bh=D+VOLNIUYmLlf9Ah2kJxu796igckWvVd2iVepDXrEkY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EDGZSf8XZ9Qs82rqrXZbGyra5u7QPfWY3EXo8+7/2sjqmFL0bxHxKgMAVdeBRgfJC
 puBEpFhkSCczfW078GQMTDXAfyQmszliZejdvcJD9A/dnMINUaCRIXV0Th22PTDD6p
 W22FNzx9rsskI7pehJIxaS1V7DesBLNal0AGYkAk=
Date: Tue, 24 Nov 2020 16:14:19 +0000
From: Mark Brown <broonie@kernel.org>
To: "Rojewski, Cezary" <cezary.rojewski@intel.com>
Subject: Re: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Message-ID: <20201124161419.GG4933@sirena.org.uk>
References: <d94ccf9a3c61460db88f256df1fa3240@intel.com>
 <20201120164841.GF6751@sirena.org.uk>
 <758af664b89545c5be83ca2bc81078fb@intel.com>
 <20201120180627.GI6751@sirena.org.uk>
 <c8cd5f98e7c941c1b87aaabb850ece4e@intel.com>
 <20201123173533.GL6322@sirena.org.uk>
 <41fbc38fa46f41f49b4ff846f9f7b5b2@intel.com>
 <20201124140119.GC4933@sirena.org.uk>
 <s5hsg8yrgcp.wl-tiwai@suse.de>
 <ed9b1430fdc54c2c9b49ac7a186b9c60@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="07FIeBX8hApXX6Bi"
Content-Disposition: inline
In-Reply-To: <ed9b1430fdc54c2c9b49ac7a186b9c60@intel.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
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


--07FIeBX8hApXX6Bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2020 at 04:07:19PM +0000, Rojewski, Cezary wrote:

> Believe removal of /sof/intel/bdw.c is in order?

Right, like I've said several times if we can remove all the other
support then we can remove the conditional code.

--07FIeBX8hApXX6Bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+9MVoACgkQJNaLcl1U
h9CkzAf/dNRX/Q/FLkM4/n/pDbD3s9K6DgnDo9Qbc7bQ/dxyhqIOiSehQfDuAhRd
WPkZES5mOtKJ4872OkIMxyz6WlW06DlxGeoT/RcnQraTr/SGtY0Z2AEZOHgJCZUt
rJ/auorEfRMc4MQmXvC9myWeT9qc6DpszsTyGy52VpcyDtqHaISY8rQWhaSNp5DT
f6QZlaVEUMQPoxr7/Pe/qd79q1UDf4wWF5YgVF441NXNb/AgcF4P9oWC81GiTk9F
xVuSECXMfG/PIza+/Dneq4iJKjKBrLovvldp7ivO8sAZ8Bd4Sxgdi8sQvVx/NXiB
9EntSzegy7SqstsuOrSouiAe9tIaTg==
=3Egk
-----END PGP SIGNATURE-----

--07FIeBX8hApXX6Bi--
