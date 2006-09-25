From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Mon, 25 Sep 2006 15:54:22 -0400
Message-ID: <1159214063.2899.127.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
	<1158331680.7948.156.camel@mindpipe>  <s5h64fjj3aj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h64fjj3aj.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-09-19 at 17:15 +0200, Takashi Iwai wrote:
> The workq task is a pseudo-DMA engine that runs in background.
> When it's woken up, it feeds data from intermediate buffer to hardware
> as much as possible.  The available data can be found in
> 
> If all data are fed, it sleeps again (or exit
> the task).  The timer wakes up or schedule the new workq task.
> 

I've attached our code, which actually uses a combination of the two
(copy callback and an intermediate buffer).  It's certainly not the most
efficient implementation but it works, at least with aplay.  However if
we play an MP3 using madplay, the sound is OK for the first minute or so
after which ticks or glitches are heard.  It sounds as if old parts of
the buffer are being replayed.

The difference in the applications seems to be that madplay writes in
chunks of 0x480 bytes (IOW, arbitrary) while aplay always uses 0x4000
(which matches the hardware buffer size).

Here is the code - can you see anything wrong with it?  It's derived
from the ALSA dummy driver and still uses the dummy driver's hardware
pointer and timer scheme for calling pcm_period_elapsed() - could this
be the problem?  My attempts to track the hardware pointer more
accurately and call pcm_period_elapsed from the copy callback have not
been successful.

Most of the work is done in the workqueue dream_handle_pcm_queue() and
the copy callback.

/*
 *  Dream soundcard
 *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
 *  Copyright (c) by Lee Revell <rlrevell@joe-job.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 */

#include <linux/init.h>
#include <linux/pci.h>
#include <linux/jiffies.h>
#include <linux/slab.h>
#include <linux/time.h>
#include <linux/wait.h>
#include <linux/moduleparam.h>
#include <sound/dream.h>
#include <sound/dream_codec.h>

MODULE_AUTHOR("Lee Revell <rlrevell@joe-job.com>");
MODULE_DESCRIPTION("Dream soundcard (/dev/null)");
MODULE_LICENSE("GPL");
MODULE_SUPPORTED_DEVICE("{{ALSA,Dream soundcard}}");

static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
static int enable[SNDRV_CARDS] = {1, 1, [2 ... (SNDRV_CARDS - 1)] = 0};
static int pcm_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
static int pcm_substreams[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 8};
/* Are we running on real Alchemy board?  If so create local bus driver as well as probing PCI */
static int alchemy = 0;

module_param_array(index, int, NULL, 0444);
MODULE_PARM_DESC(index, "Index value for dream soundcard.");
module_param_array(id, charp, NULL, 0444);
MODULE_PARM_DESC(id, "ID string for dream soundcard.");
module_param_array(enable, bool, NULL, 0444);
MODULE_PARM_DESC(enable, "Enable this dream soundcard.");
module_param_array(pcm_devs, int, NULL, 0444);
MODULE_PARM_DESC(pcm_devs, "PCM devices # (0-4) for dream driver.");
module_param_array(pcm_substreams, int, NULL, 0444);
MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-16) for dream driver.");
module_param(alchemy, int, 0);
MODULE_PARM_DESC(alchemy, "Device is on PCI rather than local bus");

#ifdef LEO_PCM_REPLAY
#define DPCM_DBG_SIZE 0x1000L
#define DPCM_MAX_DBG_SIZE DPCM_DBG_SIZE-128
static unsigned char dpcm_dbg[DPCM_DBG_SIZE];
#endif

int dream_setup_firmware(struct snd_card_dream *dream)
{
	const char *fwfile;
	const struct firmware *fw;
	int err;

	fwfile = "PCI9708S.BIN";

#if 0
        err = DrmcInit(1, 0, 1);
	printk("dream codec init: %i\n", err);
#endif

	if ((err = dream_switch_uart_mode(dream, &dream->midi1, 0)) != 0) {
		printk("dream_switch_uart_mode failed for first port: %i\n", err);
		return -1;
	}
	if ((err = dream_load_boot(dream, &dream->midi1)) < 0)
		return -1;

	if ((err = dream_switch_uart_mode(dream, &dream->midi2, 0)) != 0) {
		printk("dream_switch_uart_mode failed for first port: %i\n", err);
		return -1;
	}
	if ((err = dream_load_boot(dream, &dream->midi2)) < 0)
		return -1;

	if (request_firmware(&fw, fwfile, &dream->pci->dev)) {
		printk(KERN_ERR "Dreamchip: cannot load firmware %s\n", fwfile);
		return -ENOENT;
	} else {
		printk(KERN_ERR "Dreamchip: loaded firmware %s size %i\n", fwfile, (int)fw->size);
	}
	err = dream_dbg_upload_xmem(dream, &dream->midi1, DREAM_FIRMWARE_ADDR, (unsigned short *) fw->data, fw->size);
	printk("dream_dbg_upload_xmem returned %i\n", err);
	return 0;
}

