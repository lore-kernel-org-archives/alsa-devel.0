Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C45EC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 04:38:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D98960EC0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 04:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D98960EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9822C17D0;
	Mon,  2 Aug 2021 06:37:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9822C17D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627879090;
	bh=bOV8QRJlZSK0S7Tob0YrhYTd7LxOrJnuNVmVAD3nWv4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=trM9yiaHCoo9W6V5D3Ic6BaZrtrCnkbyu32DWI3kKR7ghggbN4w4tZMmjgrpk1+h1
	 INm5g2GAPfBuwF0uEcvhpaYJ7oTIsrkxxl4+Lh85otD3/6oF9RVbz20hceaNjn15di
	 0Bg5qzEJjJKnAlI7PwhTQvmoB2sFmhKW2qlYAITI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 326DEF801F7;
	Mon,  2 Aug 2021 06:37:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73B17F80268; Mon,  2 Aug 2021 06:37:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32361F8014D
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 06:37:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32361F8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Irj82VvJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3166060FC1;
 Mon,  2 Aug 2021 04:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627879030;
 bh=bOV8QRJlZSK0S7Tob0YrhYTd7LxOrJnuNVmVAD3nWv4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Irj82VvJt8GldTn81sJ6UBXl7QOcZ3yl6deRr++5lx6t/7qzUSglVFtdHXDjW6Dci
 RJU1NpN61Gcm2jr+kHyXlvm3Icg7u0yheDdGNh//DhczKkTxNMTVLRlNzOwzKYaFf+
 OWXaigfvCUU2OWLcxDvZc0XqkE/y8dYY1zA+ZdFph1PJBlmw20YOWASUPvpyx+d7po
 X97IfQ28MwUDull+1UM1HljNzne7y3M1/7f/0de5CoYVtDP2EM+an2dHAYSzMvYGzE
 JvXUpOTpMKtMpvA9loG8OTkdYG86eB2BKhIaOgJJuBg4Tck382GVuQZjF3YbqFfCkP
 A2FQFPWrmOVlw==
Date: Mon, 2 Aug 2021 10:07:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Subject: Re: [PATCH v2 0/6] soundwire/ASoC: abstract platform-dependent bases
Message-ID: <YQd2ckho9D9DF9lJ@matsya>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
 <20210727161133.GY4670@sirena.org.uk>
 <DM6PR11MB40744606D9CD2D3FD27FC92FFFEA9@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40744606D9CD2D3FD27FC92FFFEA9@DM6PR11MB4074.namprd11.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On 28-07-21, 00:38, Liao, Bard wrote:
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Wednesday, July 28, 2021 12:12 AM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; vkoul@kernel.org; vinod.koul@linaro.org;
> > linux-kernel@vger.kernel.org; tiwai@suse.de; gregkh@linuxfoundation.org;
> > srinivas.kandagatla@linaro.org; pierre-louis.bossart@linux.intel.com; Kale,
> > Sanyog R <sanyog.r.kale@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH v2 0/6] soundwire/ASoC: abstract platform-dependent
> > bases
> > 
> > On Fri, Jul 23, 2021 at 07:54:45PM +0800, Bard Liao wrote:
> > > shim base and alh base are platform-dependent. This series suggests to
> > > use variables for those bases. It allows us to use different bases for
> > > new platforms.
> > 
> > The ASoC bits look fine to me, what't eh plan for merging this?  I can apply to
> > ASoC if people like, or should the Soundwire bits go via the Soundwire tree?

I have acked the sdw parts, pls pick them thru ASoC tree. If we have
conflicts, I can merge the immutable tag from your tree.

> Thanks Mark. Apply to ASoC or Soundwire are both fine to me.

-- 
~Vinod
