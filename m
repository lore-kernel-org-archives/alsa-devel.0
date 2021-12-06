Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5091C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Dec 2021 14:44:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7A29205F;
	Mon,  6 Dec 2021 15:43:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7A29205F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638801853;
	bh=NarjBJ5+iM0vlPTr0ZTl66o8I4ElYxAG6LfbO8j76uc=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUHRUvzLQMjg5pN7bUyy8RIWvVQGy74HvKQEVVNVmOUv9Pdr3sRkSnf6RZfcTv7xE
	 TmcBq7yEsukoqYk8GFepeMk42ZKxOTAKaN6EMCCA5Hf9G9AQaHzsxxCnRwZy58XcwS
	 2xW4RklrQZGdzD5WJgVwVaSxA/SxWv8ROoBlXKD8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41659F804E4;
	Mon,  6 Dec 2021 15:43:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F10FEF804EC; Mon,  6 Dec 2021 15:43:21 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DA20F804AE
 for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2021 15:43:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DA20F804AE
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237138452"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; d="scan'208";a="237138452"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 06:43:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; d="scan'208";a="479136104"
Received: from jcsee-mobl2.ccr.corp.intel.com (HELO [10.209.128.127])
 ([10.209.128.127])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 06:43:08 -0800
Subject: Re: GLK board with ESSX8336 sound. Would like to get sound working on
 this system
To: Theodore Kilgore <kilgota@att.net>, alsa-devel@alsa-project.org
References: <0a98323-e429-ea9b-fb8d-6eceddd9215c.ref@att.net>
 <0a98323-e429-ea9b-fb8d-6eceddd9215c@att.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <05d677d8-21d6-eb99-ddc6-a5784fa6601e@linux.intel.com>
Date: Mon, 6 Dec 2021 08:43:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0a98323-e429-ea9b-fb8d-6eceddd9215c@att.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


> I assume that someone is already working on this but I do not know who.
> I have some experience with coding and kernel stuff (see
> drivers/media/usb/gspca). Not experienced with doing sound support.

Tracked at https://github.com/thesofproject/linux/issues/2955

The only thing missing in maintainer branches is the codec driver
updates, see the hack at https://github.com/thesofproject/linux/pull/3107