static int snd_dream_playback_copy(snd_pcm_substream_t * substream, int channel,
				   snd_pcm_uframes_t pos,
				   void __user *src, snd_pcm_uframes_t count)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;
	int retval;

	if(((unsigned int)(dpcm->ptr - dpcm_dbg)) < DPCM_MAX_DBG_SIZE)
        dpcm->ptr += sprintf(dpcm->ptr, 
           "TS: %10.0lu snd_dream_playback_copy: pos 0x%x src 0x%p count 0x%x (0x%x bytes)\n", 
			     jiffies, (unsigned int) pos, src, 
              (unsigned int) count, frames_to_bytes(runtime, count));	retval=0;
        do {
	  unsigned int len, new_size;
          unsigned char * new_data;
	/* allocate necessary number of buffers and add them to buffers' list */
        len  = frames_to_bytes(runtime, count);
        new_size = len + dpcm->b.left + 2;

	new_data = (unsigned char *) 
                     kmalloc(new_size, GFP_KERNEL);
	    if(new_data == NULL)
	      {
		retval = -ENOMEM;
                break;
              }

	    if(dpcm->b.data)
	      {
		memcpy(new_data, & dpcm->b.data[dpcm->b.offset], dpcm->b.left);
                kfree(dpcm->b.data);
              } 

            if ((retval = copy_from_user(& new_data[dpcm->b.left], src, len))) {
		printk("copy_from_user failed: %i\n", retval);
		retval = -EFAULT;
                break;
	    } else {
	      /*		printk("copy_from_user 0x%x bytes to 0x%p from 0x%p succeeded\n", 
			len,
			& new_data[dpcm->b.left],
			src);*/
	             retval=0;
                    }

	    dpcm->b.left += len;
            dpcm->b.size  = dpcm->b.left;
            dpcm->b.offset= 0;
            dpcm->b.data  = new_data;
	} while(0);

	  if(retval<0)
            return(retval);

	/* Convert to words for queue handler */ 
	dpcm->sw_words_played += frames_to_bytes(runtime, count) / 2;
	dpcm->sw_chunks_played++;
	schedule_work(&dpcm->pcm_work);

	return 0;
}

static int snd_dream_capture_copy(snd_pcm_substream_t * substream, int channel,
				   snd_pcm_uframes_t pos,
				   void __user *src, snd_pcm_uframes_t count)
{
	struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;

	dream_pcm_dma_xfer(dream, dpcm, src, frames_to_bytes(runtime, count), 1);
	return 0;
}

static snd_card_t *snd_dream_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;


static void snd_card_dream_pcm_timer_start(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;

	dpcm->timer.expires = 1 + jiffies;
	add_timer(&dpcm->timer);
}

static void snd_card_dream_pcm_timer_stop(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;

	del_timer(&dpcm->timer);
}

static int snd_card_dream_playback_trigger(snd_pcm_substream_t * substream,
					   int cmd)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;
	struct snd_card_dream *dream = snd_pcm_substream_chip(substream);

	if (cmd == SNDRV_PCM_TRIGGER_START) {
		// dbg(dream, "trigger: PCM playback start\n");

		snd_card_dream_pcm_timer_start(substream);
	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
		// dbg(dream, "trigger: PCM playback stop\n");
		snd_card_dream_pcm_timer_stop(substream);
		/* Send PCM_CLOSE here - ? */
		dpcm->stopping = 1;
		schedule_work(&dpcm->pcm_work);
	} else {
		return -EINVAL;
	}
	return 0;
}

static int snd_card_dream_capture_trigger(snd_pcm_substream_t * substream,
					  int cmd)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;
	struct snd_card_dream *dream = snd_pcm_substream_chip(substream);

	if (cmd == SNDRV_PCM_TRIGGER_START) {
		dbg(dream, "trigger: PCM capture start\n");
		snd_card_dream_pcm_timer_start(substream);
		/* Send PCM_START here */
		dream_pcm_start(dream, dpcm->channel);
	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
		dbg(dream, "trigger: PCM capture stop\n");
		snd_card_dream_pcm_timer_stop(substream);
		/* Send PCM_CLOSE here - ? */
		dream_pcm_close(dream, dpcm->channel);
	} else {
		return -EINVAL;
	}
	return 0;
}

