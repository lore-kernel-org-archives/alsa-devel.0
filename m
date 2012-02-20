From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Direct use of the DMA buffer?
Date: Mon, 20 Feb 2012 09:38:44 +0100
Message-ID: <4F420694.6040902@ivitera.com>
References: <4F4181AF.1060303@ivitera.com> <4F420017.70508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 1108D103CC9
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 09:38:50 +0100 (CET)
In-Reply-To: <4F420017.70508@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Dne 20.2.2012 09:11, Clemens Ladisch napsal(a):
> Pavel Hofman wrote:
>> Please excuse my ignorance, but is it possible for an application to
>> directly use/output to the DMA buffer allocated by the kernel in
>> hw_params?
> 
> Set one of the SND_PCM_ACCESS_MMAP_* access types and then use
> snd_pcm_mmap_begin/commit.
> 

Clemens, thanks a lot for the information. How does it work when the
alsa-lib chain contains plugins, such as plug, rate, etc.? I would
assume the application circumvents these.

Thanks a lot.

Pavel.
