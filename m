From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA DMIX support without MMAP ?
Date: Mon, 18 Jan 2010 11:01:07 +0000
Message-ID: <20100118110106.GA3827@rakim.wolfsonmicro.main>
References: <29151493.101581263785131632.JavaMail.weblogic@epml24>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB1AA1037EA
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 12:01:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <29151493.101581263785131632.JavaMail.weblogic@epml24>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: MAHAMMADRAFI MANIYAR <maniyar@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk, lennart@poettering.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2010 at 03:25:31AM +0000, ANISH KUMAR wrote:

[Reflowed into 80 columns for legibility.]

> Mark thanks for the suggestion and i checked out PulseAudio for my
> requirements.I found out that i don't need all the things in PulseAudio 
> a. I just need good resampling code.Can i just use just the resampler code of pulseaudio(mine is mobile enviroment)?
> b. Just want a good mixer at ALSA-LIB level.As of now this is provided by android framework but i want this to be done by ALSA-LIB so that i
>     can replace with some good mixer later on(if i find that some other mixer is good).DMIX is providing that but it's not that good.

The mixing (and therefore resampling) are the core functionality of
PulseAudio which is why it seems like a good fit for your application.

> c.Jaroslav suggested to use sox resamplers but for that to work i have to get the sox resampler code(proper license) and need to build it for my system and link it  
>    with corresponding functions of ALSA-LIB so that they can call relevant functions for resampling.As i am working on mobile domain i think i need to do the   
> d. I saw some check-ins related to Scenario Manager.As of now scenario manager functionality is also given in Android(we open a differnet
>     device and the corresponding hooks for changing the routes dynamically) but i think if it given in alsa-lib switching will be much faster and this 
>     will increase the system performance.

The application layer code isn't going to make a meaningful difference
to the performance of scenario switching unless it's woefully
inefficient, the major constraint is almost always the fact that the
CODEC has a relatively slow control bus so the register changes to
implement the change dominate the time.
