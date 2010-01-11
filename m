From: Markus Luttenberger <m.luttenberger@avibit.com>
Subject: Re: Problems with snd_pcm_wait(..)
Date: Mon, 11 Jan 2010 12:48:17 +0100
Message-ID: <4B4B1001.9010704@avibit.com>
References: <4B4B0DD0.8090900@avibit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avibit.com (avserver.avibit.com [62.99.140.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A74524571
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:48:18 +0100 (CET)
Received: from pc14.avibit.com (pc14.avibit.com [10.1.1.54])
	by avibit.com (Postfix) with ESMTP id 2BF94684131
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:48:17 +0100 (CET)
In-Reply-To: <4B4B0DD0.8090900@avibit.com>
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

Markus Luttenberger schrieb:
> I tried to implement a callback functionality with ALSA based on the 
> example given at 
> http://www.cs.utk.edu/~vose/linux/equalarea.com/alsa-audio.html#interruptex. 
> Especially the while-loop is basically the same in my program. However, 
> it doesn't work. I can trace the program to snd_pcm_wait(..) which just 
> waits endlessly.

Oops, I overlooked something obvious (I set the 
snd_pcm_sw_params_set_avail_min(..) to the wrong value). Ignore my 
question, sorry.


greetings..
..Markus
