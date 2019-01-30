From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] ALSA: pcm: implement the anonymous dup
 (inode file descriptor)
Date: Wed, 30 Jan 2019 09:07:08 +0100
Message-ID: <4c7d6f77-27b9-f353-6c0f-1dfefd650a72@perex.cz>
References: <20190129175909.17423-1-perex@perex.cz>
 <20190129175909.17423-2-perex@perex.cz> <s5h4l9rfgmb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 02E7626749A
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 09:07:14 +0100 (CET)
In-Reply-To: <s5h4l9rfgmb.wl-tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Dne 29.1.2019 v 19:44 Takashi Iwai napsal(a):
> On Tue, 29 Jan 2019 18:59:07 +0100,
> Jaroslav Kysela wrote:
>>
>> This patch implements new SNDRV_PCM_IOCTL_ANONYMOUS_DUP ioctl which
>> returns the new duplicated anonymous inode file descriptor
>> (anon_inode:snd-pcm) which can be passed to the restricted clients.
>>
>> This patch is meant to be the alternative for the dma-buf interface. Both
>> implementation have some pros and cons:
>>
>> anon_inode:dmabuf
>>
>> - a bit standard export API for the DMA buffers
>> - fencing for the concurrent access [1]
>> - driver/kernel interface for the DMA buffer [1]
>> - multiple attach/detach scheme [1]
>>
>> [1] the real usage for the sound PCM is unknown at the moment for this feature
>>
>> anon_inode:snd-pcm
>>
>> - simple (no problem with ref-counting, non-standard mmap implementation etc.)
>> - allow to use more sound interfaces for the file descriptor like status ioctls
>> - more fine grained security policies (another anon_inode name unshared with
>>   other drivers)
> 
> Your sign-off seems missing.

Fixed now. Thanks.

>> @@ -999,15 +1002,19 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
>>  	}
>>  
>>  	if (file->f_flags & O_APPEND) {
>> -		if (prefer_subdevice < 0) {
>> -			if (pstr->substream_count > 1)
>> -				return -EINVAL; /* must be unique */
>> -			substream = pstr->substream;
>> +		if (clone) {
>> +			substream = clone;
>>  		} else {
>> -			for (substream = pstr->substream; substream;
>> -			     substream = substream->next)
>> -				if (substream->number == prefer_subdevice)
>> -					break;
>> +			if (prefer_subdevice < 0) {
>> +				if (pstr->substream_count > 1)
>> +					return -EINVAL; /* must be unique */
>> +				substream = pstr->substream;
>> +			} else {
>> +				for (substream = pstr->substream; substream;
>> +				     substream = substream->next)
>> +					if (substream->number == prefer_subdevice)
>> +						break;
>> +			}
>>  		}
>>  		if (! substream)
>>  			return -ENODEV;
> 
> So the clone case should return via this block, then...
> 
>> @@ -1018,11 +1025,18 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
>>  		return 0;
>>  	}
>>  
>> -	for (substream = pstr->substream; substream; substream = substream->next) {
>> -		if (!SUBSTREAM_BUSY(substream) &&
>> -		    (prefer_subdevice == -1 ||
>> -		     substream->number == prefer_subdevice))
>> -			break;
>> +	if (clone) {
>> +		substream = clone;
>> +		if (SUBSTREAM_BUSY(substream))
>> +			return -EAGAIN;
>> +	} else {
>> +		for (substream = pstr->substream; substream;
>> +		     substream = substream->next) {
>> +			if (!SUBSTREAM_BUSY(substream) &&
>> +			    (prefer_subdevice == -1 ||
>> +			     substream->number == prefer_subdevice))
>> +				break;
>> +		}
> 
> ... do we need to support cloning without O_APPEND?

I think that it would be better to pass the subdevice number to
snd_pcm_attach_substream(). It will reduce the required modifications.
I will change this.

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