static int snd_card_dream_pcm_prepare(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;
	unsigned int bps;

	bps = runtime->rate * runtime->channels;
	bps *= snd_pcm_format_width(runtime->format);
	bps /= 8;
	if (bps <= 0)
		return -EINVAL;
	dpcm->pcm_bps = bps;
	dpcm->pcm_jiffie = bps / HZ;
	dpcm->pcm_size = snd_pcm_lib_buffer_bytes(substream);
	dpcm->pcm_count = snd_pcm_lib_period_bytes(substream);
	dpcm->pcm_irq_pos = 0;
	dpcm->pcm_buf_pos = 0;
	// dbg(dream, "PCM prepare: DMA buffer 0x%x bytes at 0x%p\n", runtime->dma_bytes, runtime->dma_area);
	return 0;
}

static int snd_card_dream_playback_prepare(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;
	struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
	printk("dream_pcm_open: channel 0x%x eight_bit 0x%x stereo 0x%x rate 0x%x\n", 
		dpcm->channel, dpcm->eight_bit, dpcm->stereo, dpcm->rate);

	dream_pcm_open(dream, dpcm->channel, dpcm->eight_bit, dpcm->stereo, dpcm->rate);
	// dbg(dream, "prepare: PCM playback\n");
	return snd_card_dream_pcm_prepare(substream);
}

static int snd_card_dream_capture_prepare(snd_pcm_substream_t * substream)
{
	struct snd_card_dream *dream = snd_pcm_substream_chip(substream);

	dbg(dream, "prepare: PCM capture\n");
	return snd_card_dream_pcm_prepare(substream);
}

static void snd_card_dream_pcm_timer_function(unsigned long data)
{
	struct snd_card_dream_pcm *dpcm = (struct snd_card_dream_pcm *)data;
	struct snd_card_dream *dream = snd_pcm_substream_chip(dpcm->substream);

	dpcm->timer.expires = 1 + jiffies;
	add_timer(&dpcm->timer);
	spin_lock_irq(&dpcm->lock);
	dpcm->pcm_irq_pos += dpcm->pcm_jiffie;
	dpcm->pcm_buf_pos += dpcm->pcm_jiffie;
	dpcm->pcm_buf_pos %= dpcm->pcm_size;
	if (dpcm->pcm_irq_pos >= dpcm->pcm_count) {
		dpcm->pcm_irq_pos %= dpcm->pcm_count;
		// dbg(dream, "timer: PCM period elapsed\n");
		snd_pcm_period_elapsed(dpcm->substream);
	}
	spin_unlock_irq(&dpcm->lock);	
}


static snd_pcm_uframes_t snd_card_dream_playback_pointer(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;

#ifdef LEO_PCM_REPLAY
#else
	printk("pointer returned 0x%x\n", bytes_to_frames(runtime, dpcm->pcm_buf_pos));	
#endif
	return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
}

static snd_pcm_uframes_t snd_card_dream_capture_pointer(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;

	return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
}

static snd_pcm_hardware_t snd_card_dream_playback =
{
	.info =			(SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_INTERLEAVED),
	.formats =		USE_PLAYBACK_FORMATS,
	.rates =		USE_RATE,
	.rate_min =		USE_RATE_MIN,
	.rate_max =		USE_RATE_MAX,
	.channels_min =		USE_CHANNELS_MIN,
	.channels_max =		USE_CHANNELS_MAX,
	.buffer_bytes_max =	MAX_BUFFER_SIZE,
	.period_bytes_min =	MAX_PERIOD_SIZE,
	.period_bytes_max =	MAX_PERIOD_SIZE,
	.periods_min =		USE_PERIODS_MIN,
	.periods_max =		USE_PERIODS_MAX,
	.fifo_size =		0,
};

static snd_pcm_hardware_t snd_card_dream_capture =
{
	.info =			(SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_INTERLEAVED),
	.formats =		USE_CAPTURE_FORMATS,
	.rates =		USE_RATE,
	.rate_min =		USE_RATE_MIN,
	.rate_max =		USE_RATE_MAX,
	.channels_min =		USE_CHANNELS_MIN,
	.channels_max =		USE_CHANNELS_MAX,
	.buffer_bytes_max =	MAX_BUFFER_SIZE,
	.period_bytes_min =	64,
	.period_bytes_max =	MAX_BUFFER_SIZE,
	.periods_min =		USE_PERIODS_MIN,
	.periods_max =		USE_PERIODS_MAX,
	.fifo_size =		0,
};

static void snd_card_dream_runtime_free(snd_pcm_runtime_t *runtime)
{
	struct snd_card_dream_pcm *dpcm = runtime->private_data;
	kfree(dpcm);
}

