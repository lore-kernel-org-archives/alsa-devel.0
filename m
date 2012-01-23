From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Request for compilation test - v1.0.25
Date: Mon, 23 Jan 2012 17:40:44 +0100
Message-ID: <4F1D8D8C.5070105@perex.cz>
References: <4F1D405E.50301@perex.cz> <s5hfwf64i86.wl%tiwai@suse.de>
	<4F1D7F91.2030301@perex.cz> <s5hvco22xcv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AF69103890
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 17:40:25 +0100 (CET)
In-Reply-To: <s5hvco22xcv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 23.1.2012 17:32, Takashi Iwai wrote:
> At Mon, 23 Jan 2012 16:41:05 +0100,
> Jaroslav Kysela wrote:
>>
>> Date 23.1.2012 15:16, Takashi Iwai wrote:
>>> At Mon, 23 Jan 2012 12:11:26 +0100,
>>> Jaroslav Kysela wrote:
>>>>
>>>> 	The alsa-driver package will not support the kernels bellow 2.6.18
>>>> (released Sep 20 2006), from README:
>>>>
>>>>  - Vanilla 3.0 to 3.2
>>>>  - Vanilla 2.6.18 to 2.6.39
>>>>
>>>> 	I kept the 2.4 build code, but it is not maintained and definitely, it
>>>> will be removed in next alsa-driver versions.
>>>
>>> 2.4 kernel won't be built since many driver codes need
>>> KBUILD_MODNAME.
>>>
>>> OTOH, 2.6 kernels below 2.6.18 should be still OK. I'm building the
>>> drivers regularly with 2.6.9 and 2.6.16 kernels for SLE10 and SLE11.
>>
>> I tried vanilla kernels, but there are many things to resolve for recent
>> gcc and make - the 2.6.18 vanilla was the first kernel which works. I
>> believe that modified distribution specific kernels - which includes
>> some newer code/interface - might work ok. It was the reason to avoid a
>> hard-coded kernel version check in configure.in.
> 
> Yeah, running an old gcc is nasty, so I'm OK to mention the support
> status in the way above you stated.  OTOH, would be good to mention
> that the builds are OK with the older 2.6 kernels.

Yep, added.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
