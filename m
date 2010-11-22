From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: bug in alsa-lib/snd_pcm_plugin_delay for capture?
Date: Mon, 22 Nov 2010 15:01:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011221451250.8433@eeebox2.perex-int.cz>
References: <AANLkTi=in6g2YxRKwkCi7H_v0jmJ9tOouc2FK-Rg8iDt@mail.gmail.com>
	<alpine.LNX.2.00.1011180927310.21207@eeebox2.perex-int.cz>
	<AANLkTikihnQxQa-1RednpZSpx5Rn5XEcZYJfcShh6HW7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C9DF103A15
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 15:01:33 +0100 (CET)
In-Reply-To: <AANLkTikihnQxQa-1RednpZSpx5Rn5XEcZYJfcShh6HW7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, wim.taymans@collabora.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Nov 2010, pl bossart wrote:

>>> Since the PulseAudio commit 29acfd0e0413a9bd126782763ee2dcf10357546 I
>>> am seeing errors messages telling me that the information reported by
>>> snd_pcm_avail_delay is not accurate on the capture path, more
>>> specifically the delay is lower than the available samples.
>>
>> Could you test patch bellow?
>>
>> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=ba9332e9192814a5431a3a2505d25d74a9232124
>
> Nah, no luck. PulseAudio still reports an error and if I add
> assert(*delayp >= *availp) the code bombs out.
> Here is one way to solve the problem. I don't claim it's the right
> one, but it's compatible with the way the availp value is computed,
> and it makes the error message go away in PulseAudio.

The double avail_update() calling seems too expensive to me. Could you 
test to use snd_pcm_mmap_capture_avail() instead snd_pcm_avail_update() 
calls (to assign both slave_avail and plugin_avail local variables)?

Also, remove the assert. I think that it may be raised when the stream is 
in some xrun state (with xrun checks disabled). The avail_update can 
return the negative values in this specific configuration.

> While I was at it I also removed the .client_frames and .slave_frames
> methods that no one seems to use. This seems to be dead code that
> hasn't been touched in years.

Good catch. This code was used with the really old rate plugin (this 
plugin was recoded completely). I applied this patch.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
