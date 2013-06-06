From: Johan Hellman <johan.hellman@axis.com>
Subject: Re: Timestamps using I/O Plugin
Date: Thu, 6 Jun 2013 14:54:51 +0200
Message-ID: <9A8CA64355151747A180E7910F873F1802B88CAF21@xmail3.se.axis.com>
References: <9A8CA64355151747A180E7910F873F1802B9DFC0B1@xmail3.se.axis.com>
 <9A8CA64355151747A180E7910F873F1802B88CAF20@xmail3.se.axis.com>,
 <s5hobbjsith.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 535D8261A95
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 14:54:56 +0200 (CEST)
In-Reply-To: <s5hobbjsith.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>At Thu, 6 Jun 2013 09:01:12 +0200,
>Johan Hellman wrote:
>>
>> After spending more time investigating how I would set monotonic timestamps from a new I/O plugin so that the app using ALSA lib could synchronize different audio streams I cant find that its possible!?
>>
>> Can someone please confirm that it is not possible to set monotonic timestamps using the I/O plugin SDK!?
>
>AFAIK, there is nothing special in ioplug layer but it's a matter of
>ioplug plugin instance.  If the plugin sets
>SND_PCM_IOPLUG_FLAG_MONOTONIC bit to ioplug->flags, the ioplug layer
>uses the monotonic timestamp (via clock_gettime()) instead of
>gettimeofday().  So far, no plugins in alsa-plugins provide
>SND_PCM_IOPLUG_FLAG_MONOTONIC yet, though.
>
>
>Takashi

Thanks for your reply, by enabling SND_PCM_IOPLUG_FLAG_MONOTONIC the ioplug 
would return a monotonic timestamp if requested by calling snd_pcm_htimestamp()
but it would be the current timestamp i.e. change every time you call ..htimestamp() 
and not be related to the last buffer update or anything(within ALSA) actually??. 
And there would be no timestamp information in the snd_pcm_status_t returned by 
snd_pcm_status() or am i missing something?  

What i found in the implementation for the ioplug layer(snd_pcm_ioplug_status) 
was that the status struct was memset to 0 but the tstamp is not set, so 0 
is returned as a monotonic timestamp.

Would a change similar to what i wrote in my previus post regarding adding the 
possibility for the plugin to override ..htimestamp() and the ioplug layer to 
update tstamp in the status struct using that function (if available)?

/JohanHellman
