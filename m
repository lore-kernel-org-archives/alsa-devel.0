From: irfanks <irfan.shaikh@sasken.com>
Subject: Re: snd_pcm_sw_params_set_start_threshold()
	functionality
Date: Mon, 29 Oct 2012 17:58:50 +0530
Message-ID: <508E7682.5030109@sasken.com>
References: <508E6666.5080402@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 56AC52652E4
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 13:28:53 +0100 (CET)
In-Reply-To: <508E6666.5080402@sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please let me know if my below understanding is correct :


snd_pcm_sw_params_set_start_threshold() explains :
"PCM is automatically started when playback frames available to PCM are 
 >= threshold or when requested capture frames are >= threshold"

PCM has below states :

SND_PCM_STATE_OPEN                      Open
SND_PCM_STATE_SETUP                     Setup installed
SND_PCM_STATE_PREPARED              Ready to start
SND_PCM_STATE_RUNNING                Running
SND_PCM_STATE_XRUN                      Stopped: underrun (playback) or 
overrun (capture) detected
SND_PCM_STATE_DRAINING               Draining: running (playback) or 
stopped (capture)
SND_PCM_STATE_PAUSED                  Paused
SND_PCM_STATE_SUSPENDED           Hardware is suspended
SND_PCM_STATE_DISCONNECTED     Hardware is disconnected

When ever underrun occurs, PCM device state goes to XRUN state.
To bring back the PCM playback device to playback {Ready to start}, we 
use snd_pcm_prepare().

*Thus snd_pcm_sw_params_set_start_threshold() should again 
prebuffer(threshold) X periods of data {which we have set in software 
params}, once again after the XRUN state is recovered.*


Thanks and regards,
Irfan



On 10/29/2012 04:50 PM, irfanks wrote:
> Hello,
>
>             snd_pcm_sw_params_set_start_threshold() API description 
> explains, "PCM is automatically started when playback frames available 
> to PCM are >= threshold"
>
>              I want to know,  whether above pre-buffering(threshold) 
> mechanism is only during the start of playback ?
> OR
>             Also if my playback device goes to XRUN state, Again next 
> time when i prepare my playback device using snd_pcm_prepare(). Again 
> the prebuffering (threshold) will occur since i have set 
> snd_pcm_sw_params_set_start_threshold() to N periods in software params.
>
>
> Best Regards,
> Thanks in advance,
> Irfan...
