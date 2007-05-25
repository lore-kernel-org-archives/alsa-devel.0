From: "Zoltan Devai" <zdevai@gmail.com>
Subject: Re: [RFC] [PATCH 0/2] ASoC sound support for
	SMDK2440boards
Date: Fri, 25 May 2007 12:52:31 +0200
Message-ID: <5b7270f40705250352k2dcacfc1gc6c8fc5587d12edd@mail.gmail.com>
References: <5b7270f40705240728p4f579269g1ddc8e8db8d59f81@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D1FD65@MAIL.eldorado.org.br>
	<5b7270f40705241445t59a89b24sacbd3abf0a1b129d@mail.gmail.com>
	<1180086712.13652.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B63524435
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 12:52:33 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so195912ana
	for <alsa-devel@alsa-project.org>; Fri, 25 May 2007 03:52:32 -0700 (PDT)
In-Reply-To: <1180086712.13652.34.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2007/5/25, Liam Girdwood <lg@opensource.wolfsonmicro.com>:
> On Thu, 2007-05-24 at 23:45 +0200, Zoltan Devai wrote:
> > 2007/5/24, Jose Henrique Spahn Torres <jose.torres@eldorado.org.br>:
> > > I have a SMDK2410 and I am trying to run kernel 2.6.20 on it. The kernel
> > > is running Ok, but the sound is dead. I gonna try your patch and I would
> > > like to know which files from the RK's patch have you used?
> >
> > The attached two patches should enable the sound support fully.
> > One of them adds the l3-bus, the other one the necessary Kconfig and
> > Makefile changes, along with an ASoC hack.
>
> Thanks, I'll apply all to the ASoC dev branch.


Please don't!! :)
These patches are just for testing the board and codec code.
They are no way final, and not meant for inclusion.
Please read:
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-May/001150.html


Zoltan
