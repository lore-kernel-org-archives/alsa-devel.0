From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: ux500_pcm: Differentiate between
 pdata and DT initialisation
Date: Tue, 03 Dec 2013 13:15:50 +0100
Message-ID: <529DCB76.4070705@metafoo.de>
References: <1386066427-6862-1-git-send-email-lee.jones@linaro.org>
 <529DC6BE.3080607@metafoo.de> <20131203120420.GC12031@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-110.synserver.de (smtp-out-012.synserver.de
 [212.40.185.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 51094265151
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 13:15:09 +0100 (CET)
In-Reply-To: <20131203120420.GC12031@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/03/2013 01:04 PM, Lee Jones wrote:
> On Tue, 03 Dec 2013, Lars-Peter Clausen wrote:
> 
>> On 12/03/2013 11:27 AM, Lee Jones wrote:
>>> If booting with full DT support (i.e. DMA too, the last piece of the
>>> puzzle), then we don't need to use the compatible_request_channel call
>>> back or require some of the historical bumph which probably isn't
>>> required by a platform data start-up now either. This will also be
>>> ripped out in upcoming commits.
>>>
>>> Cc: alsa-devel@alsa-project.org
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> Strictly speaking you do not need the second config, but well considering
>> that this will all hopefully be removed soon anyway it should be fine.
> 
> That's true it will, but why don't we need the second config? I won't
> want the compat function to be called in the DT case.

It will only be called if it was not possible to request the DMA channel
from the DT.

- Lars
