Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238C1C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 06:42:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76B361053
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 06:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B76B361053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79D3A165E;
	Thu,  7 Oct 2021 08:42:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79D3A165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633588975;
	bh=E6yBjn5cFwIWNKFQrZP7y4A+jPNhDTvyY2Era8pRV1k=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G5mP9/XDOT+GWcKOQgfI7uWHE8JUkgBT+fBHlIx996PTUCJzH6GDwc2ohdJit8xwx
	 IVh5qTzFjKr2Mg5++gUpqzNrU8kbCr1xVHh0BLhsgH+hwkoldoQpeFDGAgOMRO+3gM
	 cp71MwyIavDCrtZ5b9E7whnUwkl6EuqGp0BLHxbs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5108F80259;
	Thu,  7 Oct 2021 08:42:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7344EF8027D; Thu,  7 Oct 2021 08:42:03 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77011F800FE
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 08:41:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77011F800FE
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226070991"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="226070991"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 23:41:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="624141136"
Received: from wetzigsa-mobl1.ger.corp.intel.com (HELO [10.249.41.59])
 ([10.249.41.59])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 23:41:53 -0700
Message-ID: <15fafb2c-57d1-9029-2f85-1c34b686b901@linux.intel.com>
Date: Thu, 7 Oct 2021 09:42:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 00/19] ASoC: SOF: Improvements for debugging
Content-Language: en-US
To: alsa-devel@alsa-project.org
References: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
 <YV2HIkZv9dmSmvts@sirena.org.uk>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <YV2HIkZv9dmSmvts@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Mark,

On 06/10/2021 14:23, Mark Brown wrote:
> On Wed, Oct 06, 2021 at 02:06:26PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> The aim of this series is to clean up, make it easier to interpret and less
>> 'chatty' prints aimed for debugging errors.
>>
>> For example currently the DSP/IPC dump is printed every time we have an IPC
>> timeout and it is posible to lost the first and more indicative dump to find the
>> rootcause.
> 
> You might want to look at tracepoints and/or trace_printk, apart from
> anything else they're very useful for flight recorder style applications
> since they're very low overhead and have comparitively speeaking lots of
> storage available.

The trace infra is indeed a direction which would help on new hardware,
architecture bringup.

I should have used different subject for the cover letter as the end
result is to have better quality bug reports from users in the unlikely
event that something goes wrong (mostly on the firmware side).

To speed up the turnaround to get it fixed as the first report should
contain enough details to hint us where to look.

At the end the series will actually reduce the noise from dev_err() in
case of a failure by printing only needed information without repetition.

-- 
Péter
