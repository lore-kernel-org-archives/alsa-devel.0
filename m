From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH RFC 5/9] ALSA: core: selection of
 audio_tstamp type and accuracy reports
Date: Wed, 10 Dec 2014 11:27:26 -0600
Message-ID: <5488827E.4030403@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1418077426-8309-6-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hsignmphw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EB14260594
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 18:32:32 +0100 (CET)
In-Reply-To: <s5hsignmphw.wl-tiwai@suse.de>
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

On 12/10/14, 10:35 AM, Takashi Iwai wrote:
> Just a minor issue before going to detailed review:
>
> At Mon,  8 Dec 2014 16:23:42 -0600,
> Pierre-Louis Bossart wrote:
>>
>> +/* user space provides config to kernel */
>> +struct snd_pcm_audio_tstamp_config {
>> +	__u32 type_requested:4;
>> +	__u32 report_delay:1; /* add total delay to A/D or D/A */
>> +};
> ....
>> +/* kernel provides report to user-space */
>> +struct snd_pcm_audio_tstamp_report {
>> +	/* actual type if hardware could not support requested timestamp */
>> +	__u32 actual_type:4;
>> +
>> +	/* accuracy represented in mantissa/exponent form */
>> +	__u32 accuracy_report:1; /* 0 if accuracy unknown, 1 if rest of structure is valid */
>> +	__u32 accuracy_m:7; /* 0..127, ~3 significant digit for mantissa */
>> +	__u32 accuracy_e:4; /* base10 exponent, 0 for ns, 3 for us, 6 for ms, 9 for s */
>> +};
>
> Please avoid the bit fields in these, since these values will be a
> part of ABI.  There is absolutely no compatibility when you're using
> bitfields.  Use the explicit bit operations.

Those definitions are not used as part of the kernel/user interaction, I 
did use pack/unpack operations as requested in previous reviews. see 
snd_pcm_unpack_tstamp_config and snd_pcm_pack_audio_tstamp_report.
A similar pack/unpack operation is provided in the alsa-lib patches
The data is exchanged using the reclaimed 32-bit word only.

Would that work?

>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
