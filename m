Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B17C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 13:35:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6C96109E
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 13:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB6C96109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 714BB1878;
	Fri, 13 Aug 2021 15:34:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 714BB1878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628861720;
	bh=BSeOYGBRim4CT2pwkRlFH6kIKLI1+rzKPEC8wmtFGec=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PQhg70xHVU7MVmnA7rKsAVHZ1g7vq8hqyR26QUO9eQaDunppSXWmK7RGg4fZs7YL+
	 D+7A41+xZK2LLBFqJCD2MkiXaQ2Fcjet0zMMzVk4zr7UBWZTY8TIGQKPGFZM+lP4WB
	 +Zw4f9XCa6ko0QWH7pTaDUW8KD9ckc9jijehLmbg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05709F8020D;
	Fri, 13 Aug 2021 15:34:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 096D8F802D2; Fri, 13 Aug 2021 15:34:25 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EE59F800E5
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 15:34:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EE59F800E5
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215551881"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="215551881"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 06:34:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="440366904"
Received: from mchatter-mobl1.amr.corp.intel.com (HELO [10.212.54.162])
 ([10.212.54.162])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 06:34:09 -0700
Subject: Re: [PATCH v2 0/8] ASoC: Intel: boards: use software node API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210812224443.170144-1-pierre-louis.bossart@linux.intel.com>
 <YRZJ3LxkwUkX++Jp@smile.fi.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <490ac475-9770-6251-422f-1d2db138f82c@linux.intel.com>
Date: Fri, 13 Aug 2021 08:33:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRZJ3LxkwUkX++Jp@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org, broonie@kernel.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
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



On 8/13/21 5:30 AM, Andy Shevchenko wrote:
> On Thu, Aug 12, 2021 at 05:44:35PM -0500, Pierre-Louis Bossart wrote:
>> This is an update on an earlier contribution from Heikki Krogerus
>>
>> The function device_add_properties() is going to be removed.
>> Replacing it with software node API equivalents.
>>
>> Thanks for Hans de Goede and Andy Shevchenko for their comments,
>> suggestions and Reviewed-by tags on GitHub. The review thread can be
>> found at https://github.com/thesofproject/linux/pull/3041)
> 
> For all non-commented
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy for the review, I'll resend a v3 later today with your
suggested changes and your Reviewed-by tag added.
>> v2 changes: feedback from Andy and Hans
>> Better error handling
>> Codec reference is kept until the .remove callback
>> Remove bus search to find device
>>
>> v1 changes from Heikki's patches:
>> Avoid the use of devm_ routines for Baytrail machine drivers.
>>
>> Heikki Krogerus (1):
>>   ASoC: Intel: boards: use software node API in Atom boards
>>
>> Pierre-Louis Bossart (7):
>>   ASoC: Intel: boards: harden codec property handling
>>   ASoC: Intel: boards: handle errors with acpi_dev_get_first_match_dev()
>>   ASoC: Intel: boards: get codec device with ACPI instead of bus search
>>   ASoC: Intel: sof_sdw: pass card information to init/exit functions
>>   ASoC: Intel: sof_sdw_rt711*: keep codec device reference until remove
>>   ASoC: Intel: use software node API in SoundWire machines
>>   ASoC: Intel: remove device_properties for Atom boards
>>
>>  sound/soc/intel/boards/bytcht_es8316.c      | 31 ++++++++--
>>  sound/soc/intel/boards/bytcr_rt5640.c       | 57 ++++++++++++++-----
>>  sound/soc/intel/boards/bytcr_rt5651.c       | 63 ++++++++++++++-------
>>  sound/soc/intel/boards/sof_sdw.c            | 20 ++++---
>>  sound/soc/intel/boards/sof_sdw_common.h     | 37 +++++++-----
>>  sound/soc/intel/boards/sof_sdw_max98373.c   |  3 +-
>>  sound/soc/intel/boards/sof_sdw_rt1308.c     |  3 +-
>>  sound/soc/intel/boards/sof_sdw_rt1316.c     |  3 +-
>>  sound/soc/intel/boards/sof_sdw_rt5682.c     |  3 +-
>>  sound/soc/intel/boards/sof_sdw_rt700.c      |  3 +-
>>  sound/soc/intel/boards/sof_sdw_rt711.c      | 51 +++++++++--------
>>  sound/soc/intel/boards/sof_sdw_rt711_sdca.c | 52 +++++++++--------
>>  sound/soc/intel/boards/sof_sdw_rt715.c      |  3 +-
>>  sound/soc/intel/boards/sof_sdw_rt715_sdca.c |  3 +-
>>  14 files changed, 221 insertions(+), 111 deletions(-)
>>
>> -- 
>> 2.25.1
>>
> 
