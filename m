Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37611C4321E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Nov 2022 17:38:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4132816DD;
	Wed, 30 Nov 2022 18:37:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4132816DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669829929;
	bh=6O7yRoVaFcwnAPj+yQOMSr/okyAZQB7Tu3RqMhkNqOE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S0q8Y5z9osmHVRPDRsSvxJIraevqiBZJaFXjLTlprjMBs4JQuZ9b/wSMdnevIfnwh
	 n35NPWrUTzguQe9A6G0gN4vA1qAZAsDwTAnndS7vg2fGhJLnYLpIn8vEZKaIv3IVtc
	 NMH1U+nY7UVZ5DN+dww/0bEWCFa8p8JQnblLJg2U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8102F8016B;
	Wed, 30 Nov 2022 18:37:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE46CF8023A; Wed, 30 Nov 2022 18:37:56 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2B3FF80118
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 18:37:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2B3FF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="YJC0tOFU"
Received: by mail-io1-xd29.google.com with SMTP id g26so12142388iob.11
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+AgLyglTy78H8l7Z4AxRK05yTQEkaLjb7Bn22b4HTzc=;
 b=YJC0tOFUZMS8H4ltGhIVqvYsynpZFOxg8+jRx+MReUb+4okBBBg/gtFViYgLUiF7Hf
 NhTOE7Ux7q3q9KtdHQxpVcrilQeP8UO1wdZES8/yobRI61/rw03x4m8AMwHfnh7dGia+
 02xQmbGLIjGH1368W5I0zwQAWo4VZoWxNZTvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AgLyglTy78H8l7Z4AxRK05yTQEkaLjb7Bn22b4HTzc=;
 b=4PjLbKLzH1glAHvqcKITa0UwtKzzE7T9gcXmyscl6qQCR8WLezo6nGI9XxYJsop8h1
 4d6kcO9wGIg0UObjwbdfFbAJfs/I7TcoJTpXHcCm//7c8Ri2zzMv8TpaGlfQhGPJzxbT
 DT2h/9JLdbYfxOkQAGrhX4vqvLOgu4E3t5jEPZuyl+GEC9wFagDSB2F4ji/JZy1vZNU6
 E5H0OJkpSSIKIjJHV6eQrTQE7HQ8EyhQ7Q6xl9KkIg9XvQB8wHliIjTObnVaxPDiv4fv
 tfVPEMh64k50TUBqKJyT+XvAsvJBaiNGSxOl+cC2YsnhwdYUSrqRyWSeU3bQVfe/Ixbq
 W2tw==
X-Gm-Message-State: ANoB5plq3LZXBQOfwSzt6clY+zGg71oQeex0dGvnIWbTts3V3Qo9QQ05
 MxnCCG0dDCuNQ/GXn9yZHpcpFA==
X-Google-Smtp-Source: AA0mqf7HN4pq8PK1PkoJZAkmkGjrYX6lovaSencpUD57mriJRYzI9s5ni+O5RvyuyC7IRJWDA8blXA==
X-Received: by 2002:a05:6638:2408:b0:389:5377:d86f with SMTP id
 z8-20020a056638240800b003895377d86fmr14939614jat.142.1669829871458; 
 Wed, 30 Nov 2022 09:37:51 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
 by smtp.gmail.com with UTF8SMTPSA id
 j4-20020a02a684000000b00373aa370dc4sm756712jam.137.2022.11.30.09.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Nov 2022 09:37:50 -0800 (PST)
Date: Wed, 30 Nov 2022 17:37:50 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4eU7ra4w3Fm+wLM@google.com>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4eN4utrDnEnKu/8@google.com> <Y4eP2yFKsmxzyX/4@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4eP2yFKsmxzyX/4@sirena.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, agross@kernel.org,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, quic_plai@quicinc.com,
 swboyd@chromium.org, judyhsiao@chromium.org, linux-kernel@vger.kernel.org,
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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

On Wed, Nov 30, 2022 at 05:16:11PM +0000, Mark Brown wrote:
> On Wed, Nov 30, 2022 at 05:07:46PM +0000, Matthias Kaehlcke wrote:
> > On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:
> 
> > > Add __maybe_unused tag for system PM ops suspend and resume.
> > > This is required to fix allmodconfig compilation issue.
> > > Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
> 
> > This is incorrect, it should be '2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add
> > system suspend/resume PM ops")'. I see you fixed that in v2, but this patch
> > has already been applied ...
> 
> with the fixes tag already updated as I was applying it.

The tag of the applied patch is incorrect too, which is actually what I noticed:

Fixes: a3a96e93cc88 ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")

This patch is for sc7180, so it should be:

Fixes: 2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops")

> > Mark, I appreciate you being responsive and picking patches quickly, it might
> > help though to leave 'external' reviewers at least some time to provide their
> > feedback :)
> 
> There's a balance with hanging on for utterly trivial patches to get
> reviewed, especially in areas where reviews aren't relaible or
> consistent.

I understand it's a balance and I certainly can't claim to be a regular reviewer
of audio patches.
