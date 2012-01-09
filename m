From: Patrick Lai <plai@codeaurora.org>
Subject: Re: [PATCH] ASoC: introduce SOC_SINGLE_S8_TLV macro
Date: Sun, 08 Jan 2012 21:52:17 -0800
Message-ID: <4F0A8091.8050804@codeaurora.org>
References: <1325987606-7179-1-git-send-email-plai@codeaurora.org>
	<20120108202332.GE29065@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 0744310393E
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 06:52:25 +0100 (CET)
In-Reply-To: <20120108202332.GE29065@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> | #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
>
> Since no shifts are specified the signature is just the same as your
> SOC_SINGLE_S8_TLV:

Yes, it could have been made more generic with shift parameter.
Existing behavior is writing same value to most and least significant
bytes of 16-bit wide register.

>> +#define SOC_SINGLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
>
> so it looks like what really ought to happen here is that the existing
> macro gets renamed to the new macro and a new macro gets defined for
> double values if one is needed.

Is there backward compatibility concern? I see soc/codec/uda1380.c
already using SOC_DOUBLE_S8_TLV.

Thanks
Patrick

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
---
