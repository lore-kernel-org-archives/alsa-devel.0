From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Fixes: Re: intel8x0 has stopped working.
Date: Tue, 03 Feb 2004 22:21:51 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40201EFF.9000903@superbug.demon.co.uk>
References: <401E8BAE.6010802@superbug.demon.co.uk> <s5hn081uztv.wl@alsa2.suse.de> <401EA82D.3060702@superbug.demon.co.uk> <401ED94F.7080407@superbug.demon.co.uk> <Pine.LNX.4.58.0402031720190.8251@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA02629
	for <alsa-devel@alsa-project.org>; Tue, 3 Feb 2004 23:15:26 +0100
In-Reply-To: <Pine.LNX.4.58.0402031720190.8251@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 2 Feb 2004, James Courtier-Dutton wrote:
> 
> 
>>James Courtier-Dutton wrote:
>>
>>>Once thing I have noticed, is that with the alc650, we used to have VRA 
>>>(alsa 0.9.8), but the 1.0.2 intel8x0 driver ignores the VRA and fixes 
>>>itself at 48000.
>>>So, before I never needed the sample rate converters, but as it now 
>>>fixes the rate at 48000, I need the sample rate converters, and they 
>>>don't actually work.
>>>
>>>
>>
>>I have found out what the problem is with the resamplers not working.
>>I was using: -
>>err = snd_pcm_sw_params_set_start_threshold(handle, swparams, 
>>buffer_size);  <- note buffer_size.
>>
>>So, the state will stay in SND_PCM_STATE_PREPARED state until the buffer 
>>is full.
>>Inside snd_pcm_write_areas() [in alsa-lib] we have a snd_pcm_wait 
>>statement before we write frames into the buffer.
>>if (((snd_pcm_uframes_t)avail < pcm->avail_min && size > 
>>(snd_pcm_uframes_t)avail) || (size >= pcm->xfer_align && 
>>(snd_pcm_uframes_t)avail < pcm->xfer_align)) {
>>then it calls snd_pcm_wait()
>>
>>So, this will call snd_pcm_wait() until avail >= pcm->avail_min.
>>This will only become true if we are in SND_PCM_STATE_RUNNING state.
>>
>>below the snd_pcm_wait(), we do try to execute snd_pcm_start() to get us 
>>into SND_PCM_STATE_RUNNING, but this only gets executed if: -
>>if (state == SND_PCM_STATE_PREPARED && hw_avail >= (snd_pcm_sframes_t) 
>>pcm->start_threshold) {
>>
>>So, we will only reach a running state if the buffer is FULL, but the 
>>buffer will NEVER become full, because of the previous snd_pcm_wait();
>>CATCH22!!!
>>
>>I think a fix to this would be to limit as follows: -
>>start_threshold <= (buffer_size - avail_min)
>>
>>I have fixed the issue for now, just by setting the "start_threshold" to 
>>something other than buffer_size. But I think some work needs to be done 
>>with alsa-lib to prevent this deadlock situation ever happening in alsa-lib.
>>
>> From the application writers point of view, if the buffer is X bytes 
>>long, and one used snd_pcm_writei() to write X+10 bytes, the buffer 
>>should become full. Currently, that is not always the case, and alsa-lib 
>>instead locks in snd_pcm_wait().
>>
>>I attach a patch that fixes alsa-lib.
>>All it does it call snd_pcm_start() just before snd_pcm_wait() and due 
>>to the if statement just above it, will only happen when the buffer is 
>>going to be filled, therefore ensuring that even if "start_threshold" is 
>>set too high, snd_pcm_start() will always be called if the buffer is 
>>full, or about to become full.
> 
> 
> I don't think that this is a right fix. The programmer must know what is 
> doing and the manual start is still alternative. You must set 
> start_threshold to (buffer_size / period_size) * period_size in your case.
> 
> 						Jaroslav
> 
A don't think this is an application programmer bug. After all your 
program alsa-lib/test/pcm.c had it set to start_threshold==buffer_size, 
and you are one of the main alsa developers. So if you thought that was 
an OK thing to set, why won't other people?
My point is, I don't think setting start_threshold to buffer_size is 
even "wrong" at all. Some people might want the buffer to be full before 
it starts, and my patch allows for that.

I don't think my patch breaks anything.
Maybe you should look deeper, and work out exactly which situation it 
will happen in.
My patch only executes snd_pcm_start() if the previous snd_pcm_writei() 
would in fact fill the buffer.

You have a snd_pcm_start() later on that executes if one passes the 
start_threshold.

The only situation it would break is if the application wants to fill 
the buffer and for some reason not start playing. If you conceptually 
want to allow for that, then I will accept that my patch breaks that 
behaviour.

Cheers
James


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
