From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: Reforming s3c2443 ac97 driver
Date: Fri, 8 Jan 2010 05:53:14 +0000
Message-ID: <20100108055314.GE24370@trinity.fluff.org>
References: <29946650.33531262928531169.JavaMail.weblogic@epml17>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 0282F245C1
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 06:53:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <29946650.33531262928531169.JavaMail.weblogic@epml17>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: JASWINDERSINGH BRAR <jassi.brar@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, SeungHyun Choi <sh428.choi@samsung.com>, "graeme.gregory@wolfsonmicro.com" <graeme.gregory@wolfsonmicro.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 08, 2010 at 05:28:51AM +0000, JASWINDERSINGH BRAR wrote:
> Hi,
>      Right now the S3C2443's AC97_ver2.0 controller driver isn't flexible enough
> to handle newer SoCs.
>    In order to prepare ground for supporting 64xx and S5Pxxxx the extant driver
> needs to be reformed, and that is what i am planning to do next.
> 
> I plan to do the following:-
> 1) User platform_driver structure to detect and manage AC97 controller
> platform devices.
> 2) Remove hardcoded parameters(DMA, IO address, IRQ etc) and pass via
> platform resources.
> 3) Initialize platform specific stuff by callback pointers to platform code(cfg_gpio)
> 
> Objections, suggestions welcome.

None from here, although it isn't really my driver in the first place.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
