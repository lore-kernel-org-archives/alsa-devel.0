From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [BUG ?] Crash in the cs46xx driver when using alsaplayer
Date: Mon, 12 Aug 2002 20:59:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5805A4.5020008@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi!

Using the alsaplayer with the cs46xx driver causes a oops when closing 
the alsaplayer, playing mp3, wav, CD's etc with the
alsaplayer works fine. All other applications that i've tested this dont 
happens OSS stuff like XMMS, aplay, acrecord, jackit.

Soiling all over the code with a lot of snd_printdd finally i've 
discovered the cause of the crash, and it's not cause of my patches to 
the cs46xx driver, it will probably happen even without 
CONFIG_SND_CS46XX_NEW_DSP defined.

So, when alsaplayer is closing the snd_cs46xx_playback_hw_free(...) is 
invoked, and after that the for some reason the 
snd_cs46xx_playback_copy(...) is invoked, and then runtime->dma_area == 
NULL which causes a kernel "oops" when copy_from_user(...) is invoked 
from snd_cs46xx_playback_copy(...)

Let's take a look at snd_cs46xx_playback_hw_free(...):

static int snd_cs46xx_playback_hw_free(snd_pcm_substream_t * substream)
{
    /*cs46xx_t *chip = snd_pcm_substream_chip(substream);*/
    snd_pcm_runtime_t *runtime = substream->runtime;
    cs46xx_pcm_t *cpcm;

    cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return 
-ENXIO);

    if (runtime->dma_area != cpcm->hw_area)
        snd_pcm_lib_free_pages(substream);
   
    runtime->dma_area = NULL;
    runtime->dma_addr = 0;
    runtime->dma_bytes = 0;

    return 0;
}

and then snd_cs46xx_playback_copy(...):

static int snd_cs46xx_playback_copy(snd_pcm_substream_t *substream,
                    int channel,
                    snd_pcm_uframes_t hwoff,
                    void *src,
                    snd_pcm_uframes_t frames)
{
    snd_pcm_runtime_t *runtime = substream->runtime;
    /*cs46xx_t *chip = snd_pcm_substream_chip(substream); */
    size_t hwoffb;
    size_t bytes;
    char *hwbuf;
    cs46xx_pcm_t *cpcm = snd_magic_cast(cs46xx_pcm_t, 
substream->runtime->private_data, return -ENXIO);

    hwoffb = hwoff << cpcm->shift;
    bytes = frames << cpcm->shift;
    hwbuf = runtime->dma_area + hwoffb;

    if (copy_from_user(hwbuf, src, bytes)) /* It crash here when 
runtime->dma_area == NULL */
        return -EFAULT;

    spin_lock_irq(&runtime->lock);
    snd_cs46xx_playback_transfer(substream, frames);
    spin_unlock_irq(&runtime->lock);
    return 0;
}

Where is BUG ?, or  in cs46xx driver or in the ALSA PCM core somewhere ?,
well, it's easy fixed in snd_cs46xx_playback_copy(...) doing a check.
Then why it only happen with the alsaplayer, just no idea ....

suggestions ... ?? comments .... ??

/Benny



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
