From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: soc - fsl_ssi.c fix audio capture
Date: Fri, 4 Jul 2008 12:01:47 +0100
Message-ID: <20080704110147.GA26499@rakim.wolfsonmicro.main>
References: <20080703143714.GA7003@polina.dev.rtsoft.ru>
	<20080703144254.GB652@sirena.org.uk>
	<B615D57E-324C-4812-997C-9E5C90FDE967@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18D10103810
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 13:01:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B615D57E-324C-4812-997C-9E5C90FDE967@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2008 at 07:02:17AM -0400, Timur Tabi wrote:

> Anton, are you sure returning -EBUSY is the right fix?  Would this make 
> applications like mplayer detect the problem and automatically pick a 
> matching sample format that does work?

It's probably worth testing with OSS emulation too, though you could
decide that you don't want to support that.
