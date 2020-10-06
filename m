Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77530C41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:29:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7917206F7
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="loYbJJ/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7917206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9ED3167F;
	Tue,  6 Oct 2020 17:28:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9ED3167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601998184;
	bh=ehsZUzIBhwN8SKJHBN+IfB7anI5w4E6xTpcD/NSRNXg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=loYbJJ/OiYaZ5Wk/+un0c7LgGRA/3cR8xQn4kiUFk4ev0nkjhwvaA8Oc9XONHb94B
	 HfTkNBaCLYaOFqIxTGYi0TtMJu+WPiSoq1N8Mnqb55Uzf67xXIVc/3gWETiWvO8ELU
	 1Sz/7z4X4OOy0i4m9rnf7wUW2g1Whkw5I1wC/geI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D784F80129;
	Tue,  6 Oct 2020 17:28:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B01E8F8012A; Tue,  6 Oct 2020 17:28:51 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3875F80127
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 17:28:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3875F80127
IronPort-SDR: 4Zg402b8sjNKaVmYRbrGjr5yWjT4CSLE88hnKYUEgqtDOnPKmrvYKkZqGIaZUa2m5YKEgkquBg
 l2uRP6YuKBBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="228672213"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="228672213"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 08:22:28 -0700
IronPort-SDR: MfHASKer46i6L/0ND0VWVs/j+3IeAajNxAlaSgPA75B186QiZ4mAzKjSAyQngoBU/VwAGP0erf
 1NdtpgNy3LuA==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="460842117"
Received: from mforsman-mobl.amr.corp.intel.com (HELO [10.212.97.68])
 ([10.212.97.68])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 08:22:26 -0700
Subject: Re: [PATCH v2 00/13] ASoC: Intel: Remove obsolete solutions and
 components
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20201006064907.16277-1-cezary.rojewski@intel.com>
 <86e6ae9814f9e9a9b558d81947adbcfb7e10019b.camel@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c41c0be2-6bab-ac6b-d3e5-e71a1ad1f6b9@linux.intel.com>
Date: Tue, 6 Oct 2020 10:20:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <86e6ae9814f9e9a9b558d81947adbcfb7e10019b.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: krzysztof.hejmowski@intel.com, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, marcin.barlik@intel.com, zwisler@google.com,
 lgirdwood@gmail.com, tiwai@suse.com, filip.proborszcz@intel.com,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 michal.wasko@intel.com, cujomalainey@chromium.org,
 andriy.shevchenko@linux.intel.com, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
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



On 10/6/20 7:22 AM, Liam Girdwood wrote:
> On Tue, 2020-10-06 at 08:48 +0200, Cezary Rojewski wrote:
>> Follow up to catpt series as mentioned in:
>>
>> [PATCH v10 00/14] ASoC: Intel: Catpt - Lynx and Wildcat point
>>
>> https://www.spinics.net/lists/alsa-devel/msg116440.html
>>
>>
>>
>> As catpt is a direct replacement to sound/soc/intel/haswell, it leaves a
>>
>> lot of code redudant. The second legacy solution - baytrail - is
>>
>> deprecated for a long time by sound/soc/intel/atom with SOF flavor
>>
>> available too.
>>
>>
>>
>> This series addresses the redudancy and removes obsolete code. Along
>>
>> with the legacy solutions, all orphaned components are removed too.
>>
>>
>>
>> As a consequence, further cleanups are unlocked: sound/soc/intel/skylake
>>
>> becomes the sole user of processing code found in
>>
>> sound/soc/intel/common. Those are not part of this series.
> 
> All
> 
> Acked-by: Liam Girdwood <liam.r.girdwood@intel.com>

Also re-adding my ack already provided for v1.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
