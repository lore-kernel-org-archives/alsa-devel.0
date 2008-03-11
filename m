From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: ICE1724 - File descriptor in bad state when
	capturing
Date: Tue, 11 Mar 2008 20:46:08 +0100
Message-ID: <47D6E180.6070808@insite.cz>
References: <47D46B01.8020009@insite.cz> <s5hk5kax2dn.wl%tiwai@suse.de>
	<47D5AA82.4080009@insite.cz> <47D63632.60808@ladisch.de>
	<47D63D6A.10503@insite.cz> <47D6A111.8010608@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 392DA1037F7
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 20:46:23 +0100 (CET)
In-Reply-To: <47D6A111.8010608@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Clemens Ladisch wrote:
> Pavel Hofman wrote:
>> Clemens Ladisch wrote:
>>> Pavel Hofman wrote:
>>>> Whereas for the broken analog input, the sequence is
>>>>
>>>> 1. snd_pcm_lib_read1 with SNDRV_PCM_STATE_PREPARED - returns 0
>>>> 2. snd_pcm_lib_read1 with SNDRV_PCM_STATE_SETUP - returns -EBADFD
>>> I'd guess that your trigger callback fails somehow, bit this is
>>> hard to determine without the source code.
>> Thanks, I will do more testing in the evening. Just in case, I am
>> including the relevant files. I moved all rate-relevant stuff to
>> card-specific routines, redefined in juli.c. The trigger code was not
>> changed at all.
>>
>> Perhaps those new snd_pcm_hardware structs in juli.c (I do not know the
>> exact meaning of the _bytes_ ones)?
> 
> These values are in bytes (and not in frames).
> 
> It's possible that the AK4114 code stops the stream because it thinks
> that the input sample rate has changed.  Try uncommenting the printk
> in i2c/other/ak4114.c.
> 

Clemens, you are ingenious! AK4114 was wrongly hooked to the analogue 
"ice->pcm_pro" stream instead of the digital "ice->pcm" stream. It works 
now fine, thanks a lot.

Pavel.
