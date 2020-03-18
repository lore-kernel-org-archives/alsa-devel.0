Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A16C5ACD6
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:58:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BBE20767
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gPIPKtfP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L28rlUPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BBE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B62D4172F;
	Wed, 18 Mar 2020 16:57:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B62D4172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584547118;
	bh=EJ0w2Vo0Ldj8C/gZ2o+Ec++5xE+ir/UoKopkHKmE76A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gPIPKtfPIntilFfP5Z/A880eVwVQulUM7geUKG7EisM6WxJDajVdOc5wn//XZ1brQ
	 f4LbWgEqgA+pKClOW0k01ARkLEyPASAuJKWJuOxQTGyJxeaPUfr5a7LPOHMumhGQLp
	 i2nrv5IzX3BckPrIK+4/BfdbVPyhGpkNcBC5PLGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AC47F80058;
	Wed, 18 Mar 2020 16:57:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83724F80139; Wed, 18 Mar 2020 16:57:46 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD80EF80058
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 16:57:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD80EF80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="L28rlUPx"
Received: by mail-wr1-x441.google.com with SMTP id h9so2294677wrc.8
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WKs9IgnQjzOcey+yQmdz8NYqXjD7ApUhbxNTTHxXd2g=;
 b=L28rlUPx3+TpmA+orVyq6GD2PU1T/wM4SozCe9wCtz2g1xoXdbyk4OJJ+6J1n781Eb
 dr2y4h2+RXwrwe6flAUJt9VItB9pqnMYLBtpW3S7b/LguF+ylK3rEAZkIO+VNbiHxaXx
 1sYHVX/U4w2gtxkDKU99iDO6NBLnx+qr6Z/ZrAOBEpnjjDui5+Hm8OcvZvzLDOEi0FQF
 KuodKzde6MH+iNwZtXU6ClTVw6vsdU9SUW4fHe7cHCm+iKhYRS44N7QeevaWsTGz3mEc
 +leQoJ3D+tP+fe5kn0kS2re2nZ92mlwO8xXUaOcUcNNhsYRW7iS+W8K0ZgZ8CwwtbPiz
 rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WKs9IgnQjzOcey+yQmdz8NYqXjD7ApUhbxNTTHxXd2g=;
 b=lVmPbYywRbLL+7y863+uwoYgIxntk8UNxNEBD8/a2yZt2sX/VvU7znasY8hrWqIIux
 LJ0eQdcCpW2FQ4SVfUkitjZvSSWM97gB8g8HAbLXlffglNja7qpp4eqmpUP2supPKFrK
 GAHhqnyynzpDjoBKKAAg5dtbntbHe3Oia6v9U6vrkKxxkQTQ4PrCRcgt/phXXPJvB52E
 pV5CV260nwtYlyWg4VJERWbuwj9cSqgqJcLtDr0uiOb+ZLXKDhTMrkuDjKP6FKaotBVD
 bfDWEhqAmiJSPD3Pl2TDya/9ypjiS7ILs+MPolkvr5FalOsM5gloC3z+WL1/SntJRmRw
 SZRw==
X-Gm-Message-State: ANhLgQ0ACx++ewZiECLpwAGJcMTryAx+gWksxoR0AW7uSzdzRpmpOcy0
 6YOA9FXk1gZguVF0K7KTUd5KSQ==
X-Google-Smtp-Source: ADFU+vuoc90UFHCUoDzgGQkfj86K1CIpUWNNiBDamxA0TmJ2Xr8zId8gD3etAN/dAO1s4yZb9viTXA==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr5981930wrs.4.1584547060995;
 Wed, 18 Mar 2020 08:57:40 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id f9sm10057253wro.47.2020.03.18.08.57.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Mar 2020 08:57:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] ASoC: qcom: sdm845: handle soundwire stream
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
 <20200317095351.15582-2-srinivas.kandagatla@linaro.org>
 <8daeeb26-851b-8311-30f5-5d285ccbc255@linux.intel.com>
 <69c72f5a-e72e-b7b3-90cb-a7354dcb175d@linaro.org>
 <cbc6cc9b-24f5-8c2a-b60d-b5dab08c128e@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <fcf845bd-9803-ab04-d2a9-c258ddfcc972@linaro.org>
Date: Wed, 18 Mar 2020 15:57:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cbc6cc9b-24f5-8c2a-b60d-b5dab08c128e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, vkoul@kernel.org,
 lgirdwood@gmail.com
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



On 18/03/2020 15:26, Pierre-Louis Bossart wrote:
> 
> Same comment, how does the notion of cpu_dai come in the picture for a 
> SoundWire dailink?
> Would you mind listing what the components of the dailinks are?

dais that I was referring here are all codec dais from backend-dai.

Device tree entries from
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/sdm845-db845c.dts?h=next-20200318#n538


Frontend-dai:
	mm1-dai-link {
		link-name = "MultiMedia1";
		cpu {
			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
		};
	};

Backend-dai:
	slim-dai-link {
		link-name = "SLIM Playback";
		cpu {
			sound-dai = <&q6afedai SLIMBUS_0_RX>;
		};

		platform {
			sound-dai = <&q6routing>;
		};

		codec {
			sound-dai =  <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
		};
	};


--srini
