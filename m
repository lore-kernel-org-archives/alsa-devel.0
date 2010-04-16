From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: No shutdown code in soc-core.c
Date: Fri, 16 Apr 2010 18:21:30 +0100
Message-ID: <1271438490.3235.33.camel@odin>
References: <17476636.107751271436284230.JavaMail.weblogic@epml11>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 381E6244EC
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Apr 2010 19:21:57 +0200 (CEST)
Received: by wyb29 with SMTP id 29so1309352wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2010 10:21:56 -0700 (PDT)
In-Reply-To: <17476636.107751271436284230.JavaMail.weblogic@epml11>
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

On Fri, 2010-04-16 at 16:44 +0000, ANISH KUMAR wrote:
> >What are you trying to do ?
>  
> There was a "TAK" noise because of non-presence of this code.
> This soc_shutdown calls the respective shutdown code in codec
> for prevention of this kind of strange noise.In my code it is turning
> off the Amplifier because of which i no longer get the "TAK" sound.
> 

Ok, so afaict you hear a "TAK" noise at stream shutdown and want to get
rid of it. ASoC calls shutdown/close for each of it's components :-

	if (cpu_dai->ops->shutdown)
		cpu_dai->ops->shutdown(substream, cpu_dai);

	if (codec_dai->ops->shutdown)
		codec_dai->ops->shutdown(substream, codec_dai);

	if (machine->ops && machine->ops->shutdown)
		machine->ops->shutdown(substream);

	if (platform->pcm_ops->close)
		platform->pcm_ops->close(substream);

> So i am just wondering why this code is not present in the struct 
> i mentioned in my previous mail.

You didn't mention any struct in your last mail.

Please explain your problems more clearly in the future. It's very
difficult to help here without a good problem description or a detailed
explanation of why you need this feature.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
