From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ALSA: hda - Handle error from
 snd_hda_power_up*()
Date: Thu, 28 Jun 2018 12:02:29 +0300
Message-ID: <20180628090229.3r7zevq47el6kx3y@mwanda>
References: <20180627091034.22724-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
In-Reply-To: <20180627091034.22724-2-tiwai@suse.de>
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I love your patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Takashi-Iwai/ALSA-hda-Handle-error-from-snd_hda_power_up/20180627-171524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next

smatch warnings:
sound/pci/hda/hda_controller.c:688 azx_pcm_open() warn: inconsistent returns 'mutex:&chip->open_mutex'.
  Locked on:   line 650
  Unlocked on: line 681

# https://github.com/0day-ci/linux/commit/2e036d491f4b7a4a100b2e1cd7056fac63868245
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 2e036d491f4b7a4a100b2e1cd7056fac63868245
vim +688 sound/pci/hda/hda_controller.c

05e84878 Dylan Reid           2014-02-28  591  
05e84878 Dylan Reid           2014-02-28  592  static int azx_pcm_open(struct snd_pcm_substream *substream)
05e84878 Dylan Reid           2014-02-28  593  {
05e84878 Dylan Reid           2014-02-28  594  	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
820cc6cf Takashi Iwai         2015-02-20  595  	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
05e84878 Dylan Reid           2014-02-28  596  	struct azx *chip = apcm->chip;
05e84878 Dylan Reid           2014-02-28  597  	struct azx_dev *azx_dev;
05e84878 Dylan Reid           2014-02-28  598  	struct snd_pcm_runtime *runtime = substream->runtime;
05e84878 Dylan Reid           2014-02-28  599  	int err;
05e84878 Dylan Reid           2014-02-28  600  	int buff_step;
05e84878 Dylan Reid           2014-02-28  601  
9a6246ff Takashi Iwai         2015-02-27  602  	snd_hda_codec_pcm_get(apcm->info);
05e84878 Dylan Reid           2014-02-28  603  	mutex_lock(&chip->open_mutex);
05e84878 Dylan Reid           2014-02-28  604  	azx_dev = azx_assign_device(chip, substream);
18486508 Libin Yang           2015-05-12  605  	trace_azx_pcm_open(chip, azx_dev);
05e84878 Dylan Reid           2014-02-28  606  	if (azx_dev == NULL) {
61ca4107 Takashi Iwai         2015-02-27  607  		err = -EBUSY;
61ca4107 Takashi Iwai         2015-02-27  608  		goto unlock;
05e84878 Dylan Reid           2014-02-28  609  	}
ccc98865 Takashi Iwai         2015-04-14  610  	runtime->private_data = azx_dev;
50279d9b Guneshwor Singh      2016-08-04  611  
50279d9b Guneshwor Singh      2016-08-04  612  	if (chip->gts_present)
50279d9b Guneshwor Singh      2016-08-04  613  		azx_pcm_hw.info = azx_pcm_hw.info |
50279d9b Guneshwor Singh      2016-08-04  614  			SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME;
50279d9b Guneshwor Singh      2016-08-04  615  
05e84878 Dylan Reid           2014-02-28  616  	runtime->hw = azx_pcm_hw;
05e84878 Dylan Reid           2014-02-28  617  	runtime->hw.channels_min = hinfo->channels_min;
05e84878 Dylan Reid           2014-02-28  618  	runtime->hw.channels_max = hinfo->channels_max;
05e84878 Dylan Reid           2014-02-28  619  	runtime->hw.formats = hinfo->formats;
05e84878 Dylan Reid           2014-02-28  620  	runtime->hw.rates = hinfo->rates;
05e84878 Dylan Reid           2014-02-28  621  	snd_pcm_limit_hw_rates(runtime);
05e84878 Dylan Reid           2014-02-28  622  	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
05e84878 Dylan Reid           2014-02-28  623  
05e84878 Dylan Reid           2014-02-28  624  	/* avoid wrap-around with wall-clock */
05e84878 Dylan Reid           2014-02-28  625  	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
05e84878 Dylan Reid           2014-02-28  626  				     20,
05e84878 Dylan Reid           2014-02-28  627  				     178000000);
05e84878 Dylan Reid           2014-02-28  628  
05e84878 Dylan Reid           2014-02-28  629  	if (chip->align_buffer_size)
05e84878 Dylan Reid           2014-02-28  630  		/* constrain buffer sizes to be multiple of 128
05e84878 Dylan Reid           2014-02-28  631  		   bytes. This is more efficient in terms of memory
05e84878 Dylan Reid           2014-02-28  632  		   access but isn't required by the HDA spec and
05e84878 Dylan Reid           2014-02-28  633  		   prevents users from specifying exact period/buffer
05e84878 Dylan Reid           2014-02-28  634  		   sizes. For example for 44.1kHz, a period size set
05e84878 Dylan Reid           2014-02-28  635  		   to 20ms will be rounded to 19.59ms. */
05e84878 Dylan Reid           2014-02-28  636  		buff_step = 128;
05e84878 Dylan Reid           2014-02-28  637  	else
05e84878 Dylan Reid           2014-02-28  638  		/* Don't enforce steps on buffer sizes, still need to
05e84878 Dylan Reid           2014-02-28  639  		   be multiple of 4 bytes (HDA spec). Tested on Intel
05e84878 Dylan Reid           2014-02-28  640  		   HDA controllers, may not work on all devices where
05e84878 Dylan Reid           2014-02-28  641  		   option needs to be disabled */
05e84878 Dylan Reid           2014-02-28  642  		buff_step = 4;
05e84878 Dylan Reid           2014-02-28  643  
05e84878 Dylan Reid           2014-02-28  644  	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
05e84878 Dylan Reid           2014-02-28  645  				   buff_step);
05e84878 Dylan Reid           2014-02-28  646  	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
05e84878 Dylan Reid           2014-02-28  647  				   buff_step);
2e036d49 Takashi Iwai         2018-06-27  648  	err = snd_hda_power_up(apcm->codec);
2e036d49 Takashi Iwai         2018-06-27  649  	if (err < 0)
2e036d49 Takashi Iwai         2018-06-27  650  		return err;
                                                        ^^^^^^^^^^
