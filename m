Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD1C34056
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:55:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DAA206DB
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sgyAH1/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DAA206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AB1416AC;
	Wed, 19 Feb 2020 19:54:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AB1416AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582138500;
	bh=hZj/cjULbApGjGX6cWY81KOLBYMnpFCMnCip93acI4o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sgyAH1/DBgbPbwglVnxyNdzw6+JAJvyKAgRO9vix2KlJSAZ4H2xDVqtT5j081lzfK
	 1wd2i2/VGX1TcrxbjBbTnNTBiSsqUUhGU2YQruexLRzMOGlxJA6M2b1NDww0UvjFvW
	 F5v/cjfD28N1glTQ29pJIF442vKVWMxN0Yp4qu5A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 577F7F801F5;
	Wed, 19 Feb 2020 19:53:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BC66F80279; Wed, 19 Feb 2020 19:53:18 +0100 (CET)
Received: from muru.com (muru.com [72.249.23.125])
 by alsa1.perex.cz (Postfix) with ESMTP id 5DF40F801F5
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 19:53:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DF40F801F5
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 63BF180F3;
 Wed, 19 Feb 2020 18:53:50 +0000 (UTC)
Date: Wed, 19 Feb 2020 10:53:02 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] ASoC: cpcap: Implement set_tdm_slot for voice call support
Message-ID: <20200219185302.GC37466@atomide.com>
References: <20200211181005.54008-1-tony@atomide.com>
 <ae2b7d9e-d05e-54ac-4f18-27cc8c4e81a0@ti.com>
 <20200212144620.GJ64767@atomide.com>
 <9a060430-5a3e-61e1-3d2c-f89819d9436f@ti.com>
 <20200217232325.GD35972@atomide.com>
 <8fc1dded-6d28-f5cd-f2f9-3a6810571119@ti.com>
 <20200218153211.GI35972@atomide.com>
 <20200218170628.r47xc3yydg6xx2yh@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218170628.r47xc3yydg6xx2yh@earth.universe>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, "Arthur D ." <spinal.by@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
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

* Sebastian Reichel <sebastian.reichel@collabora.com> [200218 17:07]:
> On Tue, Feb 18, 2020 at 07:32:11AM -0800, Tony Lindgren wrote:
> > OK, but so what's the machine driver part in this case?
> 
> simple-graph-card is the current machine driver. We might have to
> introduce a Droid 4 specific driver instead. I used simple(-graph)-card
> instead of introducing a new driver, since the setup was simple enough
> without modem and bluetooth. The simple card was perfect to test the CPCAP
> codec driver. The TDM things might be complex enough to create
> a new machine driver (as I mentioned in the original patchset
> adding CPCAP codec support).

Well we do have the .set_tdm_slot to configure things. If it turns
out we only need to track the machine audio state in cpcap.c, then
we don't need a separate machine driver.

However, if it turns out that cpcap is not always active for
some audio paths, then yeah it seems that we need a custom
machine driver to keep track of the machine audio state.

> Note: Don't use Motorola's tree to learn about ASoC. Their soundcard
> and cpcap codec drivers are full of weird hacks. I'm pretty sure the
> author(s) did not really understand how ASoC works. From my
> experience you should only use their code to understand the
> hardware wiring. You might also want to look into the MC13783
> datasheet for the keyword "network mode".

Yeah nope. And just dumping out the cpcap registers in Android
seems to provide enough information to get the missing features
working.

Regards,

Tony


