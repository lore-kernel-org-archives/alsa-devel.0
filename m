Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5171BC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:07:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BB52073E
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aU96XUAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BB52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CE5E11C;
	Tue,  7 Jul 2020 18:06:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CE5E11C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594138059;
	bh=eYEXThQnYpvuQhL+0vZzGcAo+NYHllmkOiKTwlZJASo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aU96XUAa/AT5wC2jKpatBfgo3FYQkIZjjukOMWVj23M3JrEk85Qphi1QNGvcGdP14
	 uQpVdMpIKmKNzlq0LseSP4XnMAXNk2QlJVffYEZgDZbsLu6zGQ0RXpImIsuYrrDEqU
	 dbSO7PVNKRk2dpNwQCRxpwwMK/a/oX6jDdy5VGtE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E298EF801F9;
	Tue,  7 Jul 2020 18:06:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B937F80257; Tue,  7 Jul 2020 18:06:48 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CF7DF801F9
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 18:06:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CF7DF801F9
IronPort-SDR: 6UKa0FTNAc2UP1lf9GWmZlJD4Qv7C2oLaewzzs0hld4FOKpDcw0E/xxFEOcREBeYoa9ROag8xz
 m4tdLnoLKipg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="149148674"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="149148674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 09:06:34 -0700
IronPort-SDR: Liz4To01xgpaSfDU5y1SXo9AcKVsrE/HRKpRQqCHs2F3yXvMjUSSmq6YAnVNXzryJxIg5JcFoZ
 Ii91nupNwusQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="305713017"
Received: from stortizs-mobl1.amr.corp.intel.com (HELO [10.254.109.228])
 ([10.254.109.228])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 09:06:31 -0700
Subject: Re: [RFC PATCH 10/23] ALSA: usb/line6: remove 'defined but not used'
 warning
To: Takashi Iwai <tiwai@suse.de>
References: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
 <20200702193604.169059-11-pierre-louis.bossart@linux.intel.com>
 <s5hblkreiy5.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8dfae7e1-9106-cd00-3fa2-401e941095e2@linux.intel.com>
Date: Tue, 7 Jul 2020 10:49:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <s5hblkreiy5.wl-tiwai@suse.de>
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




>> -static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
>> -static const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
>> +static __maybe_unused const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
>> +static __maybe_unused const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
> 
> IMO, this can be clearer to make them define.
> The static const doesn't look like a right usage in such a case in
> anyway...

Right, and the capital letters do hint at a define indeed. Will resend, 
thanks Takashi for the review.
