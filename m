From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 09:47:13 -0400
Message-ID: <9e4733910806160647q63d424b8scbb72d5396934e7@mail.gmail.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id D53232417E
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 15:54:46 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so2661868ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 06:54:16 -0700 (PDT)
In-Reply-To: <1213612755.6599.51.camel@odin>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 6/16/08, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> Ok, I think I have a good idea of what you are proposing here.
>
>  The ASoC DMA is currently very much like a library in that it exports
>  it's ALSA PCM functions to the core (by registering itself) and whilst
>  the DMA functions are not directly called by client CPU DAI drivers they
>  are indirectly called on the client DAIs behalf by the ASoC core (in
>  response to ALSA core). This means we don't have to burden our DAI
>  drivers with CPU DMA specific calls.

Doesn't the current model of a global ASOC DMA driver require that all
cpu_dai channels use the same transport? Should the model allow
different transports on different cpu_dai channels (maybe some
programmed IO, and some DMA)?

I don't need this for my hardware, I'm just wondering if it should be allowed.

>  Fwiw, I do think platform driver could really be better named to be more
>  function specific e.g. dma driver. I'm also considering a rename of
>  machine to fabric.
>
>  We also have CPU DAIs that are shared between different CPU
>  architectures (with different DMA). e.g. i.MX31 and FSL PPC share the
>  same SSI architecture - breaking the tightly coupled library model.
>
>
>  Liam
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
