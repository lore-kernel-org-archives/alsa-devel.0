From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 1/3] ASoC: cs4265: SOC_SINGLE register
 value error fix
Date: Wed, 29 Aug 2018 09:28:09 +1000
Message-ID: <d108bb37-fd8f-b0d8-fc4a-883cd6d8da07@flatmax.org>
References: <20180826225844.13754-1-flatmax@flatmax.org>
 <20180828185756.GK2414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id CF81526779D
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 01:28:12 +0200 (CEST)
Received: from [60.229.147.198] (helo=[192.168.2.51])
 by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <flatmax@flatmax.org>) id 1funP7-0003qA-DD
 for alsa-devel@alsa-project.org; Wed, 29 Aug 2018 09:28:09 +1000
In-Reply-To: <20180828185756.GK2414@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 29/08/18 04:57, Mark Brown wrote:
> On Mon, Aug 27, 2018 at 08:58:42AM +1000, Matt Flax wrote:
>> The cs4265 driver declares the "MMTLR Data Switch" register setting with
>> a 0 register value rather then the 0x12 register (CS4265_SPDIF_CTL2).
>> This incorrect value causes alsamixer to fault with the output :
>> cannot load mixer controls: Input/output error
> How is this patch series different to the apparently identical three
> patch series you sent a few minutes earlier?
>

The identical patch series were sent from the wrong email address and 
didn't go through to the list - because of moderation.
I apologise for the first mistake.

Matt
