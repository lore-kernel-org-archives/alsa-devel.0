From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: How do I tell ALSA that my driver supports
	every	possible	sample rate?
Date: Mon, 23 Jul 2007 18:29:45 +0100
Message-ID: <1185211785.4091.25.camel@localhost.localdomain>
References: <46A4CF38.3050107@freescale.com>
	<1185208787.4091.21.camel@localhost.localdomain>
	<46A4E00B.1000702@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 70F381037EA
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 19:29:46 +0200 (CEST)
In-Reply-To: <46A4E00B.1000702@freescale.com>
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

On Mon, 2007-07-23 at 12:06 -0500, Timur Tabi wrote:

> BTW, I'm not sure why you say if I'm lucky enough.  The PCM driver, for instance, is just 
> a front-end to the DMA controller.  DMA obviously doesn't care about sample rates, so it 
> makes sense that most PCM drivers can handle any rate.  Or am I missing something?
> 

Some Audio DMA controllers may not have the bandwidth for the faster
rates and larger frames. Iirc, pxa255 stuttered a lot with rates > 96k.

Liam 
