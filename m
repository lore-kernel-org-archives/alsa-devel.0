From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: soc - fsl_ssi.c fix audio capture
Date: Fri, 4 Jul 2008 07:08:40 -0400
Message-ID: <188E0BE6-392F-4571-9225-6492F25BB1B9@freescale.com>
References: <20080703143714.GA7003@polina.dev.rtsoft.ru>
	<20080703144254.GB652@sirena.org.uk>
	<B615D57E-324C-4812-997C-9E5C90FDE967@freescale.com>
	<20080704110147.GA26499@rakim.wolfsonmicro.main>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D605B245C4
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 13:04:52 +0200 (CEST)
In-Reply-To: <20080704110147.GA26499@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org


On Jul 4, 2008, at 7:01 AM, Mark Brown wrote:

> It's probably worth testing with OSS emulation too, though you could
> decide that you don't want to support that.

Sadly, we have a customer that insists on OSS support, so that is a  
hard requirement.
