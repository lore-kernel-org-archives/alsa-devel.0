Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118E3C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:17:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844C5206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ifBuuOoy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmWSJ3Me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844C5206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9702916B4;
	Mon,  9 Dec 2019 11:16:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9702916B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575886630;
	bh=AGw6FkzGb2bZ+JYG1nkvSvKvJ5lMbAiidwtwSWBGMjQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ifBuuOoyIE/GXDneYsS+7P5p9Xf4WQqu+NUPDs4Dl7rocOxA+R6WMTZu3ypbvGnOX
	 kgZHDJJVIug4EDzlJ/F6xikSo3IxCGYRg2xOZS8muLpTzsGbrw9uU6sfzqr2LQKTqf
	 AitsBtjReej/icVYxGeP6TUrxJgcyFro2gdZEvxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B483AF80442;
	Mon,  9 Dec 2019 10:52:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80CE3F801EC; Fri,  6 Dec 2019 18:56:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99A5DF80135
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2019 18:56:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99A5DF80135
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GmWSJ3Me"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4995D24673;
 Fri,  6 Dec 2019 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575654963;
 bh=IeiSscRuUwpcU/kAIShm5XFn2jzqzIym266sdGO0B4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GmWSJ3MeKrcW2bpYd6s3Ygl7u9mly6QPM3f4XROY8jlw4AVcf4PmijRTXrcumjVn3
 lYNzDhug0GFgHPE8J11h8F8zat7IitFCbX2TfpLPciTwbO6D9osmqSTSQ5vdyqrizD
 BXBh5PJqF4gMwHdVJGCDW9WIFSL/aLciWzy/S340=
Date: Fri, 6 Dec 2019 18:56:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <20191206175600.GB186026@kroah.com>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
 <e94e56bc-2b4c-5d95-002a-073c9272537d@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e94e56bc-2b4c-5d95-002a-073c9272537d@nvidia.com>
X-Mailman-Approved-At: Mon, 09 Dec 2019 10:51:21 +0100
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pgaikwad@nvidia.com,
 lgirdwood@gmail.com, mturquette@baylibre.com, mperttunen@nvidia.com,
 thierry.reding@gmail.com, josephl@nvidia.com, digetx@gmail.com,
 linux-clk@vger.kernel.org, mmaddireddy@nvidia.com, daniel.lezcano@linaro.org,
 krzk@kernel.org, jonathanh@nvidia.com, spujar@nvidia.com,
 devicetree@vger.kernel.org, arnd@arndb.de, markz@nvidia.com,
 alexios.zavras@intel.com, robh+dt@kernel.org, tiwai@suse.com,
 linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, tglx@linutronix.de,
 allison@lohutok.net, sboyd@kernel.org, pdeschrijver@nvidia.com,
 linux-kernel@vger.kernel.org, vidyas@nvidia.com, Jisheng.Zhang@synaptics.com,
 broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH v3 09/15] ASoC: tegra: Add fallback for
	audio mclk
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Dec 06, 2019 at 09:49:49AM -0800, Sowjanya Komatineni wrote:
> Thanks Greg.
> 
> Sorry, Will send this patch separately (out of this series) with stable tag
> to get this applied to stable kernels once review is done for this series.

Why not just properly add the tag in the original patch when it gets
merged?  That's how everyone else does it :)

This isn't new, it's been happening this way for 12+ years now...

thanks,

greg k-h
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
