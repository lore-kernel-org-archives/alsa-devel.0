Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D821DC4741F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:33:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538D520728
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FbK1nxbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538D520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 315041678;
	Thu,  5 Nov 2020 20:32:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 315041678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604604822;
	bh=Ow9I+UnHFnxmFnMUUPdRGduQmJoQtQFB724PWTM5aUk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FbK1nxbBE9m2H4mlkmL0Q6F9facasdGZQsQyphj4LbbG5uGgWAWIHWgAjjwTXkpxj
	 HJ0Df1V9o7rqE4okvTdwrTS1Lk0AbNXRP8gBWCiyYcLAFNnQFgpg8OoUcxAFi6SrAH
	 ts7BgQfFv0MJFoydwbB+HR/2OBe+KfFn12KhZ+zo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEBD8F80162;
	Thu,  5 Nov 2020 20:32:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A00BF80171; Thu,  5 Nov 2020 20:32:50 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3CF1F800EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 20:32:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3CF1F800EC
IronPort-SDR: NfqZK2iX4DDk5IV/Z3lISp3b/iedqpI5BUKSEya/mTRwXybaYJSfA/+W1DVV7iNNTcnVtT6F99
 11qVLsz9OyZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="231075429"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; d="scan'208";a="231075429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 11:32:42 -0800
IronPort-SDR: X+y1wice22ze5u8UH/r7/Lhh3EMQSy98/maUv2UJizrrh8Ql/VDQInL/x1alfiquMX9XlC00Zs
 a0fb1L7MzXxA==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; d="scan'208";a="471774404"
Received: from umedepal-mobl2.amr.corp.intel.com (HELO [10.254.6.114])
 ([10.254.6.114])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 11:32:41 -0800
Subject: Re: [PATCH v3 01/10] Add auxiliary bus support
To: "Ertman, David M" <david.m.ertman@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>
References: <20201023003338.1285642-1-david.m.ertman@intel.com>
 <20201023003338.1285642-2-david.m.ertman@intel.com>
 <CAPcyv4i9s=CsO5VJOhPnS77K=bD0LTQ8TUAbhLd+0OmyU8YQ3g@mail.gmail.com>
 <DM6PR11MB284191BAA817540E52E4E2C4DDEE0@DM6PR11MB2841.namprd11.prod.outlook.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f37a2b37-2fda-948d-1b8f-617395d43a08@linux.intel.com>
Date: Thu, 5 Nov 2020 13:32:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB284191BAA817540E52E4E2C4DDEE0@DM6PR11MB2841.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Parav Pandit <parav@mellanox.com>, Takashi Iwai <tiwai@suse.de>,
 Netdev <netdev@vger.kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fred Oh <fred.oh@linux.intel.com>, linux-rdma <linux-rdma@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>, Mark Brown <broonie@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, "Saleem, Shiraz" <shiraz.saleem@intel.com>,
 David Miller <davem@davemloft.net>, Leon Romanovsky <leonro@nvidia.com>,
 "Patil, Kiran" <kiran.patil@intel.com>
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


>>> +module_init(auxiliary_bus_init);
>>> +module_exit(auxiliary_bus_exit);
>>> +
>>> +MODULE_LICENSE("GPL");
>>
>> Per above SPDX is v2 only, so...
>>
>> MODULE_LICENSE("GPL v2");
>>
> 
> added v2.

"GPL v2" is the same as "GPL" here, it does not have any additional meaning.

https://www.kernel.org/doc/html/latest/process/license-rules.html

“GPL”	Module is licensed under GPL version 2. This does not express any 
distinction between GPL-2.0-only or GPL-2.0-or-later. The exact license 
information can only be determined via the license information in the 
corresponding source files.

“GPL v2”	Same as “GPL”. It exists for historic reasons.

