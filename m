Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA63E936FB
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Oct 2023 07:48:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D672852;
	Sat,  7 Oct 2023 09:47:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D672852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696664884;
	bh=FsuNWMf0N4XVEpM8Gp9Fpsy0R2JaWYC8X1jhOqWEAms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Cm9EaaLvtPF9PCvckHNKW9o2/CMD4P2ed5gpsjBOmb4dcNS3/uckIdSs01q1vV8j1
	 PDSURfpd1Rbeb8wl9ZdXdHaYj8zNh18VG4XBUhxqh75Fkky3NydpWRvav7VUlpulWR
	 nNTiwYgzUCfEhqqzxzG3jiZ4MSdkRoZfRn/X7HEU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31AB3F8057A; Sat,  7 Oct 2023 09:46:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F3E1F8055C;
	Sat,  7 Oct 2023 09:46:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE527F8047D; Fri,  6 Oct 2023 21:30:30 +0200 (CEST)
Received: from mail.andi.de1.cc (unknown [IPv6:2a02:c205:3004:2154::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BF010F80166
	for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2023 21:30:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF010F80166
Received: from p5dc58044.dip0.t-ipconnect.de ([93.197.128.68] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1qoqWU-004b0J-U9; Fri, 06 Oct 2023 21:30:06 +0200
Date: Fri, 6 Oct 2023 21:30:03 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
 bcousson@baylibre.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 jarkko.nikula@bitmer.com, dmitry.torokhov@gmail.com,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
Message-ID: <20231006213003.0fbac87a@aktux>
In-Reply-To: <20231006102348.GK34982@atomide.com>
References: <20230705190324.355282-1-andreas@kemnade.info>
	<20230705190324.355282-2-andreas@kemnade.info>
	<7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
	<20230920063353.GQ5285@atomide.com>
	<dac768d2-2c66-4d6b-b3d3-d1ef69103c76@gmail.com>
	<20230921121626.GT5285@atomide.com>
	<20231006102348.GK34982@atomide.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MailFrom: andreas@kemnade.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: X5GQI76H2NBBD2PTUOJ6CVXEUFVCDZVT
X-Message-ID-Hash: X5GQI76H2NBBD2PTUOJ6CVXEUFVCDZVT
X-Mailman-Approved-At: Sat, 07 Oct 2023 07:46:14 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X5GQI76H2NBBD2PTUOJ6CVXEUFVCDZVT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 6 Oct 2023 13:23:48 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Tony Lindgren <tony@atomide.com> [230921 20:34]:
> > * P=C3=A9ter Ujfalusi <peter.ujfalusi@gmail.com> [230920 17:40]: =20
> > > It is not the parent's fck, it is the PRCM clock which is selected as
> > > the sourcee of the clock generator (CLKS) for BCLK/FSYNC. That is the
> > > functional clock as well for the McBSP instance. =20
> >=20
> > Oh OK
> >  =20
> > > Out of reset it is using the PRCM source which is fine in all current=
 users.
> > > I would do this fix or workaround in a different way: instead of
> > > ignoring the error, avoid it in the first place. Do nothing if the
> > > already selected clock is requested.
> > > That would remove the error and will fail in case the reparenting is =
not
> > > working -> boards will know this and might be able to do something ab=
out
> > > it in a reasonable way. =20
>=20
> Here's what I think the regression fix for omap4 clocks would be, the
> old main_clk is not the same as the module clock that we get by default.
> If this looks OK I'll do a similar fix also for omap5.
>=20
> Or is something else also needed?
>=20

hmm,
audio output works, the waring is away, but something new is here:
omap-mcbsp 40124000.mcbsp: Runtime PM usage count underflow!
# cat /sys/bus/platform/devices/40124000.mcbsp/power/runtime_status=20
active

even with no sound.

Regards,
Andreas
