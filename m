From: Sean McNamara <smcnam@gmail.com>
Subject: Re: User-space OSS emulation?
Date: Fri, 09 Nov 2007 00:19:09 -0500
Message-ID: <4733EDCD.6000205@gmail.com>
References: <47338EBD.2000206@freescale.com>	<75b66ecd0711081436g4b43cf5dl87114fa760e7b7b3@mail.gmail.com>	<47338FF3.2030005@freescale.com>
	<75b66ecd0711081458u556c2600o42f328c147aca714@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from md0.mail.umd.edu (md0.mail.umd.edu [128.8.31.162])
	by alsa0.perex.cz (Postfix) with ESMTP id C1AFF24685
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 06:19:06 +0100 (CET)
In-Reply-To: <75b66ecd0711081458u556c2600o42f328c147aca714@mail.gmail.com>
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

Lee Revell wrote:
> On Nov 8, 2007 5:38 PM, Timur Tabi <timur@freescale.com> wrote:
>   
>> Lee Revell wrote:
>>
>>     
>>> Basically it uses LD_PRELOAD to redirect OSS API calls (ioctls) to the
>>> alsa-lib equivalents.  man aoss for details on usage.
>>>       
>> I don't have it installed, that's why I'm asking about it.  I can't seem to find
>> the "aoss" web page, if there is one.
>>     
>
> Google "aoss alsa".
>
> http://alsa.opensrc.org/Aoss
>
> Lee
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
Hi,

The Linspire/Freespire team has been working on a different approach to 
this problem. They have a kernel module called "forward-oss" (and 
accompanying userspace daemon, "forward") which is, in certain ways, 
less hackish (and in certain ways _more_ hackish ;)) than aoss.

1. It doesn't use LD_PRELOAD. Many apps are incompatible with LD_PRELOAD 
if, for example, they already use it themselves, or they're setuid.
2. It's an alternative to aoss. If aoss doesn't work with an app, 
forward-oss may be worth a try.
3. forward-oss was written in 2006/early-to-mid 07. But last I tried, 
forward-oss still compiles on very recent Debian kernels - 2.6.22 and 
2.6.23 - including non-Linspire kernels. No idea about vanilla or other 
distro-specific kernels.
4. It exposes a "real" /dev/dsp device for each ALSA soundcard, e.g. 
/dev/dsp1, /dev/dsp2, etc. No syscall interception is necessary.
5. The userspace daemon calls back into your alsa-lib stack, using the 
plugin layer for mixing or multiple channels or whatever you want. So in 
that sense, it has the same advantage as aoss, while both forward-oss 
and aoss differ from the standard ALSA in-kernel OSS emulation in this 
regard (snd_pcm_oss). snd_pcm_oss interfaces directly with the kernel 
stack, rather than looping back through the user's plugin chain (AFAIK, 
this is impossible without using a daemon like Linspire has done). So, 
if you have no hardware mixing, snd_pcm_oss either hogs the soundcard or 
fails to function while other apps are using ALSA.
6. For compatibility's sake with as many different environments as 
possible, it seems forward-oss has an advantage over LD_PRELOAD methods 
(i.e. it doesn't need to use LD_PRELOAD at all).
7. It's asking a lot more of the user to have a working kernel build 
environment, and proper privileges, to install forward-oss. So 
installation is less flexible than aoss, in a sense.
8. More stuff in the kernel = higher probability of 
conflicts/panics/oopses... you know the drill.

Also, if you've ever used any sound servers, almost all of them come 
with their own ugly duckling LD_PRELOAD hack: padsp for PulseAudio, 
esddsp (?) for eSounD, artsdsp for aRts, etc. All of them basically work 
with about 20% of all OSS applications ;) YMMV.

Just thought I'd share some other ways I've found to bridge the 
OSS<->ALSA gap, besides aoss and snd_pcm_oss...

-Sean