static int snd_card_dream_hw_params(snd_pcm_substream_t * substream,
				    snd_pcm_hw_params_t * hw_params)
{
	struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm = runtime->private_data;
	int err;
	
	/* W_OPEN: channels 0 if mono, 1 if stereo */ 
	dpcm->stereo = params_channels(hw_params) == 2;
	/* W_OPEN: format 0 if 16bit, 1 if 8bit */
	dpcm->eight_bit = params_format(hw_params) == SNDRV_PCM_FORMAT_U8;
	dpcm->rate = params_rate(hw_params);

	printk("hw_params: stereo %s, format %s\n, rate %i",
			dpcm->stereo ? "yes" : "no",
			dpcm->eight_bit ? "8bit" : "16bit",
			dpcm->rate);
	
	if (( err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
		return err;

	return 0;
}

static int snd_card_dream_hw_free(snd_pcm_substream_t * substream)
{
	return snd_pcm_lib_free_pages(substream);
}

static void dream_handle_pcm_queue(void * data)
{
	struct snd_card_dream_pcm *dpcm = (struct snd_card_dream_pcm *) data;
	int res, sample;
	int samples = 0x2000;

	if (! dpcm->running) {
		printk("dream_handle_pcm_queue: invoked before trigger!\n");
		/* Send PCM_START */
		dream_pcm_start(dpcm->dream, dpcm->channel);
		dpcm->running = 1;
	}

	if (dpcm->stopping) { /* Play buffer of any size, but at least 1 and
                                 never 0x2000 */
          if(dpcm->b.left)
            samples = (dpcm->b.left < DREAM_PCM_HALF_BUFFER_LEN_BYTES) ? dpcm->b.left/2 :
	                              DREAM_PCM_HALF_BUFFER_LEN-1; 
          else
            samples = 1;
        } else if(dpcm->b.left >= DREAM_PCM_HALF_BUFFER_LEN_BYTES)
	          samples = DREAM_PCM_HALF_BUFFER_LEN;
	       else
		 samples = 0; /* Don't play partial half buffer unless is stopping */
 
	if(((unsigned int)(dpcm->ptr - dpcm_dbg)) < DPCM_MAX_DBG_SIZE)
        dpcm->ptr += sprintf(dpcm->ptr, 
     "TS: %10.0lu %s pcm_queue: app 0x%x words hw 0x%x samples 0x%x off 0x%x left 0x%x\n", 
			     jiffies, dpcm->stopping ? "STOP" : "RUN ", 
                             dpcm->sw_words_played, dpcm->hw_words_played,
                             samples, dpcm->b.offset, dpcm->b.left);
	if(samples > 0)
	  {
	    res = dream_get_mpu_data_poll_status_byte(dpcm->dream, 
                                                      &dpcm->dream->midi2, 
                                                       MPU401_IT_MASK, 
                                                       MPU401_IT_VALUE, 100); 
            
	    if(res >= 0)
	      {
                unsigned int play_size = samples*2;
		unsigned short * pcm_word = (unsigned short *) & dpcm->b.data[dpcm->b.offset];
            /* Write buffer to Dream chip */
		for (sample = 0; sample <  samples; sample++, pcm_word++)
		  mpu_write16(dpcm->dream, &dpcm->dream->midi2, 
                   cpu_to_le16(*pcm_word), 0); /* TBD: don't swap for 8 bits WAV */

	      dream_pcm_end_xfer(dpcm->dream, dpcm->channel);
	      /* move offset */
              dpcm->b.offset +=  play_size;
              dpcm->b.left   -=  play_size;
	      dpcm->hw_words_played += samples;
              }
             else
	       printk("dream_handle_pcm_queue: polling status byte returned %i\n", res);

          } /* if(samples > 0) */
	if (dpcm->stopping) {
	  int l = strlen(dpcm_dbg), ii=0;
          unsigned char buf[120];
	  while(ii < l)
	    {
	      strncpy(buf, & dpcm_dbg[ii], 100);
              buf[100] = 0;
             printk(buf);
             ii += 100;
            }
              
      	        mdelay(100);
		dream_pcm_close(dpcm->dream, dpcm->channel);
		dpcm->running = 0;
                if(dpcm->b.data)
                  kfree(dpcm->b.data);
		printk("handle_queue: stopping.  %i chunks\n", dpcm->sw_chunks_played);
	}

	return;
}

static int snd_card_dream_playback_open(snd_pcm_substream_t * substream)
{
	struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm;
	int err;

	dpcm = kcalloc(1, sizeof(*dpcm), GFP_KERNEL);
	if (dpcm == NULL)
		return -ENOMEM;
#ifdef LEO_PCM_REPLAY
        memset(dpcm, 0, sizeof(*dpcm));
        dpcm->channel = 0; /* not necessary because of previous memset, but just in case */
        dpcm->ptr = dpcm_dbg;
#endif
	dpcm->dream = dream;
	init_timer(&dpcm->timer);
	dpcm->timer.data = (unsigned long) dpcm;
	dpcm->timer.function = snd_card_dream_pcm_timer_function;
	spin_lock_init(&dpcm->lock);
	dpcm->substream = substream;
	runtime->private_data = dpcm;
	runtime->private_free = snd_card_dream_runtime_free;
	runtime->hw = snd_card_dream_playback;

	if ((err = add_playback_constraints(runtime)) < 0) {
		kfree(dpcm);
		return err;
	}

	/* initialize the workqueue that will be triggered from copy callback
	 * to write PCM samples to the hardware */
	INIT_WORK(&dpcm->pcm_work, dream_handle_pcm_queue, (void *)dpcm);

	return 0;
}

static int snd_card_dream_capture_open(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	struct snd_card_dream_pcm *dpcm;
	int err;

	dpcm = kcalloc(1, sizeof(*dpcm), GFP_KERNEL);
	if (dpcm == NULL)
		return -ENOMEM;
	init_timer(&dpcm->timer);
	dpcm->timer.data = (unsigned long) dpcm;
	dpcm->timer.function = snd_card_dream_pcm_timer_function;
	spin_lock_init(&dpcm->lock);
	dpcm->substream = substream;
	runtime->private_data = dpcm;
	runtime->private_free = snd_card_dream_runtime_free;
	runtime->hw = snd_card_dream_capture;

	if ((err = add_capture_constraints(runtime)) < 0) {
		kfree(dpcm);
		return err;
	}

	return 0;
}

static int snd_card_dream_playback_close(snd_pcm_substream_t * substream)
{
	return 0;
}

static int snd_card_dream_capture_close(snd_pcm_substream_t * substream)
{
	return 0;
}

static snd_pcm_ops_t snd_card_dream_playback_ops = {
	.open =			snd_card_dream_playback_open,
	.close =		snd_card_dream_playback_close,
	.ioctl =		snd_pcm_lib_ioctl,
	.hw_params =		snd_card_dream_hw_params,
	.hw_free =		snd_card_dream_hw_free,
	.prepare =		snd_card_dream_playback_prepare,
	.trigger =		snd_card_dream_playback_trigger,
	.pointer =		snd_card_dream_playback_pointer,
	.copy =			snd_dream_playback_copy,
};

static snd_pcm_ops_t snd_card_dream_capture_ops = {
	.open =			snd_card_dream_capture_open,
	.close =		snd_card_dream_capture_close,
	.ioctl =		snd_pcm_lib_ioctl,
	.hw_params =		snd_card_dream_hw_params,
	.hw_free =		snd_card_dream_hw_free,
	.prepare =		snd_card_dream_capture_prepare,
	.trigger =		snd_card_dream_capture_trigger,
	.pointer =		snd_card_dream_capture_pointer,
	.copy =			snd_dream_capture_copy,
};

static int __init snd_card_dream_pcm(struct snd_card_dream *dream, int device, int substreams)
{
	snd_pcm_t *pcm;
	int err;

	if ((err = snd_pcm_new(dream->card, "Dream PCM", device, substreams, substreams, &pcm)) < 0)
		return err;
	pcm->private_data = dream;

	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_card_dream_playback_ops);
	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_card_dream_capture_ops);

	pcm->info_flags = 0;
	strcpy(pcm->name, "Dream PCM");
	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
					      snd_dma_continuous_data(GFP_KERNEL),
					      0, 64*1024);
	dream->pcm = pcm;
	return 0;
}

