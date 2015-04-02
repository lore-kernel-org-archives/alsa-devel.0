From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ASoC: atmel-pcm-dma: increase
	buffer_bytes_max
Date: Thu, 2 Apr 2015 10:13:18 +0200
Message-ID: <20150402081318.GF20669@piout.net>
References: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150401203342.GH6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 26AC12605DF
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 10:13:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150401203342.GH6023@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/04/2015 at 21:33:42 +0100, Mark Brown wrote :
> On Mon, Mar 30, 2015 at 09:40:37PM +0200, Alexandre Belloni wrote:
> > atmel-pcm-dma is not limited to a buffer size of 64kB like atmel-pcm-pdc.
> > Increase buffer_bytes_max to 512kB to allow for higher bit rates (i.e. 32bps at
> > 192kHz) to work correctly. By default, keep the prealloc at 64kB.
> 
> Applied, but please look into Lars' suggestion - we should be able to
> just figure everything out from the DMA controller.

This is definitively on the TODO list.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
