From: Alan Young <Alan.Young@IEE.org>
Subject: Re: [PATCH RESEND] pcm_rate: Do not discard slave
 reported delay in status result.
Date: Tue, 13 Dec 2016 11:43:04 +0000
Message-ID: <372cbe9d-2456-75e0-cdaf-056df21a4b31@IEE.org>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
 <52e39131-9141-b466-e92a-ff19ffab6d3a@IEE.org> <s5hshqb5sj1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id B16BE261A1A
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 12:43:06 +0100 (CET)
Received: by mail-wm0-f53.google.com with SMTP id t79so115884571wmt.0
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 03:43:06 -0800 (PST)
In-Reply-To: <s5hshqb5sj1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry for the delay. I too got sidetracked by other work.

On 28/11/16 19:11, Takashi Iwai wrote:
>> >@@ -1083,15 +1115,17 @@ static int snd_pcm_rate_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
>> >  			status->state = SND_PCM_STATE_RUNNING;
>> >  		status->trigger_tstamp = rate->trigger_tstamp;
>> >  	}
>> >-	snd_pcm_rate_sync_hwptr(pcm);
>> >+	snd_pcm_rate_sync_hwptr0(rate, status->hw_ptr);
> This can't work.
>
> I can fix it in my side, but OTOH, this made me wonder how you tested
> the patch...

Why do you think that cannot work? I am pretty sure it is working just 
fine for us but I am sure that it is possible that I have missed something.

>> >  	status->appl_ptr = *pcm->appl.ptr;
>> >  	status->hw_ptr = *pcm->hw.ptr;
>> >  	if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
>> >-		status->delay = snd_pcm_mmap_playback_hw_avail(pcm);
>> >+		status->delay = rate->ops.input_frames(rate->obj, status->delay)
>> >+					+ snd_pcm_rate_playback_internal_delay(pcm);
>> >  		status->avail = snd_pcm_mmap_playback_avail(pcm);
>> >  		status->avail_max = rate->ops.input_frames(rate->obj, status->avail_max);
>> >  	} else {
>> >-		status->delay = snd_pcm_mmap_capture_hw_avail(pcm);
>> >+		status->delay = rate->ops.output_frames(rate->obj, status->delay)
>> >+					+ snd_pcm_mmap_capture_hw_avail(pcm);
>> >  		status->avail = snd_pcm_mmap_capture_avail(pcm);
>> >  		status->avail_max = rate->ops.output_frames(rate->obj, status->avail_max);
> Why only playback needs the special handling while the capture
> doesn't?  Again, some comments would be helpful for better
> understanding your changes.
>

I expect that it could be useful to do something similar with capture 
but I could not work out what would be needed. OTOH, I think that the 
way that capture is used, and the way the underlying audio drivers tend 
to deal with this issue for capture is such that it may not be of much 
value.

I agree that comments are good. In general I was trying to stick with 
the pretty minimal-comment style of the existing code.

Alan.
