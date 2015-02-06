From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [PATCH v3 kernel 2/3] Extend snd_pcm_ops and
	snd_pcm_runtime
Date: Fri, 06 Feb 2015 17:25:01 +0000
Message-ID: <54D4F8ED.503@eml.cc>
References: <1423239388-17745-1-git-send-email-timcussins@eml.cc>
 <1423239388-17745-2-git-send-email-timcussins@eml.cc>
 <54D4EE15.1010704@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6F7802652AE
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 18:25:08 +0100 (CET)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 0D55D20929
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 12:25:08 -0500 (EST)
In-Reply-To: <54D4EE15.1010704@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 06/02/15 16:38, Pierre-Louis Bossart wrote:
> On 02/06/2015 10:16 AM, Tim Cussins wrote:
>> snd_pcm_ops picks up methods for:
>>
>> - start_at - start_at_abort - start_at_gettime
>>
>> For startat requests involving audio hardware clocks, ALSA core
>> delegates to the driver using these methods, should they exist.
>>
>> snd_pcm_runtime gains fields that contain the current state of the
>> startat timer, if any. This allows cancellation and querying.
>>
>> Signed-off-by: Tim Cussins <timcussins@eml.cc>
>>
>> diff --git a/include/sound/pcm.h b/include/sound/pcm.h index
>> 07299b2..a414fec 100644 --- a/include/sound/pcm.h +++
>> b/include/sound/pcm.h @@ -73,6 +73,9 @@ struct snd_pcm_ops {
>> snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *substream);
>> int (*wall_clock)(struct snd_pcm_substream *substream, struct
>> timespec *audio_ts); +	int (*start_at)(struct snd_pcm_substream
>> *substream, int startat_clock_type, const struct timespec *ts); +
>> int (*start_at_abort)(struct snd_pcm_substream *substream); +	int
>> (*start_at_gettime)(struct snd_pcm_substream *substream, int
>> startat_clock_type, struct timespec *current_time);
>
> What is the purpose of this _gettime? If the app relies on regular
> system time then it doesn't need to use this and if it relies on the
> link then doesn't this routine duplicate the audio timestamp stuff i
> am still working on.

This patch is written to stand on its own, without timestamping 
evolutions. Once your patch is in, this patch would be rebased on your 
work :)

>> int (*copy)(struct snd_pcm_substream *substream, int channel,
>> snd_pcm_uframes_t pos, void __user *buf, snd_pcm_uframes_t count);
>> @@ -368,6 +371,12 @@ struct snd_pcm_ runtime { #ifdef
>> CONFIG_SND_PCM_XRUN_DEBUG struct snd_pcm_hwptr_log *hwptr_log;
>> #endif + +	bool startat_timer_running; +	/* The following values
>> are valid if startat_timer_running == true */ +	int
>> startat_clock_type;			/* startat clock type of current timer */ +
>> struct timespec startat_start_time;	/* start time of current timer
>> */ +	void* startat_timer_data;		/* data associated with current
>> timer */ };
>>
>> struct snd_pcm_group {		/* keep linked substreams */
>>
>
