From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: bug in alsa-lib/snd_pcm_plugin_delay for capture?
Date: Tue, 23 Nov 2010 11:25:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011231119271.8433@eeebox2.perex-int.cz>
References: <AANLkTi=in6g2YxRKwkCi7H_v0jmJ9tOouc2FK-Rg8iDt@mail.gmail.com>
	<alpine.LNX.2.00.1011180927310.21207@eeebox2.perex-int.cz>
	<AANLkTikihnQxQa-1RednpZSpx5Rn5XEcZYJfcShh6HW7@mail.gmail.com>
	<alpine.LNX.2.00.1011221451250.8433@eeebox2.perex-int.cz>
	<AANLkTimuizeF+p23wrBg9CQFouhRHj2x6g7tD3bQ8g4=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FF58244AB
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 11:25:03 +0100 (CET)
In-Reply-To: <AANLkTimuizeF+p23wrBg9CQFouhRHj2x6g7tD3bQ8g4=@mail.gmail.com>
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

>>>> Could you test patch bellow?
>>>>
>>>>
>>>> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=ba9332e9192814a5431a3a2505d25d74a9232124
>>>
>>> Nah, no luck. PulseAudio still reports an error and if I add
>>> assert(*delayp >= *availp) the code bombs out.
>>> Here is one way to solve the problem. I don't claim it's the right
>>> one, but it's compatible with the way the availp value is computed,
>>> and it makes the error message go away in PulseAudio.
>>
>> The double avail_update() calling seems too expensive to me. Could you test
>> to use snd_pcm_mmap_capture_avail() instead snd_pcm_avail_update() calls (to
>> assign both slave_avail and plugin_avail local variables)?
>
> Nope, it still does not work if you use mmap_capture_avail. The root
> cause of the problem is the while loop in snd_pcm_plugin_avail_update
> (copied for reference below), it's called only in the capture case and
> the value returned by the xfer variable causes the delay to be
> eventually lower than the avail samples.

After rethinking, I believe that the right fix should be to add the 
'snd_pcm_mmap_capture_avail(pcm)' to the sd variable - delay(slave) - for 
the capture direction. You should not bother with avail_update or the 
slave avail values. The avail_update() capture loop just copied samples 
from the producer (slave) to the consumer (pcm). It means that the avail 
becomes lower for the producer (slave) and is increased for the consumer 
(pcm). The delay(slave) already contains the avail(slave) value.

So, the result should be 'delay(slave) + mmap_capture_avail(pcm)'.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
