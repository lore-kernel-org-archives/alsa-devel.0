Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9515CC47089
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Nov 2022 17:08:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF05716F1;
	Wed, 30 Nov 2022 18:07:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF05716F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669828127;
	bh=hwbeRXDCPnkzZaLAZJzPCmUQXCGZT3CgoSXNyHRIbL4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BbMuHiI2nv1gpdrNcNvCEMj7z4CWkJ912zdzFmJ5Bdz+n2Tf9rbDoutFz9G0LgPOf
	 74nwwxVmK5yvmNbyoHKeeN4jBjgb9oxgZhxQlQzjKlwIzNFoODIJm9LneI7sZtbfDn
	 4vJWzq2w3w+bfYoAT/nhL+WuSMbZMZWVDEr7GWbc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FE14F8016B;
	Wed, 30 Nov 2022 18:07:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8195FF8023A; Wed, 30 Nov 2022 18:07:55 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09AFCF800B6
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 18:07:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09AFCF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="UTV414O5"
Received: by mail-il1-x134.google.com with SMTP id x16so8381503ilm.5
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 09:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hwbeRXDCPnkzZaLAZJzPCmUQXCGZT3CgoSXNyHRIbL4=;
 b=UTV414O5U/PBfbN3sot40dFRdr29nsiDpH7mW9CHhEHTz8HwPQZW0ntrlp03S2Z5Qd
 1lk+QJLhVEOQ7huOtOn8tc8jPC7n4Lakg01Cums/GaXHAJMooFd0fElMdwoRORoqpE+y
 VkP609mtJ+dEoFK7lXPFDJ1qYJam84wIP5Z3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwbeRXDCPnkzZaLAZJzPCmUQXCGZT3CgoSXNyHRIbL4=;
 b=z+noN4NBrSRswnxZQHn9NQwE1aJ+BITwtlCTsWb677c9YzQR//bsjtNZibJghF+GV0
 NRpWq/JXscCUmMpwBqUJ3YT5CQE4KPplkAqV60YpH3M0ApzX56dIhBX7QaQqkFbTN92Y
 Pd9XL/xAMWoyRxLNPiiF8KHmxvJ8j0ri0U3SjmZXgRYBaZm4Hh+3ybQGu46FqRFbTCCZ
 MvNtPppDVcd6dbSLZkaWmTzWH/t4GCpyWlLqpxhz56t5dTnBKEoEWkzHf/QqKU/cgetK
 zE405s1h//C+jtJkmhA76m0mgvdkIJ6U+TgrxYF23k01EOqfQTv0e6PA0hbk8yTHJrqU
 QPaA==
X-Gm-Message-State: ANoB5pncZ3JEaGKCos+MZo0Q8tpmn8SSdseE3oWlRLuvbdATOfmmJT9Z
 mpkLucjBuoROFngO8xoWnRYupQ==
X-Google-Smtp-Source: AA0mqf7dRZ5ikRklhhLf4zCW66fwPUUtbqqE8HBiPfnHONAIRVgwN8feEkWTFgnbGzVdaW1H68FZGg==
X-Received: by 2002:a92:dd82:0:b0:2f6:52ad:27e2 with SMTP id
 g2-20020a92dd82000000b002f652ad27e2mr19252287iln.285.1669828066772; 
 Wed, 30 Nov 2022 09:07:46 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
 by smtp.gmail.com with UTF8SMTPSA id
 j193-20020a0263ca000000b003717c1df569sm736403jac.165.2022.11.30.09.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Nov 2022 09:07:46 -0800 (PST)
Date: Wed, 30 Nov 2022 17:07:46 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4eN4utrDnEnKu/8@google.com>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, agross@kernel.org,
 srinivas.kandagatla@linaro.org, broonie@kernel.org, bgoswami@quicinc.com,
 quic_plai@quicinc.com, swboyd@chromium.org, judyhsiao@chromium.org,
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

On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:
> Add __maybe_unused tag for system PM ops suspend and resume.
> This is required to fix allmodconfig compilation issue.
> Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")

This is incorrect, it should be '2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add
system suspend/resume PM ops")'. I see you fixed that in v2, but this patch
has already been applied ...

Srinivasa, it seems a similar patch is needed for commit c3bf7699747c ("ASoC:
qcom: lpass-sc7280: Add system suspend/resume PM ops"). For that you could use
SYSTEM_SLEEP_PM_OPS() instead of the maybe_unused tags as suggested by Nathan.

Mark, I appreciate you being responsive and picking patches quickly, it might
help though to leave 'external' reviewers at least some time to provide their
feedback :)