static int snd_dream_hwdep_open(snd_hwdep_t * hw, struct file *file)
{
	return 0;
}

static int snd_dream_hwdep_release(snd_hwdep_t * hw, struct file *file)
{
	return 0;
}

irqreturn_t snd_dream_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct snd_card_dream *dream = dev_id;
	printk("interrupt - dream is 0x%p\n", dream);
	return IRQ_HANDLED;
}

static int snd_dream_hwdep_ioctl(snd_hwdep_t * hw, struct file *file, unsigned int cmd, unsigned long arg)
{
	struct snd_card_dream *dream = hw->private_data;
	struct snd_dream_midi_msg *midi_msg;
        struct snd_dream_codec_msg * codec_msg;
	//unsigned int addr;
	void __user *argp = (void __user *)arg;
	int res, sample, i;
	int samples = 0x2000;
	signed short * buffer;
	
	switch (cmd) {
	case SNDRV_DREAM_IOCTL_MIDI_MSG:
		midi_msg = (struct snd_dream_midi_msg *)kmalloc(sizeof(*midi_msg), GFP_KERNEL);
		if (midi_msg == NULL)
			return -ENOMEM;
		if (copy_from_user(midi_msg, argp, sizeof(*midi_msg))) {
			kfree(midi_msg);
			return -EFAULT;
		}
		if(midi_msg->dbg_prn)
		printk("MIDI message chip %i mpu_port %i offset %i direction %i 16bit %i data 0x%x\n", 
			midi_msg->chip, 
			midi_msg->mpu_port, 
			midi_msg->offset, 
			midi_msg->direction, 
			midi_msg->size, 
			midi_msg->data);
		if (midi_msg->size == SND_DREAM_MSG_8BIT) {
			if (midi_msg->direction == SND_DREAM_WRITE) {
				mpu_write(dream, 
					  (midi_msg->mpu_port ? &dream->midi2 : &dream->midi1),
					  midi_msg->data,
					  midi_msg->offset,
					  midi_msg->dbg_prn);
			} else {
				midi_msg->data = mpu_read(dream, 
							  (midi_msg->mpu_port ? 
							  &dream->midi2 : &dream->midi1),
							  midi_msg->offset,
							  midi_msg->dbg_prn);
			}
		} else { /* 16 bit */
			if (midi_msg->direction == SND_DREAM_WRITE) {
				mpu_write16(dream, 
					    (midi_msg->mpu_port ? &dream->midi2 : &dream->midi1),
					    midi_msg->data,
					    midi_msg->dbg_prn);
			} else {
				midi_msg->data = mpu_read16(dream, 
							  (midi_msg->mpu_port ? 
							  &dream->midi2 : &dream->midi1),
							  midi_msg->offset,
							  midi_msg->dbg_prn);
			}

		}

		if (copy_to_user(argp, midi_msg, sizeof(*midi_msg))) {
			kfree(midi_msg);
			return -EFAULT;
		}
		
		kfree(midi_msg);
		return 0;
	case SNDRV_DREAM_IOCTL_REQUEST_IRQ:
		res = request_irq(dream->pci->irq, snd_dream_interrupt, SA_INTERRUPT|SA_SHIRQ, "Dreamchip", (void *)dream);
		printk("IOCTL_REQUEST_IRQ returned %i\n", res);
	        return res;	

	case SNDRV_DREAM_IOCTL_FW_LOAD:
	        res = dream_setup_firmware(dream);
		printk("IOCTL_FW_LOAD returned %i\n", res);
	        return res;	
	/* send random data to PCM for testing */
	case SNDRV_DREAM_IOCTL_PCM_TEST:
		printk(KERN_ERR "IOCTL_PCM_TEST: start\n");
		/* allocate a buffer and fill it with random data */
		buffer = (signed short *) kmalloc((samples * sizeof(signed short)), GFP_KERNEL);
		if (buffer == NULL)
			return -ENOMEM;
		get_random_bytes(buffer, (samples * sizeof(signed short)));

		printk(KERN_ERR "IOCTL_PCM_TEST: filled buffer with random data\n");

		/* 9708 channel 0, 16 bit, stereo, 48000Hz */
		dream_pcm_open(dream, 0, 0, 1, 48000);
		dream_pcm_set_vol_fl(dream, 0, 0xFFFF);
		dream_pcm_set_vol_fr(dream, 0, 0xFFFF);
		dream_pcm_start(dream, 0);

		/* Send first half buffer */
		res = dream_get_mpu_data_poll_status_byte(dream, &dream->midi2, MPU401_IT_MASK, MPU401_IT_VALUE, 100); 
		printk(KERN_ERR "IOCTL_PCM_TEST: iter 0 polling status byte returned %i\n", res);

		for (sample = 0; sample < samples; sample++)
			mpu_write16(dream, &dream->midi2, buffer[sample], 0);

		dream_pcm_end_xfer(dream, 0);

		/* Send 10 more half buffers */
		for (i = 0; i < 10; i++) {
			res = dream_get_mpu_data_poll_status_byte(dream, &dream->midi2, MPU401_IT_MASK, MPU401_IT_VALUE, 100); 
			printk(KERN_ERR "IOCTL_PCM_TEST: iter %i polling status byte returned %i\n", i+1, res);

			for (sample = 0; sample < samples; sample++)
				mpu_write16(dream, &dream->midi2, buffer[sample], 0);

			dream_pcm_end_xfer(dream, 0);
		}

		/* Finally send incomplete half buffer */
		res = dream_get_mpu_data_poll_status_byte(dream, &dream->midi2, MPU401_IT_MASK, MPU401_IT_VALUE, 100); 
		printk(KERN_ERR "IOCTL_PCM_TEST: iter 0 polling status byte returned %i\n", res);

		for (sample = 0; sample < samples-1; sample++)
			mpu_write16(dream, &dream->midi2, buffer[sample], 0);

		dream_pcm_end_xfer(dream, 0);

		res = dream_pcm_close(dream, 0);

		printk(KERN_ERR "IOCTL_PCM_TEST returned %i\n", res);
	        return res;
	
        case SNDRV_DREAM_IOCTL_CODEC_MSG:
		codec_msg = (struct snd_dream_codec_msg *)kmalloc(sizeof(*codec_msg), GFP_KERNEL);
		if (codec_msg == NULL)
			return -ENOMEM;
		if (copy_from_user(codec_msg, argp, sizeof(*codec_msg))) {
			kfree(codec_msg);
			return -EFAULT;
		}

	        res = DrmcIoctlProc(codec_msg);


		if (copy_to_user(argp, codec_msg, sizeof(*codec_msg))) {
			kfree(codec_msg);
			return -EFAULT;
		}
		
		kfree(codec_msg);
                return res;
	}
	return -ENOTTY;
}
int __devinit snd_dream_hwdep_new(struct snd_card_dream *dream, int device, snd_hwdep_t ** rhwdep)
{
	snd_hwdep_t *hw;
	int err;
	
	if (rhwdep)
		*rhwdep = NULL;
	if ((err = snd_hwdep_new(dream->card, "Dreamchip", device, &hw)) < 0)
		return err;
	strcpy(hw->name, "Dreamchip");
	hw->iface = SNDRV_HWDEP_IFACE_DREAMCHIP;
	hw->ops.open = snd_dream_hwdep_open;
	hw->ops.ioctl = snd_dream_hwdep_ioctl;
	hw->ops.release = snd_dream_hwdep_release;
	hw->private_data = dream;
	if (rhwdep)
		*rhwdep = hw;
	return 0;
}

