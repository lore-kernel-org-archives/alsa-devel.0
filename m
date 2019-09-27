Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE1C4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:11:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554352075D
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jzasyTvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554352075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB15914E;
	Fri, 27 Sep 2019 17:10:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB15914E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569597084;
	bh=swx4EKtLQgsdgOgdFru0SxSZhYW0wRz1gV5FpCykdOE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jzasyTvulybx8Y2EAtfb3qEkuJIelpkxgI5EHGo43bhoF0jThdlz8E7JzEA5gmckh
	 Bf7L/JV6+i8rF+o+OmLBJu8lP/3s6Rk7RQoYLX77BtN2BqCmT0PDNjXyBh9KXOyacQ
	 FpsiF0f9SuXBbMh0mujrFWKy8x8O/EYuSsDR3AuM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42865F8044C;
	Fri, 27 Sep 2019 17:10:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D50FF8049A; Fri, 27 Sep 2019 17:10:32 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A710F80140
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 17:10:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A710F80140
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Sep 2019 08:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; d="scan'208";a="219808427"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.6.245])
 ([10.252.6.245])
 by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2019 08:10:20 -0700
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Navid Emamdoost <navid.emamdoost@gmail.com>
References: <20190925161922.22479-1-navid.emamdoost@gmail.com>
 <13f4bd40-dbaa-e24e-edca-4b4acff9d9c5@linux.intel.com>
 <20190927025526.GD22969@cs-dulles.cs.umn.edu>
 <dc68e0dc-9a8e-cc52-c560-3e86c783dbb3@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <6966df25-e82c-1abe-6a0f-ff497dcda23b@intel.com>
Date: Fri, 27 Sep 2019 17:10:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dc68e0dc-9a8e-cc52-c560-3e86c783dbb3@linux.intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, smccaman@umn.edu,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
 emamd001@umn.edu
Subject: Re: [alsa-devel] [PATCH v2] ASoC: Intel: Skylake: prevent memory
 leak in snd_skl_parse_uuids
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

On 2019-09-27 15:14, Pierre-Louis Bossart wrote:
> On 9/26/19 9:55 PM, Navid Emamdoost wrote:
>> On Wed, Sep 25, 2019 at 12:05:28PM -0500, Pierre-Louis Bossart wrote:
>>> On 9/25/19 11:19 AM, Navid Emamdoost wrote:
>>>> In snd_skl_parse_uuids if allocation for module->instance_id fails, the
>>>> allocated memory for module shoulde be released. I changes the
>>>> allocation for module to use devm_kzalloc to be resource_managed
>>>> allocation and avoid the release in error path.
>>>
>>> if you use devm_, don't you need to fix the error path as well then, 
>>> I see a
>>> kfree(uuid) in skl_freeup_uuid_list().
>>>
>>> I am not very familiar with this code but the error seems to be that the
>>> list_add_tail() is called after the module->instance_id is allocated, so
>>> there is a risk that the module allocated earlier is not freed (since 
>>> it's
>>> not yet added to the list). Freeing the module as done in patch 1 works,
>>> using devm_ without fixing the error path does not seem correct to me.
>>>

Good catch, Pierre.

>> Thanks for the feedback, then it's your call if you can accept patch 1 as
>> fix.
> 
> Cezary, it's really your call.
> 

Actually, not the best person to ask about "objective decisions" here as 
my vision is clouded by changes done internally. This code no longer 
exists in our internal repo. It's better for host to send MODULE_INFO 
request rather than understanding firmware binary structure and parse it 
directly.

I'm fine with solution #1 as I guess asking to wait for refactor is not 
an option. Code deployment is delayed due to range of administrative 
decisions, some of which should be uncovered on alsa-devel soon enough.

Czarek
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
