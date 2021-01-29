Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13553C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:20:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2671064DE9
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2671064DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F4A2169B;
	Fri, 29 Jan 2021 16:19:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F4A2169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611933625;
	bh=3MUoa2yEdF2D2xSwrDaH0Yz6dP7g442B4DxZJy2ttHU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pZQz/Lz6yFh9IDfB1qt3fAJncykB/QljWMpB4gNSHrzLan1d9vZCqIAUJ+ruD+jIs
	 292jeG0F0WseVAdqVdG60EFmZa8tfVqVb9Wkt+GYH+Y0oDr0soNUA61sOPtmzvac+m
	 SICdapBpZnTObpbGfPyMBo3Gtq43OUUmBeCf55eo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 531C7F80218;
	Fri, 29 Jan 2021 16:19:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27B5FF800E9; Fri, 29 Jan 2021 16:19:33 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCF46F800E9
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 16:19:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCF46F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="UBlm7D39"
Received: by mail-wr1-x434.google.com with SMTP id c4so6500033wru.9
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 07:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yi26sgVuJnPwVOBXkL3WBi1trj7vwBufS5KkhDWnfoQ=;
 b=UBlm7D39u1RRKKKp+tJx/yGOWG4H7UqTytnO9vgrxp1AZYpVFWnocTy68GwiyQP3uI
 wv9saER/lhiF8wKYAOfHJqN7H3DN/vWpzUp702MZ+zrESHNX3196XUswgwoPYP80Zg7f
 yzjRYYGBF1sK2Vi9xV8v7bMDyQfbrVOComVIVM7lW+Ez0WSBZa4YFJ1OTFUgSP/o0fLH
 PhxMtJd4Ey1k5miKjyaLCwEslxUtmaUCT79gRidEM9TQrT/bfS1ZsEHotpZm9cd47z1T
 3pjUG4OWKMh7iphwGupydEN9bAi29wTP2SnYsmMu6EqtIqCus9shu9hFzwXoKBo1o9HP
 kU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yi26sgVuJnPwVOBXkL3WBi1trj7vwBufS5KkhDWnfoQ=;
 b=DEpd7I7KXa8DlH0MPOuBlnlPEMNoshnfE2LnrxMs6ZJ0lNuPY9gKFuvYi+udLaStWF
 /OlETJui5w2/LNbLmSxkeoky0mmWxyzr1RF/GVrEvcX6JhU8MQPtvlrqKTP3YCHLDxyA
 s4xdmD2O1wz7P/NNcuEdksT6ZRsXHTo/kLVYwwPzWZT/SSNdwFt3h4a4TIBZh4HdDgDM
 VRQKIiCKsln4SIqfW/miVNlCaYOijDCBaVYpcVEGuAwGfEmYBsuswnUDE2rIvkgm9xA6
 qx34sD2djyVKvWm+yH7jnlJ5X/XOmpcgGl8p0dvVgQu+mSxXmBNTg/peqPGzLgKseQig
 U30w==
X-Gm-Message-State: AOAM532jjvcn9lcE3cjnCrX43SWG3w1vN6eK1sw1TCRtFMqpg4hMebjM
 muKfqQToA4h+qTdNEXRa1EXaVw==
X-Google-Smtp-Source: ABdhPJxQtauffb0+aUZXz1wsYAbiJ2aI409bRGvFWHOJMsNYZib5lfDPwKa86If85QWm/Kiwy6QaDA==
X-Received: by 2002:a5d:47a2:: with SMTP id 2mr5058784wrb.393.1611933570071;
 Fri, 29 Jan 2021 07:19:30 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id 9sm2179510wra.80.2021.01.29.07.19.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Jan 2021 07:19:29 -0800 (PST)
Subject: Re: [PATCH 2/7] ASoC: codec: lpass-rx-macro: add support for lpass rx
 macro
To: Mark Brown <broonie@kernel.org>
References: <20210128141929.26573-1-srinivas.kandagatla@linaro.org>
 <20210128141929.26573-3-srinivas.kandagatla@linaro.org>
 <20210128160718.GE4537@sirena.org.uk>
 <2e1888d9-2ea6-67df-f61f-34062bf7aeee@linaro.org>
 <20210129150843.GC4560@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <19a5ee30-f1ae-a00c-dbea-9a25d64c926a@linaro.org>
Date: Fri, 29 Jan 2021 15:19:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210129150843.GC4560@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
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



On 29/01/2021 15:08, Mark Brown wrote:
> On Fri, Jan 29, 2021 at 01:32:38PM +0000, Srinivas Kandagatla wrote:
>> On 28/01/2021 16:07, Mark Brown wrote:
> 
>>>> +		if (rx->rx_mclk_users == 0) {
>>>> +			regcache_mark_dirty(regmap);
>>>> +			regcache_sync(regmap);
> 
>>> I'd expect this to be joined up with whatever caused the register state
>>> to become invalid, this looks like it's inviting bugs.  This also seems
>>> to have only one caller...
> 
>> Few lines below we are moving the digital clock from OFF to ON which will
>> change the state of registers. There are two callers, one from DAPM RX CLK
>> widget and other from soundwire clock gate! We will potentially enter this
>> path when we are resuming from clk pause state!
> 
> You're not syncing with whatever invalidated the register state and
> caused it to need a resync, or if you think whatever invalidated the
> register state is in this function you're resyncing before taking any
> other action which means there's some kind of ordering issue.

I see your point! it should be synced after the clock is switched from 
OFF to ON!

Will fix this in next spin!

--srini
> 
