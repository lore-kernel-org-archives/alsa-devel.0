From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: ALSA DMIX support without MMAP ?
Date: Mon, 18 Jan 2010 03:25:31 +0000 (GMT)
Message-ID: <29151493.101581263785131632.JavaMail.weblogic@epml24>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 6374D1037FC
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 04:25:36 +0100 (CET)
Received: from ep_ms13_bk (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KWF000Z9AUJED@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 18 Jan 2010 12:25:31 +0900 (KST)
Received: from ep_spt04 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KWF00FWIAUJSL@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 18 Jan 2010 12:25:31 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
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
Cc: MAHAMMADRAFI MANIYAR <maniyar@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk, lennart@poettering.net
List-Id: alsa-devel@alsa-project.org


> Actually i am working on soc platform(android-S3C6410) and wanted to
> use DMIX and some good resampler for my software mixing instead of
> current software mixing and resampling in upper layer(Above
> alsa-lib).DMIX is working fine but this resampling is causing some
> jitter.During rate conversion it looks for
> libasound_module_rate_speexrate.so which i don't have so its using
> default one causing the jitter.
>>Have you considered using PulseAudio for this?

 
Mark thanks for the suggestion and i checked out PulseAudio for my requirements.I found out that i don't need all the things in PulseAudio 
a. I just need good resampling code.Can i just use just the resampler code of pulseaudio(mine is mobile enviroment)?
b. Just want a good mixer at ALSA-LIB level.As of now this is provided by android framework but i want this to be done by ALSA-LIB so that i
    can replace with some good mixer later on(if i find that some other mixer is good).DMIX is providing that but it's not that good.
c.Jaroslav suggested to use sox resamplers but for that to work i have to get the sox resampler code(proper license) and need to build it for my system and link it  
   with corresponding functions of ALSA-LIB so that they can call relevant functions for resampling.As i am working on mobile domain i think i need to do the   
    integration of sox resampler code with ALSA-LIB for that to work??
   or 
   Can i just use the integrated sox library(some .so i guess) and change the asound.conf for using that library??Will this work??
d. I saw some check-ins related to Scenario Manager.As of now scenario manager functionality is also given in Android(we open a differnet
    device and the corresponding hooks for changing the routes dynamically) but i think if it given in alsa-lib switching will be much faster and this 
    will increase the system performance.
