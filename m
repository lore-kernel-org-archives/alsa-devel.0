Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E503DC47404
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 13:38:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E490D218AC
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 13:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cTWC0bGF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TkpLetSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E490D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A688F86E;
	Wed,  9 Oct 2019 15:37:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A688F86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570628286;
	bh=FDkJTNysqSfgaCuMRxKchzaIKQ50LK/hhVeuhpcRrrs=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cTWC0bGF/OW2sM4J+15nuo0NoFnuLctve6UE9jZh54iILDXnGi9F8y9VKX5cD3Vbx
	 GOKQ8P3xx4hLb0RHnOQns6r5oHnRZ+c9pgGfPFrASswFbIunqfTpK9m/pjF9/GCFTq
	 CWBWz81kexVfkUUROS7z7GTjTTb3YPe8dJNbD3g4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39523F802BD;
	Wed,  9 Oct 2019 15:37:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64104F802BE; Wed,  9 Oct 2019 15:37:14 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16DD5F80113
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 15:37:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16DD5F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="TkpLetSu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XfFUTXDUlOBhRb5NjOcI6XT8SYuoYPJzK11sfR/uJkA=; b=TkpLetSuWl8IcRpP8aCZuAweh
 rQ//FqOsPsXPcYJaQWrJ5aAhgDZL0qJHoZ73wlcoyF1KNoBWv0Ino2ACKa67KCOxx20xy3XCwf6+O
 VXo+b4KcDuCtrfE7AJaVQcVmRn82phybnp+1dy1SUQZZAO/1ZqWLk6cWTpjLlVIMtR5cw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iIC9O-0004sS-EY; Wed, 09 Oct 2019 13:37:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 2E1F92741DF9; Wed,  9 Oct 2019 14:37:09 +0100 (BST)
Date: Wed, 9 Oct 2019 14:37:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Message-ID: <20191009133709.GB3929@sirena.co.uk>
References: <20191007071610.65714-1-cychiang@chromium.org>
 <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
 <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net>
 <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com>
 <5d9b5b3e.1c69fb81.7203c.1215@mx.google.com>
 <CAFv8Nw+x6V-995ijyws1Q36W1MpaP=kNJeiVtNakH-uC3Vgg9Q@mail.gmail.com>
 <5d9ca7e4.1c69fb81.7f8fa.3f7d@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <5d9ca7e4.1c69fb81.7f8fa.3f7d@mx.google.com>
X-Cookie: Every path has its puddle.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Tzung-Bi Shih <tzungbi@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Hung-Te Lin <hungte@chromium.org>, Tzung-Bi Shih <tzungbi@google.com>,
 Sean Paul <seanpaul@chromium.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dylan Reid <dgreid@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
 Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH] firmware: vpd: Add an interface to read
	VPD value
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
Content-Type: multipart/mixed; boundary="===============1617050330080636101=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1617050330080636101==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 08:14:43AM -0700, Stephen Boyd wrote:
> Quoting Cheng-yi Chiang (2019-10-07 11:50:31)

> > IMO the nvmem approach would create more complexity to support this
> > simple usage. Plus, the underlying assumption of accessing data with
> > offset in a buffer does not fit well with the already parsed VPD
> > values in a list of vpd_attrib_info. But if you strongly feel that
> > this is a better approach I can work toward this.

> I'm not sure how an ACPI system like this would work because my exposure
> to ACPI is extremely limited. I would expect there to be some sort of
> firmware property indicating that an nvmem should be used and it's
> provided by VPD or for firmware to parse VPD itself and put the
> information into the ACPI table for this device.

I fear this is optimistic.  It's fairly idiomatic for ACPI for stuff
like this to be keyed off DMI information rather than integrated with
anything, basically once you get out of the bits that are explictly
standardized you're into board file territory.  There is the _DSD stuff
for using DT properties in ACPI but it's had limited use AFAICT.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2d4oQACgkQJNaLcl1U
h9AkxAf/WtJz8gLoIEhfmWFM3Y4Qvz6cFPqsO5kNBWEQH18SykjRbNumBoeynRlg
0j+2Vz6nFCns429nsLJ/ooS/sKbFGY9UfK8TDxJdUiifheot3MJahzT92vTj7LbB
AGk+U9e4/n627enaqdqDGmf8m2aPpUqJdmPhr0zuV8/N2c3SMzCTcBXB4BGqkd9I
My1IdAX5qlmi5+Q0SXmUJjwJtiVs0rdurw3TcKaOdpvhDmyLdJVuaLYmM1QXh0v8
G5UNLVXzEN0RJZO7dDnbImprk1hOTC7Sze0T5ykh0W0UeydBAw7stk0zVGYro7jO
K/UYMfOOX3LPFttYf22WeGOLFUf5TQ==
=UWfy
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

--===============1617050330080636101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1617050330080636101==--
