From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: Meaning of "drain" function
Date: Mon, 25 Mar 2002 15:43:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0203251530260.38362-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi folks,


after processing all periods of DMA buffer (at the end of each calling
snd_pcm_period_elapsed()) I leave last DMA callback. Then
snd_pcm_playback_drain() function is entered and waiting on (10*HZ)
timeout started. This timed out everytime. This means, that state of that
stream is set to EXPIRED and everything ends with error message. Detailed
listing of debug messages follows at the end of mail.

I know, that schedule_timeout() could be interrupted, but I don't know
how I should do that. Are there some actions, that must be undertaken to
get next DMA buffer for transmission?

2Jaroslav: Please, should you commit my changes to CVS so others could
help me.

Thanks

Listing:

playback_open
audio_init
set_samplerate rate: 44100
l3_configure fs: 256 format: 1
set_samplerate done (new rate: 44100)
dma_reset
stop_dma stop + clear done ...
playback_ioctl
hw_params
playback_prepare
set_samplerate rate: 8000
l3_configure fs: 512 format: 1
set_samplerate done (new rate: 8000)
playback_ioctl
playback_trigger
pcm_trigger id: 0 cmd: 1
  sound: 2 x 8000 [Hz]
  periods: 4 x 1000 [fr]
  buffer_size: 4000 [fr]
  dma_addr c0e68000
process_dma
  sending period 4 (dma_size[B]: 4000  offset[B]: 000000)... OK
  sending period 3 (dma_size[B]: 4000  offset[B]: 004000)... OK
  sending period 2 (dma_size[B]: 4000  offset[B]: 008000)...
pcm_trigger done
playback_pointer
get_dma_pos 704 -> 176 [fr]
  hw_ptr_interrupt: 00000000
  updated pos [fr]: 176
dma_callback
  -> period done (still pending 1) <-
playback_pointer
get_dma_pos 4288 -> 1072 [fr]
  hw_ptr_interrupt: 00000000
  updated pos [fr]: 1072
process_dma
  sending period 2 (dma_size[B]: 4000  offset[B]: 008000)... OK
  sending period 1 (dma_size[B]: 4000  offset[B]: 012000)...
dma_callback done
playback_pointer
get_dma_pos 5272 -> 1318 [fr]
  hw_ptr_interrupt: 000003e8
  updated pos [fr]: 1318
dma_callback
  -> period done (still pending 1) <-
playback_pointer
get_dma_pos 8304 -> 2076 [fr]
  hw_ptr_interrupt: 000003e8
  updated pos [fr]: 2076
process_dma
  sending period 1 (dma_size[B]: 4000  offset[B]: 012000)... OK
dma_callback done
playback_pointer
get_dma_pos 9128 -> 2282 [fr]
  hw_ptr_interrupt: 000007d0
  updated pos [fr]: 2282
dma_callback
  -> period done (still pending 1) <-
playback_pointer
get_dma_pos 12296 -> 3074 [fr]
  hw_ptr_interrupt: 000007d0
  updated pos [fr]: 3074
process_dma
dma_callback done
playback_pointer
get_dma_pos 12912 -> 3228 [fr]
  hw_ptr_interrupt: 00000bb8
  updated pos [fr]: 3228
dma_callback
  -> period done (still pending 0) <-
playback_pointer
get_dma_pos 16000 -> 4000 [fr]
  hw_ptr_interrupt: 00000bb8
  updated pos [fr]: 4000
process_dma
dma_callback done
waiting in drain .....
timed out in drain ...
ALSA ../alsa-kernel/core/pcm_native.c:1087: playback drain error (DMA or
IRQ trouble?)
playback_pointer
get_dma_pos 16000 -> 4000 [fr]
  hw_ptr_interrupt: 00000fa0
  updated pos [fr]: 4000
playback_trigger
pcm_trigger id: 0 cmd: 0
  sound: 2 x 8000 [Hz]
  periods: 4 x 1000 [fr]
  buffer_size: 4000 [fr]
  dma_addr c0e68000
stop_dma stop + clear done ...
pcm_trigger done
hw_free
hw_free
playback_close


And here is (modified) part of snd_pcm_playback_drain() function:

	while (1) {
		set_current_state(TASK_INTERRUPTIBLE);
		if (signal_pending(current)) {
			state = SIGNALED;
			break;
		}
		spin_unlock_irq(&runtime->lock);
                printk("waiting in drain .....\n");
		if (schedule_timeout(10 * HZ) == 0) {
                        printk("timed out in drain ...\n");
			spin_lock_irq(&runtime->lock);
			state = runtime->status->state ==
			SNDRV_PCM_STATE_SUSPENDED ? SUSPENDED : EXPIRED;
			break;
		}
		spin_lock_irq(&runtime->lock);
		if (runtime->status->state != SNDRV_PCM_STATE_DRAINING) {
			state = READY;
			break;
		}
	}

--

	Tomas Kasparek (sioux, xkaspa06)
 	 Tomas.Kasparek@[seznam.cz,volny.cz]
	 Linux@dcse.fee.vutbr.cz
	student UIVT FEI VUT Brno
