From: "F. Heitkamp" <heitkamp-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [LAU] [alsa-devel] Crash 2.6.32.x, Echo 3G, Alsa, SCSI
Date: Mon, 31 May 2010 15:05:08 -0400
Message-ID: <4C040864.8010205@ameritech.net>
References: <73211.74714.qm@web180714.mail.sp1.yahoo.com>
	<4B684513.8090201@ladisch.de> <20100202230911.71e8b600@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <20100202230911.71e8b600@Jay>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Giuliano Pochini <pochini-JrPinEReyO8@public.gmane.org>, linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org, alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 02/02/10 17:09, Giuliano Pochini wrote:
> On Tue, 02 Feb 2010 16:30:27 +0100
> Clemens Ladisch<clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>  wrote:
>
>    
>> Frederick V Heitkamp wrote:
>>      
>>> Repeatable Hard Crash.
>>> What else do I need to provide?
>>>
>>> [ 5484.995249] WriteControlReg: not written, no change
>>> [ 5485.069621] divide error: 0000 [#1] pcm_hw_params ok
>>> [ 5485.070159] Prepare rate=44100 format=2 channels=2
>>> [ 5485.070161] set_audio_format[14] = 5
>>> [ 5485.070166] Prepare rate=44100 format=2 channels=2
>>> [ 5485.070167] set_audio_format[14] = 5
>>> [ 5485.070003] PREEMPT SMP
>>> ...
>>> [ 5485.070003] EIP is at pcm_pointer+0x37/0x70 [snd_echo3g]
>>> ...
>>> [ 5485.965788]  [<c10041c0>] ? do_divide_error+0x0/0x90
>>> [ 5485.980619]  [<f87aa037>] ? pcm_pointer+0x37/0x70 [snd_echo3g]
>>> [ 5485.998047]  [<c104764e>] ? run_timer_softirq+0x17e/0x2e0
>>> [ 5486.014175]  [<f87ac9bf>] ? snd_echo_interrupt+0x11f/0x240 [snd_echo3g]
>>> [ 5486.033940]  [<c107a5d5>] ? handle_IRQ_event+0x45/0x190
>>>        
>> bytes_to_frames() divides by runtime->frame_bits which is not set until
>> after the hw_params callback has succeeded, but the corresponding
>> chip->substream[] entry is set in that callback, by init_engine().  It
>> should probably have been set in the prepare callback.
>>      
> I've just had another look at my code. Although it never happened to me, it
> is indeed possible when hw_params() completes if another substream is
> already running. The reason is that the card delivers an irq when it
> executes an irq instruction in any of the running s-g lists. The irq
> handler cannot know which substream caused it, so it has to call the
> pointer() function for each of the configured substreams (ie. the ones
> which completed one of the pcm_*_hw_params() callbacks.
>
> There is another possible fix. I tested it briefly. It looks ok wrt race
> conditions because pipe->state is set only in the trigger callback. I hope
> I didn't overlook anything again...
>
>
> Signed-off-by: Giuliano Pochini<pochini-JrPinEReyO8@public.gmane.org>
>
> --- alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c__orig	2010-02-02 22:37:33.000000000 +0100
> +++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c	2010-02-02 22:44:03.000000000 +0100
> @@ -1821,7 +1821,9 @@ static irqreturn_t snd_echo_interrupt(in
>   	/* The hardware doesn't tell us which substream caused the irq,
>   	thus we have to check all running substreams. */
>   	for (ss = 0; ss<  DSP_MAXPIPES; ss++) {
> -		if ((substream = chip->substream[ss])) {
> +		substream = chip->substream[ss];
> +		if (substream&&  ((struct audiopipe *)substream->runtime->
> +				private_data)->state == PIPE_STATE_STARTED) {
>   			period = pcm_pointer(substream) /
>   				substream->runtime->period_size;
>   			if (period != chip->last_period[ss]) {
>
>
>    
I've tried some newer kernels.  Still having problems with the echo 3G.  
This is kernel version:
2.6.32.13.  The above patches posted to the linux kernel list seemed to 
get rid of the crashes, but evidently did not go into the main kernel tree.
Any help appreciated.  I am willing to help to the best of my ability. 
Thanks!

Fred

This segment keeps looping to infinity:
[ 9331.528043] pcm_hw_free(0)
[ 9331.529200] free_pipes: Pipe 0
[ 9331.545230] pcm_hw_freed
[ 9331.552808] pcm_hw_freed
[ 9331.560365] pcm_close
[ 9331.567145] pcm_close  oc=0  cs=1  rs=1
[ 9331.578595] pcm_close2 oc=0  cs=1  rs=0
[ 9490.665630] pcm_analog_out_open
[ 9490.675009] max_channels=6
[ 9490.683109] pcm_analog_out_open  cs=1  oc=1  r=44100
[ 9490.698046] allocate_pipes: ch=0 int=2
[ 9490.702428] allocate_pipes: ok
[ 9490.718350] allocate_pipes()=0
[ 9490.727466] pcm_hw_params (bufsize=131072B periods=2 persize=65536B)
[ 9490.746450] SetSampleRate: 44100 clock d63
[ 9490.756870] WriteControlReg: Setting 0xd63, 0x3bfe
[ 9490.768468] WriteControlReg: not written, no change
[ 9490.787532] pcm_hw_params ok
[ 9490.796155] Prepare rate=44100 format=2 channels=2
[ 9490.810464] set_audio_format[0] = 5
[ 9490.820922] Prepare rate=44100 format=2 channels=2
[ 9490.835233] set_audio_format[0] = 5
[ 9490.845758] pcm_trigger start
[ 9490.847582] start_transport 1
[ 9497.317297] pcm_trigger stop
[ 9497.318517] stop_transport 1
[ 9497.334516] pcm_hw_free(0)
[ 9497.335483] free_pipes: Pipe 0
[ 9497.351709] pcm_hw_freed
[ 9497.359278] pcm_hw_freed
[ 9497.366836] pcm_close
[ 9497.373613] pcm_close  oc=0  cs=1  rs=1
[ 9497.385061] pcm_close2 oc=0  cs=1  rs=0
[ 9503.442232] pcm_analog_out_open
[ 9503.451611] max_channels=6
[ 9503.459713] pcm_analog_out_open  cs=1  oc=1  r=44100
[ 9503.474663] allocate_pipes: ch=0 int=2
[ 9503.484394] allocate_pipes: ok
[ 9503.494962] allocate_pipes()=0
[ 9503.504081] pcm_hw_params (bufsize=131072B periods=2 persize=65536B)
[ 9503.523069] SetSampleRate: 44100 clock d63
[ 9503.532174] WriteControlReg: Setting 0xd63, 0x3bfe
[ 9503.545805] WriteControlReg: not written, no change
[ 9503.564143] pcm_hw_params ok
[ 9503.572765] Prepare rate=44100 format=2 channels=2
[ 9503.587074] set_audio_format[0] = 5
[ 9503.597490] Prepare rate=44100 format=2 channels=2
[ 9503.611839] set_audio_format[0] = 5
[ 9503.622355] pcm_trigger start
[ 9503.623236] start_transport 1
[ 9510.095872] pcm_trigger stop
[ 9510.096578] stop_transport 1
[ 9510.113193] pcm_hw_free(0)
[ 9510.114163] free_pipes: Pipe 0
[ 9510.130405] pcm_hw_freed
[ 9510.137982] pcm_hw_freed
[ 9510.145541] pcm_close
[ 9510.152317] pcm_close  oc=0  cs=1  rs=1