Needs to be a "goto unlock;"

61ca4107 Takashi Iwai         2015-02-27  651  	if (hinfo->ops.open)
05e84878 Dylan Reid           2014-02-28  652  		err = hinfo->ops.open(hinfo, apcm->codec, substream);
61ca4107 Takashi Iwai         2015-02-27  653  	else
61ca4107 Takashi Iwai         2015-02-27  654  		err = -ENODEV;
05e84878 Dylan Reid           2014-02-28  655  	if (err < 0) {
05e84878 Dylan Reid           2014-02-28  656  		azx_release_device(azx_dev);
61ca4107 Takashi Iwai         2015-02-27  657  		goto powerdown;
05e84878 Dylan Reid           2014-02-28  658  	}
05e84878 Dylan Reid           2014-02-28  659  	snd_pcm_limit_hw_rates(runtime);
05e84878 Dylan Reid           2014-02-28  660  	/* sanity check */
05e84878 Dylan Reid           2014-02-28  661  	if (snd_BUG_ON(!runtime->hw.channels_min) ||
05e84878 Dylan Reid           2014-02-28  662  	    snd_BUG_ON(!runtime->hw.channels_max) ||
05e84878 Dylan Reid           2014-02-28  663  	    snd_BUG_ON(!runtime->hw.formats) ||
05e84878 Dylan Reid           2014-02-28  664  	    snd_BUG_ON(!runtime->hw.rates)) {
05e84878 Dylan Reid           2014-02-28  665  		azx_release_device(azx_dev);
61ca4107 Takashi Iwai         2015-02-27  666  		if (hinfo->ops.close)
05e84878 Dylan Reid           2014-02-28  667  			hinfo->ops.close(hinfo, apcm->codec, substream);
61ca4107 Takashi Iwai         2015-02-27  668  		err = -EINVAL;
61ca4107 Takashi Iwai         2015-02-27  669  		goto powerdown;
05e84878 Dylan Reid           2014-02-28  670  	}
05e84878 Dylan Reid           2014-02-28  671  
9e94df3a Pierre-Louis Bossart 2015-02-13  672  	/* disable LINK_ATIME timestamps for capture streams
05e84878 Dylan Reid           2014-02-28  673  	   until we figure out how to handle digital inputs */
9e94df3a Pierre-Louis Bossart 2015-02-13  674  	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
9e94df3a Pierre-Louis Bossart 2015-02-13  675  		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_WALL_CLOCK; /* legacy */
9e94df3a Pierre-Louis Bossart 2015-02-13  676  		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_LINK_ATIME;
9e94df3a Pierre-Louis Bossart 2015-02-13  677  	}
05e84878 Dylan Reid           2014-02-28  678  
05e84878 Dylan Reid           2014-02-28  679  	snd_pcm_set_sync(substream);
05e84878 Dylan Reid           2014-02-28  680  	mutex_unlock(&chip->open_mutex);
05e84878 Dylan Reid           2014-02-28  681  	return 0;
61ca4107 Takashi Iwai         2015-02-27  682  
61ca4107 Takashi Iwai         2015-02-27  683   powerdown:
61ca4107 Takashi Iwai         2015-02-27  684  	snd_hda_power_down(apcm->codec);
61ca4107 Takashi Iwai         2015-02-27  685   unlock:
61ca4107 Takashi Iwai         2015-02-27  686  	mutex_unlock(&chip->open_mutex);
9a6246ff Takashi Iwai         2015-02-27  687  	snd_hda_codec_pcm_put(apcm->info);
61ca4107 Takashi Iwai         2015-02-27 @688  	return err;
05e84878 Dylan Reid           2014-02-28  689  }
05e84878 Dylan Reid           2014-02-28  690  
