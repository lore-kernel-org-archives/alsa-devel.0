From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [SoC] DMA not generate interrupt !
Date: Fri, 6 Nov 2009 14:48:51 +0000
Message-ID: <20091106144850.GC4938@sirena.org.uk>
References: <d09ab3aa0911052318j64c5c3aaib39816a8316b2b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E66710397A
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 15:48:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d09ab3aa0911052318j64c5c3aaib39816a8316b2b40@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hung nguyen <jokerhung@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 06, 2009 at 02:18:01PM +0700, hung nguyen wrote:

> I am writing my audio driver for my board: TMPA910 CPU and WM8960 codec.
> when I run pcm_min.c, there is an error: "Input/Output error".
> I find that error because no DMA interrupt appear, printk() in DMA
> interrupt program no appear

> I have already set bit IE and ITC in DMA Configuaration register but no change.

> Here is my source code.
> Any idea, what could be the reason ?

The error you are seeing usually means that the DMA controller is not
running.  This is usually (but not always) due to either an error in
your clocking configuration or in the configuration of any multi-function
pins on the processor so that the controller on the CPU doesn't see
incoming signals.

I'd strongly recommend using the ASoC subsystem for embedded audio
drivers rather than doing a custom standalone driver as you have here.
There is an existing driver for the WM8960 in mainline.
