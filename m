Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0EC2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:21:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0D420774
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G9zrIsC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0D420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86AE81696;
	Tue, 14 Apr 2020 20:20:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86AE81696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586888460;
	bh=i2VJHzqXV7fR1sU17Ix8rFH4kGQZI/FajT3bbWDrxoE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G9zrIsC5Cjg8EZAyiMQ9sl3V7k476OWGH0CYRTFKGoAuGBY4rh1MM8aOAfTvbl6nI
	 JONziWPhNqst/9LW1c/Acl9QQNpl40ebH9wd/bAfugUNs20jmDKuRi5vgkeyNzpJ7I
	 76LfWBaY8z79kMBDaMXPT4aeDyluzcsSPPyYJRo0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4849EF802A8;
	Tue, 14 Apr 2020 20:17:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97F83F802BE; Tue, 14 Apr 2020 20:17:19 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBA3EF802A2
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 20:17:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBA3EF802A2
IronPort-SDR: 7nfWMpzyuawL3eCBRltjBGNS/BqQA9TkVB8A8kPtRNBAtKqHGdoHHkCNs+npYneccq7YX4rWFX
 O2wN7uWjcUJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 11:17:10 -0700
IronPort-SDR: uPqKRcefbvc94/62dOljXtXTMc0Y58mmAdW6Vaerzb18DgsEhoTWXhjtc3bmuyN7uJgfQxZ9OP
 8UJzIYsP7Evw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; d="scan'208";a="253272959"
Received: from svarahab-mobl.amr.corp.intel.com (HELO [10.212.190.40])
 ([10.212.190.40])
 by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 11:17:05 -0700
Subject: Re: [RFC PATCH 07/16] clk: hifiberry-dacpro: initial import
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-8-pierre-louis.bossart@linux.intel.com>
 <20200414173110.GG34613@smile.fi.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1483c322-66b9-d68e-c8e9-81f826b01108@linux.intel.com>
Date: Tue, 14 Apr 2020 13:09:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414173110.GG34613@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Matthias Reichl <hias@horus.com>,
 tiwai@suse.de, DigitalDreamtime <clive.messer@digitaldreamtime.co.uk>,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Daniel Matuschek <daniel@hifiberry.com>, linux-clk@vger.kernel.org,
 Hui Wang <hui.wang@canonical.com>, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, broonie@kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>
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



On 4/14/20 12:31 PM, Andy Shevchenko wrote:
> On Thu, Apr 09, 2020 at 02:58:32PM -0500, Pierre-Louis Bossart wrote:
>> From: Daniel Matuschek <daniel@hifiberry.com>
>>
>> This patch imports the clock code from the Raspberry v5.5-y tree. The
>> ASoC machine driver initially present in this patch was dropped. The
>> comments are also dropped but all sign-offs are kept below. The patch
>> authorship was modified with explicit permission from Daniel Matuschek
>> to make sure it matches the Signed-off tag.
>>
>> This patch generates a lot of checkpatch.pl warnings that are
>> corrected in follow-up patches.
> 
> I guess it will be waste of time to review this part without squashing it first.

I wasn't sure if squashing was desired, so kept all my changes separate. 
There are some changes from the legacy clk to the clk_hw parts plus 
introduction of ACPI support that are easier to review if kept separate. 
Maybe I should have squashed the cosmetic parts in patch8, and kept the 
functional changes as separate patches.
