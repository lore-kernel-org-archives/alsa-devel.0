Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB22C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:40:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E5C2311B
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E5USJGmp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="DAhkOvAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E5C2311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C0DF166B;
	Thu,  6 Aug 2020 18:39:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C0DF166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596732014;
	bh=zhayyUasNitKEI6NWxV47Xj0mB8A8GhLbHNYdde0JfI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E5USJGmpCqeaUQ08zQ5G/F+b0f0UUOkp9NpE/MWjMtc0K3wVushjsyxUV38fV+tfn
	 3qYfVS0lcP+ovnn3pqC+HNJ0j/QjyRpFfZO+5+nsYLG6ax7rqsHBJPX/6TUTtQmddt
	 miK8y0r/XQtr2FERHoRPBD2hsNO/O+5luvF7JFic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCFFCF802D2;
	Thu,  6 Aug 2020 18:36:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DFE7AF80218; Wed,  5 Aug 2020 15:55:45 +0200 (CEST)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79727F80112
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 15:55:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79727F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org
 header.b="DAhkOvAY"
Received: by mail-il1-x144.google.com with SMTP id c16so25596844ils.8
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2020 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieee.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T0iHC5DzypW6poy3NDVtNkEOvm1za2UqY6n/ov5xw0A=;
 b=DAhkOvAYaZ9UtoECfWC2gAqYzdQdZu4/OTZhHotTaCMraihBeTETAb2o+tdVB+R9c/
 fgruEjKoM8VG+YdsLo4GUZF8VaCggzTi5h3uToTV2f2Sv1hwOpZ5HvtTKuXa2Y1A6q3O
 zX5fNDo98uB0Sok2zX9/YQGJMJ6y+B1u0vCnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T0iHC5DzypW6poy3NDVtNkEOvm1za2UqY6n/ov5xw0A=;
 b=rwecJsKU+ahoWBs8NuHVOI8uOKkRC3kZus/BljbjESLaKQ3CEeGSmRDvZl5pWWrR9t
 ZClH+uNtILv78bE+P/x6VFN+Zn6lJ3SdtPMn8sqkBa0vnzLQ+c1tu/PFi10Yq9usYTB3
 3qQWFIOP5YAA7e2V558aI//UDv/1GARvSmXu9a8xvbycbwxxR8zim2iLMmAqoI/mrBDp
 ATTkrZUOrDIoR9FE5TEWWv/UV7ouw5fOKnzzXxUkKto9xDZFOQyWfhjyUf4BTOrfvF7q
 IzjbJ/GOHnogKWIwsYNiN+4v4ryFfOGc+Y112P9704MOqv6I00stCca4U2p9ofWL+hyZ
 m9NQ==
X-Gm-Message-State: AOAM532EjP0+OVrg8DNEGrCfR7lj+FdF5iVVGzctcnPf0dXLSRHmqjmC
 NedjD+DJFD648AOoxnFxMeMdIQ==
X-Google-Smtp-Source: ABdhPJygRlU9l3OctXlmAVj+p1MKYQ+VT9ZvU9QPRbxWDqUzC6q+bEae4dy82QDhDGDE28iGtnJLqA==
X-Received: by 2002:a92:c14d:: with SMTP id b13mr3548606ilh.269.1596635733090; 
 Wed, 05 Aug 2020 06:55:33 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net.
 [73.185.129.58])
 by smtp.googlemail.com with ESMTPSA id c2sm1073796iow.6.2020.08.05.06.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 06:55:32 -0700 (PDT)
Subject: Re: [PATCH] soc: qmi: allow user to set handle wq to hiprio
To: =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
References: <ADUAnwD8DVByMMSsrG-r3Kri.3.1596374087585.Hmail.wenhu.wang@vivo.com>
From: Alex Elder <elder@ieee.org>
Message-ID: <5c6123f2-1a65-8615-9d5d-3bb1d25818b2@ieee.org>
Date: Wed, 5 Aug 2020 08:55:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ADUAnwD8DVByMMSsrG-r3Kri.3.1596374087585.Hmail.wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2020 18:36:48 +0200
Cc: ohad@wizery.com, linux-wireless@vger.kernel.org,
 alsa-devel@alsa-project.org, elder@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ath10k@lists.infradead.org, ath11k@lists.infradead.org, agross@kernel.org,
 srinivas.kandagatla@linaro.org, sibis@codeaurora.org, netdev@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net, kvalo@codeaurora.org
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

On 8/2/20 8:14 AM, 王文虎 wrote:
> 
>>> Currently the qmi_handle is initialized single threaded and strictly
>>> ordered with the active set to 1. This is pretty simple and safe but
>>> sometimes ineffency. So it is better to allow user to decide whether
>>> a high priority workqueue should be used.
>>
>> Can you please describe a scenario where this is needed/desired and
>> perhaps also comment on why this is not always desired?
>>
> 
> Well, one scenario is that when the AP wants to check the status of the
> subsystems and the whole QMI data path. It first sends out an indication
> which asks the subsystems to report their status. After the subsystems send
> responses to the AP, the responses then are queued on the workqueue of
> the QMI handler. Actually the AP is configured to do the check in a specific
> interval regularly. And it check the report counts within a specific delay after
> it sends out the related indication. When the AP has been under a heavy
> load for long, the reports are queue their without CPU resource to update
> the report counts within the specific delay. As a result, the thread that checks
> the report counts takes it misleadingly that the QMI data path or the subsystems
> are crashed.
> 
> The patch can really resolve the problem mentioned abolve.

Is it your intention to submit code that actually does what you describe
above?  If so, then (as David said) you should propose this change at
the time it will be needed--which is at the time you send that new
code out for review.

Even in that case, I don't believe using a high priority workqueue
would guarantee the improved behavior you think this would provide.

In case it wasn't clear already, this change won't be accepted
at this time (despite your explanation above).

						-Alex

> 
> For narmal situations, it is enough to just use normal priority QMI workqueue.
> 
>> Regards,
>> Bjorn
>>
>>>
>>> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
>>> ---
>>>  drivers/net/ipa/ipa_qmi.c             | 4 ++--
>>>  drivers/net/wireless/ath/ath10k/qmi.c | 2 +-
>>>  drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
>>>  drivers/remoteproc/qcom_sysmon.c      | 2 +-
>>>  drivers/slimbus/qcom-ngd-ctrl.c       | 4 ++--
>>>  drivers/soc/qcom/pdr_interface.c      | 4 ++--
>>>  drivers/soc/qcom/qmi_interface.c      | 9 +++++++--
>>>  include/linux/soc/qcom/qmi.h          | 3 ++-
>>>  samples/qmi/qmi_sample_client.c       | 4 ++--
>>>  9 files changed, 20 insertions(+), 14 deletions(-)
> 

