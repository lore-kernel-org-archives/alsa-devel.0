From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Audigy LS support.
Date: Fri, 28 May 2004 12:16:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B71F79.80502@superbug.demon.co.uk>
References: <40B63EBD.6060407@superbug.demon.co.uk> <s5hzn7ssw42.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA13508
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2004 13:16:13 +0200
In-Reply-To: <s5hzn7ssw42.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 27 May 2004 20:17:17 +0100,
> James Courtier-Dutton wrote:
> 
>>Here is my first go at Audigy LS support.
>>It can play sound to the front speakers.
> 
> 
> great!
> 
> 
> 
>>/* hardware definition */
>>static snd_pcm_hardware_t snd_audigyls_playback_hw = {
>>	.info =			(SNDRV_PCM_INFO_MMAP | 
>>				 SNDRV_PCM_INFO_INTERLEAVED |
>>				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>				 SNDRV_PCM_INFO_MMAP_VALID),
>>	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
>>	.rates =		SNDRV_PCM_RATE_48000,
>>	.rate_min =		48000,
>>	.rate_max =		48000,
>>	.channels_min =		2,
>>	.channels_max =		2,
>>	.buffer_bytes_max =	(32*1024),
>>	.period_bytes_min =	64,
>>	.period_bytes_max =	(16*1024),
>>	.periods_min =		2,
>>	.periods_max =		16,
> 
>                                 ^^
> are you sure this is ok?
> in the case of emu10k1, it generates irq twice per buffer (HALF and
> BUFFER).  then periods_max must be 2.

With periods_max set to 2, sound plays, but has artifacts. With periods 
 > 2, the sound is smooth, without any clicks etc.

> 
> 
> anyway, the driver code is quite similar with emu10k1x.c.
> i checked the diff between them and the amount of difference is really
> small.
> how about merging them?  then we can understand / maintain the codes
> better.
> 
> 
> Takashi
> 
> 

I would like to keep the two drivers separate for a bit. That way I can 
keep changing stuff without caring if the emu10k1x.c stays working.
Once I get all the features working, we could then look at merging the two.
There is still a lot to go.
1) 24bit 192khz sound out.
2) 5.1 sound.
3) Digital SPDIF output.
4) Capture.
5) MIDI.
It seems that the changing of the sample rate etc. from the default is 
done via some sort of UART.

Also, I can change how often the interrupts happen, so I will need to 
implement that.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
