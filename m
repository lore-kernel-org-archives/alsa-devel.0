From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/27]: ASoC: rsnd: add Renesas Gen2
 DMAEngine support
Date: Tue, 28 Jan 2014 08:35:49 +0100
Message-ID: <52E75DD5.6040605@metafoo.de>
References: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
 <20140127194902.GU11841@sirena.org.uk>
 <87zjmh7xtd.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id BDFEA26518D
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 08:33:20 +0100 (CET)
In-Reply-To: <87zjmh7xtd.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 01/28/2014 01:30 AM, Kuninori Morimoto wrote:
>
> Hi Mark
>
>>> These are Renesas Gen2 DMAEngine support patches.
>>> #1 - #26 are cleanup/prepare patches.
>>> #27 adds Gen2 DMAEngine support.
>>
>> I've applied all these but as discussed please do work towards using the
>> generic dmaengine code (with extensions to handle non-cyclic DMA) and
>> DPCM.
>
> Thank you for your help.
> I'll try to update non-cyclic DMA code as next step.

I still think the emulation of the transfers is better done in the DMA driver 
rather than in the audio driver. The DMA driver has much more state information 
available than the audio driver, which should make the implementation on one 
hand simpler and on the other hand more reliable.

- Lars
