Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD18E92FFD
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Oct 2023 07:43:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 329691F6;
	Sat,  7 Oct 2023 09:42:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 329691F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696664613;
	bh=NHlc0dHNzUfeJpmN0hzFeJnwUQepAyVX5MqOsTmblLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XZOLd8875iikDQQWfmuOzlcbf/oZrvtohop6qkLcByAzSdCNxolDbnPmRDkb8zFz0
	 1PVAT+Q1uZaPU+5Gxi5pA2QEQ7jAMSY6j8R2mfqDhZiBg4lkTesSTGUSAss04+uEeG
	 Y2cy3IKs24VXu9pKHdeW76wUN4TA0QNQiYSsUDOg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4CB9F8055A; Sat,  7 Oct 2023 09:42:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D91EF8047D;
	Sat,  7 Oct 2023 09:42:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A99B5F8047D; Sat,  7 Oct 2023 09:42:09 +0200 (CEST)
Received: from muru.com (muru.com [72.249.23.125])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D74BF800C1
	for <alsa-devel@alsa-project.org>; Sat,  7 Oct 2023 09:42:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D74BF800C1
Received: from localhost (localhost [127.0.0.1])
	by muru.com (Postfix) with ESMTPS id 45F88809E;
	Sat,  7 Oct 2023 07:42:01 +0000 (UTC)
Date: Sat, 7 Oct 2023 10:41:59 +0300
From: Tony Lindgren <tony@atomide.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	bcousson@baylibre.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, jarkko.nikula@bitmer.com, dmitry.torokhov@gmail.com,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
Message-ID: <20231007074159.GX34982@atomide.com>
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-2-andreas@kemnade.info>
 <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
 <20230920063353.GQ5285@atomide.com>
 <dac768d2-2c66-4d6b-b3d3-d1ef69103c76@gmail.com>
 <20230921121626.GT5285@atomide.com>
 <20231006102348.GK34982@atomide.com>
 <20231006213003.0fbac87a@aktux>
 <20231007062518.GM34982@atomide.com>
 <20231007091156.588d7ba1@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007091156.588d7ba1@aktux>
Message-ID-Hash: WNPHPWNIPDO654QHGMJT2O4RIKC4G2UT
X-Message-ID-Hash: WNPHPWNIPDO654QHGMJT2O4RIKC4G2UT
X-MailFrom: tony@atomide.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WNPHPWNIPDO654QHGMJT2O4RIKC4G2UT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

* Andreas Kemnade <andreas@kemnade.info> [231007 07:12]:
> Well, it is a regression caused by your fix. Without it (and not reverting
> the already applied ignore patch), runtime is properly suspended. Don't know
> why yet.

We return early from omap2_mcbsp_set_clks_src() with IS_ERR(fck_src) and
the runtime PM functions never get called?

Regards,

Tony
