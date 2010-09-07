From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: crash with assertion (?)
Date: Tue, 07 Sep 2010 19:06:05 +0200
Message-ID: <4C8670FD.5020906@ladisch.de>
References: <4C8662AD.1040607@iem.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 169DE103873
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 19:05:38 +0200 (CEST)
In-Reply-To: <4C8662AD.1040607@iem.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: IOhannes m zmoelnig <zmoelnig@iem.at>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

IOhannes m zmoelnig wrote:
> i'm requesting my "plughw" device with 44100Hz
> the request is done with something like:
>  rate=44100;
>  err = snd_pcm_hw_params_set_rate_min(handle, params, &rate, 0);

This requests a sample rate of at least 44100 Hz.

> [...]
>  err = snd_pcm_hw_params(handle, params);
> 
> what happens:
> in the snd_pcm_hw_params(), my program exits with:
> "interval_inline.h:52: snd_interval_single: Assertion
> `!snd_interval_empty(i)' failed."

You called snd_pcm_hw_params with an invalid params structure.
I'd guess that snd_pcm_hw_params_set_rate_min (or some other
snd_pcm_hw_params_set_*) returned an error.


Regards,
Clemens
