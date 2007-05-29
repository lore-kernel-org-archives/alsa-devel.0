From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Question on snd_soc_dai_link
Date: Tue, 29 May 2007 15:51:48 +0100
Message-ID: <1180450308.5816.155.camel@a10072.wolfsonmicro.main>
References: <46575B3E.2020603@freescale.com>
	<1180354777.5816.39.camel@a10072.wolfsonmicro.main>
	<465B83B4.4000801@freescale.com>
	<1180448356.5816.145.camel@a10072.wolfsonmicro.main>
	<465C3A53.10902@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 38C0F243A0
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 16:51:50 +0200 (CEST)
In-Reply-To: <465C3A53.10902@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-05-29 at 09:36 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 
> > 
> > Please let me know if I'm way off here. The device tree looks like an
> > elegant solution for machine initialisation/description.
> 
> I'm going to study this and run it by others in my department (we handle all the Linux architectural issues for Freescale SOCs).  I can tell you that you're very close, but it will require some tweaks.  Off the top of my head, I see a few problems:
> 
> 1) The I2C addresses are specified in a separate I2C node
> 2) I don't know much about the 5200, but on my part, the DMA operations are provided by the I2S device.  We don't use the generic DMA engine.

Fwiw, ASoC splits out the audio DMA code from I2S, AC97 or PCM
controllers as there isn't too much difference between audio DMA code
for each interface. Any controller specific data is passed in at
hw_params time (by the I2S/AC97/PCM controller driver) to configure
addresses, width, etc

Liam
