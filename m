Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18406C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 01:21:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78E28A915;
	Wed, 19 Oct 2022 03:20:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78E28A915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666142485;
	bh=q2ct2IaP52qS/4bb8sgrxvkMuYncIYxIrW6dY2N/NU8=;
	h=References:From:To:Subject:Date:In-reply-to:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dBfI1Cnns91p6ilWmmyp+qWzP/BaVrCBpv7P1lBmvzkFTImQuc8XhtrAYcOyXDvSC
	 w+gNe9AtbawKJRXc2yZc4zf4kXJOD9VpG6uDZMTFwKWrKM6JIrzm0K9fn6koFS3TDT
	 aQs0liTWPY85lXOvq/+1I2ea0jMfuLVvKDg/Oivc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AF9EF800E5;
	Wed, 19 Oct 2022 03:20:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB52EF800AA; Wed, 19 Oct 2022 03:20:33 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 957B2F800AA
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 03:20:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 957B2F800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="COSNVYEd"
Received: by mail-ej1-x62c.google.com with SMTP id ot12so36557300ejb.1
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2022 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :references:from:to:cc:subject:date:message-id:reply-to;
 bh=q2ct2IaP52qS/4bb8sgrxvkMuYncIYxIrW6dY2N/NU8=;
 b=COSNVYEdJI7+oIGyrQr8374OeogvM3MlIXQ/D9YhIBvUCGN0j1r5kcnG2HKdo4GJc/
 dvBmI6GiDKeaSLdOlRYnVf0od0TkzqHLkQgmrtojq1g/Yak6R8/EoVd3qVUcC8uLk/U4
 1+31iZOwApg5XnfjwRPRWKAwzeskGOTS7sMg8c2XZerGj6m4Tx/ZWYaGCUFg2MGHyv1X
 OlgXD7rik84xSqn8en59Des+GIC+HMs1Q2m5TEkLe8CZSsvNHcCMAlzzaoyc09CiTscH
 kgaRbp2tubvSF4gny03h9NXVgeoxAViHxUIhqnSfk9yqNiGPEp4m9jhVU75ykUx+mmy4
 AHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :references:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q2ct2IaP52qS/4bb8sgrxvkMuYncIYxIrW6dY2N/NU8=;
 b=alSEFjZyW1yb/244mWpNQmAE7slS2FrQ+WBArLmv5yMuYPbkTZU6W1KVHqWtgoq7zf
 l0KUJNaYh3RyeEAwLmC5woGkYFAzpvy/9+8mfUQD2e9V8yADXWet6FtRWLTw7iIn9K1y
 /42DWMozt9lxoktTXeOYx4jjYtJthI0uIY+WaBDi7UuhZfCZuRZvmTwxgIa526MP4T0M
 Zj3vJGxksAtSVJXRHO3wBwFeC7b8W3SJiOcZLUL5aHmhTg2bICCydDGSjhQzTj7ACmKN
 /CbG3IjrobblOAcJtf/j20jI8QotgR/Ur8s2j6b36rFUIARCODauHk9kUZmlodeY5bUz
 Y/9A==
X-Gm-Message-State: ACrzQf3B5fFVGXuF4CIrTOC+0Y9SEMczxpld/KVh6V8ZBXPrurAw04+e
 kEpuSgnNhhfPkERHquMwBcE=
X-Google-Smtp-Source: AMsMyM6BdNA8+z4lXSFUoebKOIRosFmoq2otzD2jWdhCDTw3eRMtcKebqA9hz9FR4VjlBDVDBkU12Q==
X-Received: by 2002:a17:907:2e0d:b0:78e:1d21:8001 with SMTP id
 ig13-20020a1709072e0d00b0078e1d218001mr4602332ejc.246.1666142425222; 
 Tue, 18 Oct 2022 18:20:25 -0700 (PDT)
Received: from localhost (188.28.2.210.threembb.co.uk. [188.28.2.210])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a170906370900b0073022b796a7sm8286838ejc.93.2022.10.18.18.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 18:20:23 -0700 (PDT)
References: <20221018230409.610538-1-aidanmacdonald.0x0@gmail.com>
 <87h700u2sr.wl-kuninori.morimoto.gx@renesas.com>
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v1] ASoC: simple-card: Fix up checks for HW param fixups
Date: Wed, 19 Oct 2022 02:19:37 +0100
In-reply-to: <87h700u2sr.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <xqJhkVSkypEjXLHM2nTiM6gHnxhl1J2B@localhost>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 spujar@nvidia.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
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


Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> writes:

> Hi Aidan
>
>> The "convert-xxx" properties only have an effect for DPCM DAI links.
>> A DAI link is only created as DPCM if the device tree requires it;
>> part of this involves checking for the use of "convert-xxx" properties.
>>
>> When the convert-sample-format property was added, the checks got out
>> of sync. A DAI link that specified only convert-sample-format but did
>> not pass any of the other DPCM checks would not go into DPCM mode and
>> the convert-sample-format property would be silently ignored.
>>
>> Fix this by adding a function to do the "convert-xxx" property checks,
>> instead of open-coding it in simple-card and audio-graph-card. And add
>> "convert-sample-format" to the check function so that DAI links using
>> it will be initialized correctly.
>>
>> Fixes: 047a05366f4b ("ASoC: simple-card-utils: Fixup DAI sample format")
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
> (snip)
>> +bool asoc_simple_convert_is_required(const struct asoc_simple_data *data);
>
> This is not a big deal, but "is_conert_required" is better for me :)
>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

That sounds better, thanks. I'm sending patch v2 now.
- Aidan
