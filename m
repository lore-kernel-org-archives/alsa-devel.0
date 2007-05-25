From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH 0/2] ASoC sound support
	for	SMDK2440boards
Date: Fri, 25 May 2007 10:51:52 +0100
Message-ID: <1180086712.13652.34.camel@localhost.localdomain>
References: <5b7270f40705240728p4f579269g1ddc8e8db8d59f81@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D1FD65@MAIL.eldorado.org.br>
	<5b7270f40705241445t59a89b24sacbd3abf0a1b129d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F8FF2443C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 11:51:53 +0200 (CEST)
In-Reply-To: <5b7270f40705241445t59a89b24sacbd3abf0a1b129d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zoltan Devai <zdevai@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-24 at 23:45 +0200, Zoltan Devai wrote:
> 2007/5/24, Jose Henrique Spahn Torres <jose.torres@eldorado.org.br>:
> > I have a SMDK2410 and I am trying to run kernel 2.6.20 on it. The kernel
> > is running Ok, but the sound is dead. I gonna try your patch and I would
> > like to know which files from the RK's patch have you used?
> 
> The attached two patches should enable the sound support fully.
> One of them adds the l3-bus, the other one the necessary Kconfig and
> Makefile changes, along with an ASoC hack.

Thanks, I'll apply all to the ASoC dev branch.

Fwiw, I'll be working on a change for passing private data in the
read/write functions.

Cheers

Liam 
