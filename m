Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5EC64E7A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 04:12:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D691420725
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 04:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TahS8gOV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYrfTCVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D691420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A2F71786;
	Tue,  1 Dec 2020 05:11:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A2F71786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606795964;
	bh=SdakvgRnTxtSgskiL5/rtYasL84SX/GuXdSsUwb3fts=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TahS8gOVSSnAPw5L7Q7x51o9AoGYx6bNgjy5NhBvvBYQzwRB3rbiiyXDzX+8Bge2D
	 +Q/LMt2J3WOha3JsZpj7uE8FdDmlrJYwB2YQz0OZWNJDk6sn758KJqrHk8d48m3pYU
	 fio/yUPQW/IThtBw24ltlvJhvIYzDuu06rQPrO/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F607F8016C;
	Tue,  1 Dec 2020 05:11:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABEADF8016D; Tue,  1 Dec 2020 05:11:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B57C0F80168
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 05:11:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B57C0F80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PYrfTCVG"
Received: from localhost (unknown [122.171.214.243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6549020725;
 Tue,  1 Dec 2020 04:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606795903;
 bh=SdakvgRnTxtSgskiL5/rtYasL84SX/GuXdSsUwb3fts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PYrfTCVG9xvWAzt4axPZRVoD3DNqJR5CMtcAwK5NKhEXpI+oXdghm4i6wwZMDRd1J
 qa/QWysryw5R3A3xw17Z/ToI4wXNLzSZokwwo6V6I0DXbKFEu/HyKiNGC8tqgW5B2Q
 7EVn+ccvaBshnaOysYw5kLX4KVvchTnDxk261SAE=
Date: Tue, 1 Dec 2020 09:41:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Subject: Re: [PATCH v2 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA support
Message-ID: <20201201041138.GY8403@vkoul-mobl>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
 <DM6PR11MB4074311B4E0B70F24383E754FFF40@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4074311B4E0B70F24383E754FFF40@DM6PR11MB4074.namprd11.prod.outlook.com>
Cc: "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 "jank@cadence.com" <jank@cadence.com>, "Kale,
 Sanyog R" <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>
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

On 01-12-20, 02:42, Liao, Bard wrote:

> Hi Vinod/Mark,
> 
> Could we take this series into Vinod's tree with Mark's Acked-by?
> It failed to build on Mark's tree.

I see Mark has already applied 1-3 ..

Thanks
-- 
~Vinod
