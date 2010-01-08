From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Reforming s3c2443 ac97 driver
Date: Fri, 8 Jan 2010 09:48:09 +0000
Message-ID: <9A9547C8-08FD-4310-A69C-44CA8A3E01C2@opensource.wolfsonmicro.com>
References: <29946650.33531262928531169.JavaMail.weblogic@epml17>
	(sfid-20100108_052901_174974_5230D401)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98CD82433C
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 10:47:55 +0100 (CET)
In-Reply-To: <29946650.33531262928531169.JavaMail.weblogic@epml17>
	(sfid-20100108_052901_174974_5230D401)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "jassi.brar@samsung.com" <jassi.brar@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, SeungHyun Choi <sh428.choi@samsung.com>, "graeme.gregory@wolfsonmicro.com" <graeme.gregory@wolfsonmicro.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On 8 Jan 2010, at 05:28, JASWINDERSINGH BRAR <jassi.brar@samsung.com>  
wrote:

> Hi,
>     Right now the S3C2443's AC97_ver2.0 controller driver isn't  
> flexible enough
> to handle newer SoCs.
>   In order to prepare ground for supporting 64xx and S5Pxxxx the  
> extant driver
> needs to be reformed, and that is what i am planning to do next.
>
> I plan to do the following:-
> 1) User platform_driver structure to detect and manage AC97 controller
> platform devices.
> 2) Remove hardcoded parameters(DMA, IO address, IRQ etc) and pass via
> platform resources.
> 3) Initialize platform specific stuff by callback pointers to  
> platform code(cfg_gpio)
>
> Objections, suggestions welcome.

This sounds like a good approach - please go ahead.
