From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] New Aztech Sound Galaxy driver.
Date: Thu, 13 Sep 2007 19:56:19 +0200
Message-ID: <46E979C3.6020109@gmail.com>
References: <46E1DD43.6060403@gmail.com>	
	<20070911210704.e738bd61.krzysztof.h1@gmail.com>	
	<46E6EAAC.1070804@gmail.com>
	<8c74410a0709121131x2f89c27do2dc81e24c6acdcad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 0365B2412E
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 19:56:40 +0200 (CEST)
In-Reply-To: <8c74410a0709121131x2f89c27do2dc81e24c6acdcad@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Ram Kromberg <ramkromberg@mail.com>
List-Id: alsa-devel@alsa-project.org

On 09/12/2007 08:31 PM, Krzysztof Helt wrote:

> I fixed this as you wrote and now the driver works ok. I haven't
> tested recording.

Thanks. I have been testing recording here, so that should be fine.

> If you care the mixer controls I found that: "Line" is CD line and
> "Aux1" is FM/wavetable.

Yes, I know, and plain "Aux" is the Line In. In this case I admit it's a 
little clumsy since you'd expect the mixer control "Line" to be that but 
generally I don't much care.

Or better said, I do, and generally am not very fond of the control-renaming 
in the drivers since I believe ALSA should be providing for it in userspace 
such that the user can not only rename things to whatever the driver author 
and/or datasheet considered applicable, but also to things like "TV", or 
"Bedroom" or whatever.

This is most applicable to generic drivers -- I for example have an ES1968 
card sitting in this machine with an FM Tuner connected to its "Video" 
input. I'd love to call that "Radio" instead...

But well, sure, maybe I'll rename them in this case. Or maybe not.

> This card returns DSP version 3.1 which is something better than SB Pro.
> Maybe these AZT-1605 cards return earlier DSP version (but I do not
> expect anything less than 3.0)

They do, DSP version 2.1 and all AZT2316s I've tested are 3.1. Unfortunately 
though, an even older Aztech chip returns 3.1 again, meaning it's at least 
not going to help for integrating that as well.

Haven't had time to look at it for a few days, but will be poking again.

Rene.
