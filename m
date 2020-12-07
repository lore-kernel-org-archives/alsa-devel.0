Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE8C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 23:56:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634B623A04
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 23:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634B623A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE5F916C0;
	Tue,  8 Dec 2020 00:55:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE5F916C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607385393;
	bh=8qBb50HGLzvNfG5jpY/REWFVy5xnyAqUOA8Mlu0N+e0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QDkPoEplFPJkq5emK3ItrS6CmAW4k4XdAOT9yp1dfNAIbQ0SQv3ovCHARg2fFHb/S
	 XhMwtlMa6ojdWw/z+PdSOJusSTmipusBrO2HUwHr53rWI/ajZn2xQ3gH5lTDVCMi1n
	 zANbln4asLnsKaWyu71XAp9UU43SAk5QjWTf6ot0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C123F8021D;
	Tue,  8 Dec 2020 00:54:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D856BF8010A; Tue,  8 Dec 2020 00:54:52 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C1E2F8010A
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 00:54:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C1E2F8010A
IronPort-SDR: OJzaoeHIzZ01Nb3gcsJMIa1WZr4XZXwVG4OzWTnG/xSUdqMmV4PDKLAxPSLs2t+NICILV2bCAe
 1yachUryPwwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="171230469"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; d="scan'208";a="171230469"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2020 15:54:40 -0800
IronPort-SDR: I4fDSwli1pHW0IkRLT14fPitXakEreFyvn2qmV/IbyE/va9aI9zDTWyMan9f60MwVlM5lkohmz
 QfXO1WKUnEDA==
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; d="scan'208";a="483410888"
Received: from cegeorge-mobl.amr.corp.intel.com (HELO [10.212.61.7])
 ([10.212.61.7])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2020 15:54:39 -0800
Subject: Re: [PATCH 0/2] ASoC: Intel: cht_bsw_nau8824: 2 fixes for usage with
 sof-audio-acpi
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
References: <20201206122436.13553-1-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a9d5b273-b457-f293-47f4-25f818ffe228@linux.intel.com>
Date: Mon, 7 Dec 2020 09:14:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201206122436.13553-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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



On 12/6/20 6:24 AM, Hans de Goede wrote:
> Hi All,
> 
> Here are 2 simple fixes which are necessary to make the
> cht_bsw_nau8824 machine driver work together with the
> sof-audio-acpi driver.
> 
> Note that atm the sof topology files are missing a .tplg
> file for this setup. Simply copying over the standard
> sof-byte-codec.tplg file does the trick, but then some
> mixer setting changes are necessary to fix the right
> speaker/headphones channel not working; and those mixer
> settings break the right channel when used with the
> sst-acpi driver.
> 
> I've been trying to fix this at the tplg level so that
> we do not need to change the mixer settings, but no luck
> sofar. I'll post a RFC with the topology changes which
> I have and we can discuss this further there.
> 
> These 2 simple fixes are necessary to make the sof-audio-acpi
> driver work regardless of the topology issue.

Thanks for your work Hans, much appreciated. Both changes are valid and 
were missed.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


