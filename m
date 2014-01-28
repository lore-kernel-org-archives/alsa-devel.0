From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/27]: ASoC: rsnd: add Renesas Gen2
 DMAEngine support
Date: Tue, 28 Jan 2014 13:06:29 +0100
Message-ID: <52E79D45.5090301@metafoo.de>
References: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
 <20140127194902.GU11841@sirena.org.uk>
 <87zjmh7xtd.wl%kuninori.morimoto.gx@gmail.com> <52E75DD5.6040605@metafoo.de>
 <20140128113429.GK11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DF682651CF
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 13:06:31 +0100 (CET)
In-Reply-To: <20140128113429.GK11841@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/28/2014 12:34 PM, Mark Brown wrote:
> On Tue, Jan 28, 2014 at 08:35:49AM +0100, Lars-Peter Clausen wrote:
> 
>> I still think the emulation of the transfers is better done in the
>> DMA driver rather than in the audio driver. The DMA driver has much
>> more state information available than the audio driver, which should
>> make the implementation on one hand simpler and on the other hand
>> more reliable.
> 
> On the other hand it's a problem that several devices have so we should
> be able to factor out the interface matching so it should have at least
> some of the code in one of the frameworks, dmaengine would seem natural
> too me too but apparently audio is about the only user of cyclic DMA so
> IIRC the DMA guys were pushing back on doing it there.
> 

The virt_dma helper functions already take care of some of the cyclic
specific details. And more can probably be added. E.g. what comes to mind is
the tracking of whether a descriptor is cyclic and which segment of the
descriptor to submit next. All users of virt_dma already implement these in
almost the same fashion. So this would not only to allow to factor out the
handling for the cyclic case, but also for the non cyclic case. And for all
users of those helpers cyclic support would essentially be free.

- Lars
