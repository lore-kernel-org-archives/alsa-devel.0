From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: No shutdown code in soc-core.c
Date: Mon, 19 Apr 2010 13:15:14 +0100
Message-ID: <1271679314.3208.100.camel@odin>
References: <21125077.117201271487763642.JavaMail.weblogic@epml11>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D37962440A
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 14:15:29 +0200 (CEST)
Received: by wwb22 with SMTP id 22so27343wwb.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 05:15:29 -0700 (PDT)
In-Reply-To: <21125077.117201271487763642.JavaMail.weblogic@epml11>
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

On Sat, 2010-04-17 at 07:02 +0000, ANISH KUMAR wrote:
> Why this shutdown filed is not there in the struct shown below:
> static struct platform_driver soc_driver 
> {
> .shutdown       = soc_shutdown,                  //soc-core.c 
> }
> This shutdown call this codec_dev->shutdown function 
> In my case i am turning off the amplifier using this call.Which
> solved my problem of "TAK" sound during reset.
> 
> I agree that soc_codec_close() is calling the shutdown function
> but in my case there is a call to set the path after this which is
> turning on the amplifier and suddenly if we reset the phone it is
> causing "TAK" sound.Probably because AMPLIFIER was on.
> 
> Anyway why this function call soc_shutdown() is there in 
> soc-core.c if no one is calling it???
> I know there will be a redundancy if we have shutdown field
> in the struct shown above as soc_codec_close call also calls
> codec shutdown code.
> But in my case it is solving my problem. 
>  
> 

Did you see Mark's reply on dev_pm_ops ?

i.e.

static const struct dev_pm_ops soc_pm_ops = {
	.suspend = soc_suspend,
	.resume = soc_resume,
	.poweroff = soc_poweroff,
};

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
