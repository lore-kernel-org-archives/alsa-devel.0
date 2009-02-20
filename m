From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: zero appl_ptr reported
Date: Fri, 20 Feb 2009 21:29:12 +0800
Message-ID: <20090220132912.GA8958@localhost>
References: <20090219052016.GA31253@localhost> <s5hzlgjgc6w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id EA33F24420
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 14:29:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzlgjgc6w.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 19, 2009 at 08:42:15AM +0200, Takashi Iwai wrote:
> At Thu, 19 Feb 2009 13:20:16 +0800,
> Wu Fengguang wrote:
> > 
> > Hi Takashi,
> > 
> > I noticed that 'appl_ptr' is always 0 during playback, whether it be
> > mplayer or aplay, T61 or DG45ID. Is this a bug?
> 
> No, it's a feature.  When you use dmix, the appl_ptr isn't updated
> in the driver side but the driver is running in a "free-wheel" mode.
> OTOH, if you use pulseaudio or use HDMI out, the device is opened in a
> normal mode, thus appl_ptr is handled in the driver side.

Ah thanks. This dismissed my questions :)

The dmix plugin always returns error code or negative delay:

alsa-lib/src/pcm/pcm_dmix.c
  477 static int snd_pcm_dmix_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
  478 {
  479         snd_pcm_direct_t *dmix = pcm->private_data;
  480         int err;
  481 
  482         switch(dmix->state) {
  483         case SNDRV_PCM_STATE_DRAINING:
  484         case SNDRV_PCM_STATE_RUNNING:
  485                 err = snd_pcm_dmix_sync_ptr(pcm);
  486                 if (err < 0)
  487                         return err;
  488                 /* fallthru */
  489         case SNDRV_PCM_STATE_PREPARED:
  490         case SNDRV_PCM_STATE_SUSPENDED:
  491         case STATE_RUN_PENDING:
  492                 *delayp = snd_pcm_mmap_playback_hw_avail(pcm);
  493                 return 0;
  494         case SNDRV_PCM_STATE_XRUN:
  495                 return -EPIPE;
  496         case SNDRV_PCM_STATE_DISCONNECTED:
  497                 return -ENODEV;
  498         default:
  499                 return -EBADFD;
  500         }
  501 }

That explains why mplayer always do snd_pcm_forward() after snd_pcm_delay():

        snd_pcm_delay(0x122edc0, 0x7fff0c2201e0, 0x5f4ca4, 0, 0x11e1588)                  = 0
        snd_pcm_forward(0x122edc0, 1756, 0xc0000000000026dc, 9948, 0x11e1588)             = 0
        snd_pcm_delay(0x122edc0, 0x7fff0c2201c0, 24000, 0x122da98, 0x11e1588)             = 0
        snd_pcm_forward(0x122edc0, 8, 0xc000000000002008, 8200, 0x11e1588)                = 0x3ffffffffffff924

The mplayer get_delay() code reads:

MPlayer-1.0rc2/libao2/ao_alsa.c
  869 /* delay in seconds between first and last sample in buffer */
  870 static float get_delay(void)
  871 {
  872   if (alsa_handler) {
  873     snd_pcm_sframes_t delay;
  874 
  875     if (snd_pcm_delay(alsa_handler, &delay) < 0)
  876       return 0;
  877 
  878     if (delay < 0) {
  879       /* underrun - move the application pointer forward to catch
  up */
  880 #if SND_LIB_VERSION >= 0x000901 /* snd_pcm_forward() exists since
  0.9.0rc8 */
  881       snd_pcm_forward(alsa_handler, -delay);
  882 #endif
  883       delay = 0;
  884     }
  885     return (float)delay / (float)ao_data.samplerate;
  886   } else {
  887     return(0);
  888   }
  889 }

Which is called in the following places:

3 mplayer.c playing_audio_pts      1601 audio_out->get_delay();
4 mplayer.c fill_audio_out_buffers 1823 else if (audio_eof && mpctx->audio_out->get_delay() < .04) {
5 mplayer.c sleep_until_update     1841 float delay = mpctx->audio_out->get_delay();
6 mplayer.c update_video           2026 float delay = playback_speed*mpctx->audio_out->get_delay();

It happen to not cause trouble because
1) in mplayer, the negative delay will be reset to 0 before being returned
2) in ALSA, snd_pcm_playback_forward() will do nothing if avail is negative

Thanks,
Fengguang
