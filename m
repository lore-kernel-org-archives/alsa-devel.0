From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] alsa-plugins: Pulse: only underrun if no
 more data has been written
Date: Thu, 25 Aug 2011 08:17:17 +0200
Message-ID: <4E55E8ED.8010106@canonical.com>
References: <4E4D2A67.9050507@canonical.com> <s5hobzllubm.wl%tiwai@suse.de>
	<4E4E31A5.2090100@canonical.com> <s5hliup7emd.wl%tiwai@suse.de>
	<4E53958A.5050602@canonical.com> <s5hbovgp7p4.wl%tiwai@suse.de>
	<CAN8cciZ046qj=2aaa0ETgCXtrOhu5Z8+p_dFNPjJ199vXtA7RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id CF44410380B
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 08:17:18 +0200 (CEST)
In-Reply-To: <CAN8cciZ046qj=2aaa0ETgCXtrOhu5Z8+p_dFNPjJ199vXtA7RQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/25/2011 07:53 AM, Raymond Yau wrote:
> 2011/8/23 Takashi Iwai<tiwai@suse.de>:
>   be enough just to have a
>> boolean for underrun_detect yes/no.
>>
>> So, the patch would be like below.
>>
>> What do you think?
>>
>>
>> Takashi
>>
>> ---
>> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
>> index d6c6792..b0e52ab 100644
>> --- a/pulse/pcm_pulse.c
>> +++ b/pulse/pcm_pulse.c
>> @@ -42,6 +42,7 @@ typedef struct snd_pcm_pulse {
>>         int handle_underrun;
>>
>>         size_t offset;
>> +       int64_t written;
>>
>>         pa_stream *stream;
>>
>> @@ -460,6 +461,7 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug_t * io,
>>
>>         /* Make sure the buffer pointer is in sync */
>>         pcm->last_size -= writebytes;
>> +       pcm->written += writebytes;
>>         ret = update_ptr(pcm);
>>         if (ret<  0)
>>                 goto finish;
>> @@ -585,6 +587,15 @@ static void stream_request_cb(pa_stream * p, size_t length, void *userdata)
>>         update_active(pcm);
>>   }
>>
>> +#if defined(PA_CHECK_VERSION)&&  PA_CHECK_VERSION(0,99,0)
>
> compile fail at these line since PA_CHECK_VERSION is not defined in
> pulseaudio 0.9.14

I don't have PA 0.9.14 available, but that's why the line starts with 
"if defined(PA_CHECK_VERSION)" so that the second part should never be 
evaluated.

> seem that pcm->wriiten is application pointer of pulse device in bytes
>
> does it mean that pa_stream_get_underflow_index(0 is the hardware pointer ?
>
> does it mean that pulse device no longer can be run 7 x 24 non-stop
> since pcm->written may overflow ?

Hmm. It's an int64, so your computer is likely to break down before 
there is a wraparound, but perhaps there is a slight chance that the 
comparision will be wrong if there is an underrun at the exact 
wraparound moment.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
