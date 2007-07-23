From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: How do I tell ALSA that my driver supports every
	possible	sample rate?
Date: Mon, 23 Jul 2007 17:39:47 +0100
Message-ID: <1185208787.4091.21.camel@localhost.localdomain>
References: <46A4CF38.3050107@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id AE82C10380E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 18:39:48 +0200 (CEST)
In-Reply-To: <46A4CF38.3050107@freescale.com>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-07-23 at 10:54 -0500, Timur Tabi wrote:
> I'm building an ASOC driver, and I want to tell ALSA that my PCM and my I2S drivers 
> support every possible sample rate, because it's the codec that determines the real 
> limitations.  What SNDRV_PCM_RATE_xxx bit-pattern do I specify that will always match?
> 

If your lucky enough to have this hardware, I think I would probably set
the I2S and DMA rates as SNDRV_PCM_RATE_8000_192000.

Liam
