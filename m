From: Timur Tabi <timur@freescale.com>
Subject: Re: MPC5200 I2S driver for ASoC
Date: Wed, 01 Aug 2007 12:53:33 -0500
Message-ID: <46B0C89D.50704@freescale.com>
References: <46B0C3EE.5020401@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 39CE510384B
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 19:53:40 +0200 (CEST)
In-Reply-To: <46B0C3EE.5020401@acdstar.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lokowich <lokowich@acdstar.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

lokowich wrote:
> I'm integrating a ALSA driver for an MPC5200 into the ASoC layer, 
> similar to my successful effort for a PXA255 board.  

Can you provide your code?  I'm working on ASoC support for another MPC SOC, so we need to 
synchronize our development.

> I'm modeling the 
> DMA and ALSA interfaces per ac97mgt driver found in the Lite5200B BSP, 
> rather than the BestComm API example in the 2.4 kernel.  The 
> speaker-test with 400Hz sine wave is working, but has a slight audible 
> jitter.  A wav file output using aplay produces white noise.  

What kind of audio samples are you trying to play?  Since the MPC5200 is typically 
big-endian, you probably can only play S16_BE samples instead of S16_LE samples.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
