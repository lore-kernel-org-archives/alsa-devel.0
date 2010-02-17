From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Wed, 17 Feb 2010 10:42:23 +0000
Message-ID: <20100217104222.GA31765@sirena.org.uk>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BB43624385
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 11:42:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 11:39:47AM +0900, jassi brar wrote:

>   The query concerns ASOC.

Please do remember to CC maintainers on things.  Mail that is sent to
the mailing list only is very likely to get missed.

> Currently we have one platform per card.
> What if my card has two dai_links with each cpu_dai fed data
> with different mechanism(one with system dma controller and
> the other with a dma dedicated to the Audio block). The cpu_dai's
> are tightly coupled and I don't wanna have separate socdev's for them.

Your platform driver would need to handle this.  

> Presently, I define a dma_id flag in snd_soc_dai, make the snd_soc_card
> point to a 'wrapper/muxed' platform driver that checks the dma_id flag and
> calls the relevant platform's callbacks. Of course, each cpu_dai initializes
> the dma_id to a unique value that corresponds to it's real dma mechanism.

Yes, that's fine - you could also set some function pointers for in an
ops structure in the driver private DMA data that gets passed through,
avoiding the need for switch statements but either way works.  This is
not really much different to supplying any other information about how
to set up the DMA for a given front end, it's just that the information
includes going down different code paths for different controllers.

> (For those curious to have a reference - I am talking about Samsung's SoCs
> <http://dev.odroid.com/wiki/odroid/pds/HardwareInformation/S5PC100_UM_REV101.pdf
> refer to figures on page-1635 & 1637>
> that have I2S controllers with h/w mixing capability and where
> 'secondary fifo' can be
> fed with I2S internal DMA controller with dedicated h/w ring buffer)

So.  Ideally for hardware mixing you'd represent the hardware mixing as
a device within ASoC but that's not currently supported - the multi
CODEC work should take care of it but it's not there yet.

However, the hardware mixing you've got there looks relatively simple so
it should work fine to just represent it as two external DAIs - it looks
like there's no sample rate or format conversion so the benefits of
having the mixing visible to ASoC are relatively minor, the main benefit
would be the ability to run the two DAIs inside the CPU at different
rates from the external DAI but the lack of conversion means that's not
possible anyway and the driver will have to constrain the second channel
to what the first is doing anyway.

Overall I don't see any immediate problem with supporting this in
mainline as-is from what I've looked at so far.
