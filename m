Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDF0C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 07:46:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11B7B1EDB;
	Tue, 30 Nov 2021 08:45:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11B7B1EDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638258377;
	bh=IqA9YAhxm9uEkGH5VqOygurvNHGgNO5ZQnPWHrsQ+Ho=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBV0yQ9vFmd/n0NJMM3uDJbGYUwZ3/XPDhNjoiX0MRzeT/6WM/4TJkrfWC6TNoPxm
	 S3NREnhREbP6hkZATGc7RPyqoSHWI4yLi3b99m6dzIGMIPJTXuPvvzfPxRnuNdSJXY
	 acp+AHNdSo1VjlQYfY8zw0dSYxd8/3JT3NxSwT2A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73ADAF8028D;
	Tue, 30 Nov 2021 08:45:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76F13F80290; Tue, 30 Nov 2021 08:45:19 +0100 (CET)
Received: from celforyon.fr (ns352767.ip-91-121-87.eu [91.121.87.121])
 by alsa1.perex.cz (Postfix) with ESMTP id 21E7CF8020D
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 08:45:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21E7CF8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=eldred.fr header.i=@eldred.fr
 header.b="dm8VTKoP"
Received: from [192.168.1.65] (91-171-18-197.subs.proxad.net [91.171.18.197])
 by celforyon.fr (Postfix) with ESMTPSA id F1D531204338;
 Tue, 30 Nov 2021 08:45:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eldred.fr; s=mail;
 t=1638258306; bh=IqA9YAhxm9uEkGH5VqOygurvNHGgNO5ZQnPWHrsQ+Ho=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=dm8VTKoPHOQLHRClvrtrgbJB5CO9d1AAeGUz1S6a3gVey+1q4TLjVDJ9nTmj7xdD5
 cxtcDwqbFpD9IFsJ3wB1QP0/9NubgWm9PS7SHFg2XuUfgVous4AGVwZbD3FR0wOGCH
 njX6YQ6sY4IV4crVarFOsPwEhqaz7v3nheCTPqs8=
Message-ID: <a006b912-71e1-548a-22ef-8f315e3be281@eldred.fr>
Date: Tue, 30 Nov 2021 08:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Dual simulatenous output on single card not recognized
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <8b18294d-d082-2be4-18ba-39b4ec4b9e91@eldred.fr>
 <cdafcbb1-9eeb-6337-ee2b-d6a168996153@linux.intel.com>
From: Eldred HABERT <stuff@eldred.fr>
In-Reply-To: <cdafcbb1-9eeb-6337-ee2b-d6a168996153@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 29/11/2021 19:18, Pierre-Louis Bossart wrote:
> You may want to run 'alsa-info' and provide a link to the uploaded
> results. It's hard to comment without any information on 'hardware
> configurations like mine'.
> Thanks.
Sorry, I thought the output of `aplay -l` would be enough. The results 
are here;
http://alsa-project.org/db/?f=bc64421df5181d1ba3bdf157c40d06dd52a7224b

~ Eldred

