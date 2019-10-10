Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12AAC10F14
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 19:23:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B202206B6
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 19:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vuOGG4Be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B202206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B52921682;
	Thu, 10 Oct 2019 21:22:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B52921682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570735389;
	bh=xottN+tz4rToXYZmvE3nnMWypxHo+p8Lf3+LYTgg/kU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vuOGG4Benmf8iIexV6odprjiUknKMD5Oif/dygdteJt2UM2waVHIW5qJUz8CL7+pb
	 uq4A9OwWEJO6WUYUhNOSkJENUraG6jGiGYHdQfDCw1g5kBykYEQtR6vOn6HJLzRb4J
	 jkqvV/8ePz0wOyHO0l7d+k3roHal1xIXOlcld/XA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B00E0F805A8;
	Thu, 10 Oct 2019 21:21:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAA35F805A8; Thu, 10 Oct 2019 21:21:50 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C13B5F802BC
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 21:21:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C13B5F802BC
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2019 12:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; d="scan'208";a="206203515"
Received: from pchamber-mobl1.amr.corp.intel.com (HELO [10.252.139.48])
 ([10.252.139.48])
 by orsmga002.jf.intel.com with ESMTP; 10 Oct 2019 12:21:39 -0700
To: Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@gmail.com>
References: <20191009181356.GO2036@sirena.org.uk>
 <CAEnQRZAR1b-CHHVEv0ia92vYu38fWkwgW3mdwJFhEQsHk2j5+A@mail.gmail.com>
 <20191010155716.GE4741@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <47378afc-f7ef-d6fa-7b0d-efc3fbe494e0@linux.intel.com>
Date: Thu, 10 Oct 2019 11:43:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010155716.GE4741@sirena.org.uk>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Curtis Malainey <cujomalainey@google.com>,
 Guido Roncarolo <guido.roncarolo@nxp.com>
Subject: Re: [alsa-devel] [ANNOUNCE] 2019 Linux Audio miniconference
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 10/10/19 10:57 AM, Mark Brown wrote:
> On Wed, Oct 09, 2019 at 09:48:14PM +0300, Daniel Baluta wrote:
>> On Wed, Oct 9, 2019 at 9:15 PM Mark Brown <broonie@kernel.org> wrote:
> 
>> My topics:
> 
> I'll add these to the agenda.
> 
>> - SOF driver: ACPI / DT unification
> 
> Are there concrete plans to discuss here or is this more of a
> "what are we doing" kind of thing?  ACPI standardization has been
> an issue :/

I took this agenda item as "how machine drivers are handled in SOF".

Currently the core creates a platform device which will result in a 
machine driver being probe and the card created. This is mainly due to 
the lack of 'machine device' in existing DSDT tables. DT has explicit 
support for machine drivers, so we need to have a solution that caters 
to both.

> 
>> - SOF driver: Handling built-in driver use case
> 
> What's the issue here?

The SOF driver (or any existing driver with closed-source firmware) will 
not work when compiled as built-in due to the request_firmware() 
dependency. This wasn't too much of an issue for Intel so far, but for 
i.MX platforms it's quite common to have no modules.

Daniel, did I get things right?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