static int snd_dream_free(struct snd_card_dream *dream)
{
	/* release the i/o ports & memory */
	pci_release_regions(dream->pci);

	/* disable the PCI entry */
	pci_disable_device(dream->pci);

	/* release the data */
	kfree(dream);
	return 0;
}

static int snd_dream_dev_free(snd_device_t *device)
{
	struct snd_card_dream *dream = device->device_data;
	return snd_dream_free(dream);
}

static int __devinit snd_dream_pci_create(snd_card_t * card,
				      struct pci_dev * pci,
				      struct snd_card_dream ** rdream)
{
	struct snd_card_dream *dream;
	int err, len;
	
	static snd_device_ops_t ops = {
		.dev_free = snd_dream_dev_free,
	};
	
	/* enable PCI device */
	if ((err = pci_enable_device(pci)) < 0)
		return err;

	dream = kmalloc(sizeof(*dream), GFP_KERNEL);
	if (dream == NULL) {
		pci_disable_device(pci);
		return -ENOMEM;
	}	    
	memset(dream, 0, sizeof(*dream));
	
	dream->card = card;
	dream->pci = pci;

	if ((err = pci_request_regions(pci, "Dreamchip")) < 0) {
		kfree(dream);
		pci_disable_device(pci);
		return err;
	}

