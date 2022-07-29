Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955FFC00144
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jul 2022 16:47:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9801C15E2;
	Fri, 29 Jul 2022 18:47:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9801C15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659113270;
	bh=9jM9mztwAIfVEKsgETMmbLznTItKcbywHJIDqBixobk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ufN3Ag7vEymb2zVjszOUioGxdqpuDTebu/pQgNcWI7vt/M3GQx1JuaNxpdtRgAij7
	 XtduFggLH40k6dGsRH+R13rWw7aWrT8tddSAAo9e0sTjZDN0MZ6XgFnh08wxqdzdIv
	 p67ySvt6AqAmHf4e7DpWE6b5zB95ts/ukS2xbui8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08458F8015B;
	Fri, 29 Jul 2022 18:47:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8F89F8049C; Fri, 29 Jul 2022 18:46:58 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14B9CF8015B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2022 18:46:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14B9CF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="i2Rsw6FG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659113216; x=1690649216;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9jM9mztwAIfVEKsgETMmbLznTItKcbywHJIDqBixobk=;
 b=i2Rsw6FG8A5eMEZg68DD67eut9VRVm6JSTHVypZfeY5SD4biFDP/AIrf
 OZb0NBRVrGJhQ6trocuyNcGewYCbARLwbQxczU7GoGqi66Hr5kt5iGv5+
 OIBTV5xOJ6LholJvMyPBx+GhukmdDZhI7gpW08ZUwEssFmmtYmPYalyyo
 JACARoOcnGef4H863oZf1+lxj2BRxv/Ul2g+uVAGBPyfHdVQz9V/+pRtP
 EkCjpFUjoY+RAuF9HUCfL34rM11blmpcMw7yHl6NRqPxRbnJpluauEOG1
 lQjmwSN6SYzoFXzQT6GX/HdIZaFeesylIpcdLDoYmrsltPv7cQDXG7VdK A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="286359898"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; d="scan'208";a="286359898"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2022 09:46:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; d="scan'208";a="605014348"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86])
 ([10.212.97.86])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2022 09:46:47 -0700
Message-ID: <701aa1ba-9b25-51eb-8bd7-2389b501d79c@linux.intel.com>
Date: Fri, 29 Jul 2022 11:46:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
 <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
 <YuP0Ffs3G7ZBR0AC@kroah.com>
 <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
 <YuP2pjhyKTTfpXQq@kroah.com>
 <5caffe2a-f5a6-e312-a564-5fe29c4e2323@linux.intel.com>
 <YuQMYRYFo9gTk1yL@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YuQMYRYFo9gTk1yL@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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


>>>>> That should be fine, tools should just be looking for the attributes,
>>>>> not the existance of a directory, right?
>>>>
>>>> The idea what that we would only expose ports that actually exist.
>>>> That's helpful information anyone with a basic knowledge of the
>>>> SoundWire specification would understand.
>>>
>>> Is "dp0" a port?  If so, why isn't it a real device?
>>
>> The SoundWire spec defines the concept of 'data port'. The valid ranges
>> are 1..14, but in all existing devices the number of data ports is way
>> smaller, typically 2 to 4. Data ports (DPn) are source or sink, and
>> there's no firm rule that data ports needs to be contiguous.
>>
>> DP0 is a 'special case' where the data transport is used for control
>> information, e.g. programming large set of registers or firmware
>> download. DP0 is completely optional in hardware, and not handled in
>> Linux for now.
>>
>> DP0 and DPn expose low-level transport registers, which define how the
>> contents of a FIFO will be written or read from the bus. Think of it as
>> a generalization of the concept of TDM slots, where instead of having a
>> fixed slot per frame the slot position/repetition/runlength can be
>> programmed.
>>
>> The data ports could be as simple as 1-bit PDM, or support 8ch PCM
>> 24-bits. That's the sort of information reported in attributes.
> 
> Why not make them a real device like we do for USB endpoints?

I don't see what adding another layer of hierarchy would bring. In their
simplest configuration, there are 6 registers 8-bit exposed. And the
port registers, when present, are accessed with a plain vanilla offset.

> What uses these sysfs files today that would be confused about an empty
> directory?

That's a good question. I am not aware of any tools making use of those
attributes. To a large degree, they are helpful only for debug and
support, all these read-only attributes could be moved to debugfs. That
could be a way to simplify everyone's life....
