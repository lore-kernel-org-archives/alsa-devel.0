From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: No shutdown code in soc-core.c
Date: Mon, 19 Apr 2010 15:10:55 +0100
Message-ID: <1271686255.3208.309.camel@odin>
References: <11864963.186471271683156859.JavaMail.weblogic@epml11>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f218.google.com (mail-bw0-f218.google.com
	[209.85.218.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D33D1037EA
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 16:11:01 +0200 (CEST)
Received: by bwz10 with SMTP id 10so4896545bwz.4
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 07:11:00 -0700 (PDT)
In-Reply-To: <11864963.186471271683156859.JavaMail.weblogic@epml11>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: anish.singh@samsung.com
Cc: "liam.girdwood@wolfsonmicro.com" <liam.girdwood@wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-04-19 at 13:19 +0000, ANISH KUMAR wrote:
> >Did you see Mark's reply on dev_pm_ops ? 
> 
> >i.e. 
> 
> >static const struct dev_pm_ops soc_pm_ops = { 
> >   .suspend = soc_suspend, 
> >    .resume = soc_resume, 
> >   .poweroff = soc_poweroff, 
> >};
>  
>  I missed out Mark reply.However i checked now  this structure is 
>  not there in my code base.As i mentioned in my previous mail 
>  the flow of events when restart takes place.
>  Anyway i thought something is amiss in this struct platform_driver soc_driver 
>  that is why i am mailing to the experts here otherwise my
>  problem is fixed by having the code as mentioned in my previous 
>  mail.
> I just wanted to know the reason?Or Am i missing something probably the concept
> of turning off the audio driver??
> Kerenl version used: 2.6.29
> 

Ah, your kernel is very old. I would just do what you are currently
doing with shutdown and use the dev_pm_ops when you upgrade your kernel.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