	printk("Dreamchip: alchemy is %i\n", alchemy);

	/* Get the PCI BAR */
	dream->port = pci_resource_start(pci, 0);
	printk("Dreamchip: base port 0x%x\n", dream->port);
	len = pci_resource_len(pci, 0);
	printk("Dreamchip: base port len %i\n", len);

#if 0
	if (request_irq(pci->irq, snd_dream_interrupt, SA_INTERRUPT|SA_SHIRQ, "Dreamchip", (void *)dream)) {
		kfree(dream);
		pci_disable_device(pci);
		return -EBUSY;
	}
	dream->irq = pci->irq;
#endif

	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, dream, &ops)) < 0) {
		snd_dream_free(dream);
		return err;
	}

	snd_card_set_dev(card, &pci->dev);

	*rdream = dream;
	return 0;
}	    
	
static int __devinit snd_card_dream_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
{
	static int dev;
	snd_card_t *card;
	struct snd_card_dream *dream;
	int idx, err;

	if (dev >= SNDRV_CARDS)
        	return -ENODEV;
	if (!enable[dev]) {
		dev++;
		return -ENOENT;
	}

	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
	if (card == NULL)
		return -ENOMEM;

	strcpy(card->driver, "Dream");
	strcpy(card->shortname, "Dream");
	sprintf(card->longname, "Dream %i", dev + 1);

	if ((err = snd_dream_pci_create(card, pci, &dream)) < 0)
		goto __nodev;

	spin_lock_init(&dream->dream_lock);
	spin_lock_init(&dream->log_lock);
	
	for (idx = 0; idx < MAX_PCM_DEVICES && idx < pcm_devs[dev]; idx++) {
		if (pcm_substreams[dev] < 1)
			pcm_substreams[dev] = 1;
		if (pcm_substreams[dev] > MAX_PCM_SUBSTREAMS)
			pcm_substreams[dev] = MAX_PCM_SUBSTREAMS;
		if ((err = snd_card_dream_pcm(dream, idx, pcm_substreams[dev])) < 0)
			goto __nodev;
	}
	if ((err = snd_card_dream_new_mixer(dream)) < 0)
		goto __nodev;
	
	snd_dream_proc_init(dream);
	
	snd_dream_midi(dream);

	if ((err = snd_dream_hwdep_new(dream, 0, NULL)) < 0)
		goto __nodev;

	/* Simulation mode should not be set by default for PCI board bringup */
	dream->simulation_mode = 0;

	/* Set the register IO log buffer index to 0 */
	dream->log_idx = 0;
	
	/* Load firmware */
	/* if ((err = dream_setup_firmware(dream)) < 0) 
	  goto __nodev; */

#if 0
	if((err = DrmcInit(1, 0, 0)) != 0)
	   goto __nodev;
#endif

	if ((err = snd_card_register(card)) == 0) {
		snd_dream_cards[dev] = card;
		return 0;
	}
	pci_set_drvdata(pci, card);
	dev++;
      __nodev:
	snd_card_free(card);
	return err;
}

