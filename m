From: Markus Korber <korbse@gmx.at>
Subject: snd_pcm_status_get_avail() values
Date: Tue, 20 Nov 2007 08:00:40 +0100
Message-ID: <6zwssdmmef.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id AEFF4249C0
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 08:00:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I've got a driver with the following settings:

,----
| static const struct snd_pcm_hardware svenm_pcm_hardware = {
|       .info                   = SNDRV_PCM_INFO_MMAP |
|                                 SNDRV_PCM_INFO_MMAP_VALID |
|                                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
|                                 SNDRV_PCM_INFO_PAUSE |
|                                 SNDRV_PCM_INFO_RESUME |
|                                 SNDRV_PCM_INFO_INTERLEAVED,
|       .formats                = SNDRV_PCM_FMTBIT_S16_LE |
|                                 SNDRV_PCM_FMTBIT_U16_LE,
|       .channels_min           = 2, /* 2 = only stereo */
|       .channels_max           = 2,
|       .period_bytes_min       = 8*1024,
|       .period_bytes_max       = 8*1024,
|       .periods_min            = 2,
|       .periods_max            = 2,
|       .buffer_bytes_max       = 4*8*1024,
| };
`----

,----[ _pcm_prepare() ]
|       chip->playback.hw_buffer_size = prtd->period_bytes * 2; /* byte size */
|       chip->playback.sw_buffer_size = snd_pcm_lib_buffer_bytes(substream);
`----

Since my HW only allows for a period number of 2, I would like to always
receive period_bytes_min(max) input bytes from an application (mplayer,
xine, etc.) so that I can always fill one complete HW output buffer.

The application (mplayer) does [3] to determine the number of bytes it
is allowed to write with snd_pcm_writei() (for logging see [4]):

,----[ 3 ]
|     bytes_to_write = snd_pcm_status_get_avail(status) * bytes_per_sample;
`----

(Here 1 sample equals 4 bytes, S16_LE, stereo.)

,----[ 4 ]
| fill_audio_out_buffers: bytes_to_write=16384
| alsa-play: frames=4096, len=16384
| fill_audio_out_buffers: bytes_to_write=8192                                                           
| alsa-play: frames=2048, len=8192
| fill_audio_out_buffers: bytes_to_write=8192                                                           
| alsa-play: frames=2048, len=8192
| fill_audio_out_buffers: bytes_to_write=8192                                                           
| alsa-play: frames=2048, len=8192
| fill_audio_out_buffers: bytes_to_write=16384                                                          
| alsa-play: frames=4096, len=16384
| fill_audio_out_buffers: bytes_to_write=16384                                                          
| alsa-play: frames=4096, len=16384
`----

Furthermore, I'm using the pcm-indirect framework[1] and my hw_ptr
always toggles between 0 and period_bytes[2] (bufnum refers to the HW
playback buffer number).

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

Thus, how is the value returned by snd_pcm_status_get_avail determined?
I mean, if my pointer always toggles between 0 and period_bytes[2], how
can ALSA return the values logged in [4]?  Would this mean that I'm not
able to process (in the application) the samples fast enough and the HW
buffer runs empty in the meantime?  
(I would expect snd_pcm_status_get_avail to always returns 8192.)

Or is there an additional parameter or constraint to somehow limit the
input sample number from an application?

Thanks.

Regards,
Markus Korber
