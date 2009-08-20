From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] pcm_lib.c: Fixed inaccurate calculation of
 hw_ptr_interrupt in snd_pcm_update_hw_ptr_interrupt function
Date: Thu, 20 Aug 2009 10:42:46 +0200
Message-ID: <4A8D0C86.50604@ladisch.de>
References: <1250677339.3516.17.camel@shinel>
	<s5hd46scctf.wl%tiwai@suse.de>	<1250679571.500.20.camel@shinel>
	<s5h7hx0c8l2.wl%tiwai@suse.de>	<1250686106.2060.16.camel@sl>
	<s5hocqcarrx.wl%tiwai@suse.de> <1250752842.5644.34.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 96A672433C
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 10:43:40 +0200 (CEST)
In-Reply-To: <1250752842.5644.34.camel@shinel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: shinel@foxmail.com
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Shine Liu wrote:
>     I carefully read the pcm_lib.c and pcm_native.c but I didn't found
> any alignmnet constraint API. Althought there's a function called
> snd_pcm_hw_constraint_step, but this function can't be used in the
> situation referred in the last mail which one hw parameter should be
> aligned to the other hw parameter.

The period size, the buffer size, and the number of periods are all
related, so you can align the period size to the buffer size by
restricting the number of periods to be an integer:

  snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);


HTH
Clemens
