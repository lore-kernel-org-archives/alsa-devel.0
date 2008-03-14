From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: AK4114 - capturing spdif input stops the stream
Date: Fri, 14 Mar 2008 18:15:00 +0100
Message-ID: <47DAB294.3090502@insite.cz>
References: <47D85E20.7060109@insite.cz>	<s5hr6efdpv1.wl%tiwai@suse.de>	<47D922D0.8060006@insite.cz>	<s5hfxuuvi9l.wl%tiwai@suse.de>	<47D97E0A.1080400@insite.cz>
	<s5hfxuts2i6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 69C4E24497
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 18:15:14 +0100 (CET)
In-Reply-To: <s5hfxuts2i6.wl%tiwai@suse.de>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> Takashi, thanks for the patch, it works flawlessly.
> 
> OK, now committed to HG tree.

Thanks a lot. I will just resolve the conflicts now :)


>> Another issue - when the external clock changes rate and the stream is 
>> running (typically when starting the source playback which switches the 
>> source card (and its SPDIF-OUT) to a different frequency), the target 
>> card detects the change and the capture stream is stopped in 
>> snd_ak4114_check_rate_and_errors() by
>>
>> snd_pcm_stop(ak4114->capture_substream, SNDRV_PCM_STATE_DRAINING);
>>
>> How should recording applications behave with stream in this mode? I 
>> would expect arecord to close, but it does nothing. Is this correct 
>> behaviour?
> 
> It's supposed to be drained then stopped.  Maybe something wrong in
> the handling of DRAINING state in the capture direction.
> 
> Anyway, it's a bit strange situation as is.  Since the sample rate is
> changed, you can't call simply prepare again like normal errors...

I would expect arecord to quit with some relevant message. In larger 
recording apps, e.g. Audacity, it should probably stop recording and 
display a warning message. No idea if the controlled stop with an 
appropriate error message is feasible with the existing API and code.

Thanks,

Pavel Hofman.
