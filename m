From: Markus Korber <korbse@gmx.at>
Subject: Re: period_size and relation to number of samples
Date: Mon, 10 Sep 2007 10:28:57 +0200
Message-ID: <6zy7fe53g6.fsf@odpc25.int.ondemand.co.at>
References: <6zps0wwday.fsf@odpc25.int.ondemand.co.at>
	<s5hsl5r6gwk.wl%tiwai@suse.de> <46E00EF9.2070607@gmx.at>
	<s5hlkbj6eab.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 1D05324362
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 10:29:01 +0200 (CEST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thus spake Takashi Iwai:

> At Thu, 06 Sep 2007 16:30:17 +0200,
> Markus Korber wrote:
>
>> Thus, is it possible to buffer the data in ALSA before sending them to
>> the driver, in such a way, that the driver always receives period_size
>> samples, regardless of what the application sends to ALSA?  And how
>> would I configure ALSA for such a setup?
>
> No, it's NOT guaranteed.  The application may behave in a very wrong
> manner.
>
> The point is that it's driver's responsibility to check whether the
> data filled is OK or not.  The ALSA framework is not a style like
> "fill -> wakeup -> process".  Instead, the data transfer is done
> asynchronously, and the driver is woken up via irq (or whatever).

Thanks for clarification.  However, one more question: The application
always delivers 0x1200 bytes to ALSA via snd_pcm_mmap_writei() but my
driver receives the following (buffer_size=0x4000, period_size=0x2000):

(bufnum refers to buffer 0 or 1 of my two output buffers.)

,----[ 0 ]
| Entered chip_playback_copy (bufnum: 0 -> src: 0xffce1000, bytes: 0x2400)
| Entered chip_playback_copy (bufnum: 0 -> src: 0xffce3400, bytes: 0x1200)
| 
| Entered chip_playback_copy (bufnum: 1 -> src: 0xffce4600, bytes: 0x0a00)
| Entered chip_playback_copy (bufnum: 1 -> src: 0xffce1000, bytes: 0x0800)
| Entered chip_playback_copy (bufnum: 1 -> src: 0xffce1800, bytes: 0x1200)
| 
| Entered chip_playback_copy (bufnum: 0 -> src: 0xffce2a00, bytes: 0x1200)
| Entered chip_playback_copy (bufnum: 0 -> src: 0xffce3c00, bytes: 0x1200)
| 
| Entered chip_playback_copy (bufnum: 1 -> src: 0xffce4e00, bytes: 0x0200)
| Entered chip_playback_copy (bufnum: 1 -> src: 0xffce1000, bytes: 0x1000)
| 
| Entered chip_playback_copy (bufnum: 0 -> src: 0xffce2000, bytes: 0x1200)
| Entered chip_playback_copy (bufnum: 0 -> src: 0xffce3200, bytes: 0x1200)
| 
| Entered chip_playback_copy (bufnum: 1 -> src: 0xffce4400, bytes: 0x0c00)
| Entered chip_playback_copy (bufnum: 1 -> src: 0xffce1000, bytes: 0x0600)
| Entered chip_playback_copy (bufnum: 1 -> src: 0xffce1600, bytes: 0x1200)
`----

Now, I'm using the pcm-indirect framework[1] and my hw_ptr always
toggles between 0 and period_bytes[2].

,----[ 1 ]
| static snd_pcm_uframes_t
|         chip_pcm_pointer(struct snd_pcm_substream *substream)
| {
|         ...
|         return snd_pcm_indirect_playback_pointer(substream, &chip->playback,
|                prtd->playback_hw_ptr);
| }
`----

,----[ 2 ]
| if (bufnum == 0)
|         prtd->playback_hw_ptr = 0;
| else
|         prtd->playback_hw_ptr = prtd->period_bytes;
`----

This is what the application does[3] (for logging see [4]):

,----[ 3 ]
| while( number_of_frames > 0) {
|    if ( (state == SND_PCM_STATE_RUNNING) ) {
|       snd_pcm_status(this->audio_fd, pcm_stat);
|       
|       num_avail = snd_pcm_status_get_avail(pcm_stat);
|       printf("audio_alsa_out: #avail: %#04x\n", num_avail);
| 
|       if (num_avail < number_of_frames) {
|          wait_result = snd_pcm_wait(this->audio_fd, 1000);
|          printf("audio_alsa_out:write:loop:wait_result=%d\n",wait_result);
|          if (wait_result <= 0) return 0;
|       }      
|    }
|    
|    printf ("audio_alsa_out: writing %#04x samples to ALSA\n", number_of_frames);
|    result = snd_pcm_mmap_writei(this->audio_fd, buffer, number_of_frames);
|    ...
`----

>From my understanding the application blocks until it can send new data.
However, although the application always delivers 0x1200 bytes to ALSA,
my driver receives different amount of data.  Why?  Is there some
buffering in ALSA?  

Secondly, although my period_size is 0x2000 bytes, why do I receive for
example 0x0a00+0x0800+0x1200=0x2400 bytes (see [0]) or 0x1200 bytes and
not at most 0x2000 bytes?

Thirdly, how is the value returned by snd_pcm_status_get_avail()
determined?  I mean, if my pointer always toggles between 0 and
period_bytes[2], how can ALSA return the values logged below [4]?  

(Here 1 sample equals 4 bytes, S16_LE, stereo.)

,----[ 4 ]
| loop: writing 0x480 samples to sound device
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: #avail: 0x700
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: #avail: 0xa80
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: #avail: 0xe00
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: #avail: 0x980
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: #avail: 0x500
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: #avail: 0x80
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: #avail: 0x400
| audio_alsa_out: writing 0x480 samples to ALSA
| 
| loop: writing 0x480 samples to sound device
| audio_alsa_out: #avail: 0x780
| audio_alsa_out: writing 0x480 samples to ALSA
`----

Thanks in advance.

Regards,
Markus Korber
