From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: ALSA DMIX support without MMAP ?
Date: Fri, 15 Jan 2010 12:07:00 +0000 (GMT)
Message-ID: <17791994.52581263557220723.JavaMail.weblogic@epml09>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id D75CE243F9
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 13:07:04 +0100 (CET)
Received: from ep_ms13_bk (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KWA0001HEZPVI@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 Jan 2010 21:07:01 +0900 (KST)
Received: from ep_spt04 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KWA00EKDEZOBI@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 Jan 2010 21:07:00 +0900 (KST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: maniyar@samsung.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

>For dmix, the stop_threshold should be equal to boundary value, thus XRUN 
>check should never be true. If you got xrun with dmix, something is wrong.
DMIX is working now.

 > but when i am 
> playing with Plug PCM there is some noise in the song why????Is rate 
> conversion algoritm not able to resample it properly?
>The default linear resampler is not very good quality. You may use some 
>sox resamplers from the alsa-plugins package, but they&#39;re more CPU 
>intensive. Check google.

Actually i am working on soc platform(android-S3C6410) and wanted to use DMIX and some good resampler for my software mixing instead of current software mixing and resampling in upper layer(Above alsa-lib).DMIX is working fine but this resampling is causing some jitter.During rate conversion it looks for libasound_module_rate_speexrate.so which i don't have so its using default one causing the jitter.
Can i build this .so file (as current way of alsa-plugin downloading will not work for me)?For sox resampler i guess i need to use differnet .so and corresponding changes in asound.conf file??
Can i get speex or sox  resampler code so that i can build it for my system?????
This code(speex or sox) i guess would have been integrated with alsa-lib so that alsa-lib can call corresponding functions of resampler source code. 
 
 OR simply point me to url as googling is not helping.Everywhere i am getting this "you need to download plugins".This will not work in my case.