static int __devinit snd_card_dream_lb_probe(int dev)
{
	snd_card_t *card;
	struct snd_card_dream *dream;
	int idx, err;

	if (!enable[dev])
 		return -ENODEV;

 	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
 			    sizeof(struct snd_card_dream));

	if (card == NULL)
		return -ENOMEM;

 	dream = (struct snd_card_dream *)card->private_data;
 
 	dream->card = card;

	spin_lock_init(&dream->dream_lock);
	spin_lock_init(&dream->log_lock);
	
	for (idx = 0; idx < MAX_PCM_DEVICES && idx < pcm_devs[dev]; idx++) {
		if (pcm_substreams[dev] < 1)
			pcm_substreams[dev] = 1;
		if (pcm_substreams[dev] > MAX_PCM_SUBSTREAMS)
			pcm_substreams[dev] = MAX_PCM_SUBSTREAMS;
		if ((err = snd_card_dream_pcm(dream, idx, pcm_substreams[dev])) < 0)
			goto __nodev;
	}
	if ((err = snd_card_dream_new_mixer(dream)) < 0)
		goto __nodev;
	
	snd_dream_proc_init(dream);
	
	snd_dream_midi(dream);

	if ((err = snd_dream_hwdep_new(dream, 0, NULL)) < 0)
		goto __nodev;

	/* Simulation mode should not be set by default for PCI board bringup */
	dream->simulation_mode = 0;

	/* Set the register IO log buffer index to 0 */
	dream->log_idx = 0;
	
	/* We are a local bus device, not PCI */
	dream->alchemy = 1;

	dream->mmio_base = ioremap(SAM9708_MMIO_BASE, 0x20);
	printk("MMIO base 0x%p", dream->mmio_base);
	
	/* Load firmware */
	/* if ((err = dream_setup_firmware(dream)) < 0) 
	  goto __nodev; */

#if 0
	if((err = DrmcInit(1, 0, 0)) != 0)
	   goto __nodev;
#endif

	strcpy(card->driver, "Dream");
	strcpy(card->shortname, "Dream");
	sprintf(card->longname, "Dream %i", dev + 1);
	if ((err = snd_card_register(card)) == 0) {
		snd_dream_cards[dev] = card;
		return 0;
	}
	dev++;
      __nodev:
	snd_card_free(card);
	return err;
}

struct pci_device_id snd_dream_ids[] = {
	{ 0x1438, 0x9707, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },	/* Dream PCI board */
	{ 0, }
};

static void __devexit snd_card_dream_pci_remove(struct pci_dev *pci)
{
	snd_card_free(pci_get_drvdata(pci));
	pci_set_drvdata(pci, NULL);
}

static struct pci_driver driver = {
	.name = "Dreamchip",
	.id_table = snd_dream_ids,
	.probe = snd_card_dream_pci_probe,
	.remove = __devexit_p(snd_card_dream_pci_remove),
};

static int __init alsa_card_dream_init(void)
{
	int dev, cards;

	pci_register_driver(&driver);

	if (!alchemy)
		return 0;

	for (dev = cards = 1; dev < SNDRV_CARDS && enable[dev]; dev++) {
		if (snd_card_dream_lb_probe(dev) < 0) {
#ifdef MODULE
			dbg(dream, "Dream soundcard #%i not found or device busy\n", dev + 1);
#endif
			break;
		}
		cards++;
	}
	if (!cards) {
#ifdef MODULE
		dbg(dream, "Dream soundcard not found or device busy\n");
#endif
		return -ENODEV;
	}
	return 0;
}

static void __exit alsa_card_dream_exit(void)
{
	int idx;

	pci_unregister_driver(&driver);

	for (idx = 0; idx < SNDRV_CARDS; idx++)
		snd_card_free(snd_dream_cards[idx]);
}


module_init(alsa_card_dream_init)
module_exit(alsa_card_dream_exit)



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
