From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: ICE1724 - File descriptor in bad state when
	capturing
Date: Mon, 10 Mar 2008 22:39:14 +0100
Message-ID: <47D5AA82.4080009@insite.cz>
References: <47D46B01.8020009@insite.cz> <s5hk5kax2dn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BF80103808
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 22:39:20 +0100 (CET)
In-Reply-To: <s5hk5kax2dn.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sun, 09 Mar 2008 23:56:01 +0100,
> Pavel Hofman wrote:
>> Hi,
>>
>> I have most of the ESI Juli driver working, but I have hit a problem 
>> with the capture stream. I had to modify some ice1724.c code to allow 
>> redefining clock-related functions in the actual card file (Juli has a 
>> different clocking scheme), but all the DMA code is left intact, as well 
>> as the methods defining the capture stream.
>>
>> The ice1724 vu-meters detect input ADC data, I can hear correct sound 
>> when setting the internal mixer to H/W-In. Yet, when trying to record, I get
>>
>> arecord -v -D hw:0,0,0 -r 44100 -f S32_LE -c2
>>
>> ....
>> RIFF$WAVEfmt  ... data arecord: pcm_read:1346: read error: File 
>> descriptor in bad state
> 
> It's -EBADFD and indicates that the PCM state isn't the expected one,
> in this case, SNDRV_PCM_STATE_PREPARED or RUNNING.
> The error comes from snd_pcm_capture_ioctl1() in core/pcm_native.c.
> Not sure what is broken, but this should be the starting point.
> 
> 
> Takashi

Takashi,

Thanks for the hint. I have found the following:

For the working capture (spdif input in my case), the function 
snd_pcm_lib_read1 gets called first with SNDRV_PCM_STATE_PREPARED, and 
consequently repeatedly with SNDRV_PCM_STATE_RUNNING.

strace arecord :
...
write(1, "data\0\0\0\200", 8data)           = 8
ioctl(4, 0x800c4151, 0xbfbf5310)        = 0
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16384) = 16384
ioctl(4, 0x800c4151, 0xbfbf5310)        = 0
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16384) = 16384
...

Whereas for the broken analog input, the sequence is

1. snd_pcm_lib_read1 with SNDRV_PCM_STATE_PREPARED - returns 0
2. snd_pcm_lib_read1 with SNDRV_PCM_STATE_SETUP - returns -EBADFD

strace arecord:

write(1, "data\0\0\0\200", 8data)           = 8
ioctl(4, 0x800c4151, 0xbfa6cff0)        = 0
poll([{fd=4, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN|POLLERR}], 
1, 1000) = 1
ioctl(4, 0x800c4151, 0xbfa6cff0)        = -1 EBADFD (File descriptor in 
bad state)
write(2, "arecord: pcm_read:1346: ", 24arecord: pcm_read:1346: ) = 24

The broken input falls to polling - is it somehow blocked?

Thanks a lot for further hints.

Pavel.
