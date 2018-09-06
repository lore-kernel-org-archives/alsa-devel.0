From: kbuild test robot <lkp@intel.com>
Subject: [asoc:for-4.20 399/404] sound/soc/soc-dapm.c:3768:9:
 warning: 'ret' may be used uninitialized in this function
Date: Thu, 6 Sep 2018 19:46:38 +0800
Message-ID: <201809061931.yYLg0BtW%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id BB1A026779A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 13:47:55 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-4.20
head:   9ab708aef61f5620113269a9d1bdb1543d1207d0
commit: 4a75aae17b2a802a7267206414050408392c374c [399/404] ASoC: dapm: Add support for multi-CODEC CODEC to CODEC links
config: x86_64-randconfig-x006-201835 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 4a75aae17b2a802a7267206414050408392c374c
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:dapm_power_one_widget
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:snd_soc_dapm_check_dynamic_path
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:soc_dapm_update_bits
   Cyclomatic Complexity 15 sound/soc/soc-dapm.c:dapm_widget_update
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:pop_dbg
   Cyclomatic Complexity 12 sound/soc/soc-dapm.c:dapm_seq_check_event
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:dapm_free_path
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:dapm_kcontrol_free
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:pop_wait
   Cyclomatic Complexity 13 sound/soc/soc-dapm.c:dapm_seq_run_coalesced
   Cyclomatic Complexity 42 sound/soc/soc-dapm.c:dapm_seq_run
   Cyclomatic Complexity 13 sound/soc/soc-dapm.c:dapm_widget_show_component
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:dapm_widget_show
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:dapm_wcache_lookup
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:soc_dapm_read
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:dapm_connect_mux
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:dapm_set_mixer_path_status
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:dapm_connect_mixer
   Cyclomatic Complexity 17 sound/soc/soc-dapm.c:dapm_update_widget_flags
   Cyclomatic Complexity 22 sound/soc/soc-dapm.c:snd_soc_dapm_add_path
   Cyclomatic Complexity 19 sound/soc/soc-dapm.c:snd_soc_dapm_add_route
   Cyclomatic Complexity 10 sound/soc/soc-dapm.c:snd_soc_dapm_del_route
   Cyclomatic Complexity 7 sound/soc/soc-dapm.c:dapm_find_widget
   Cyclomatic Complexity 11 sound/soc/soc-dapm.c:snd_soc_dapm_weak_route
   Cyclomatic Complexity 4 sound/soc/soc-dapm.c:snd_soc_dapm_set_pin
   Cyclomatic Complexity 4 sound/soc/soc-dapm.c:dapm_new_dai_link
   Cyclomatic Complexity 9 sound/soc/soc-dapm.c:dapm_is_shared_kcontrol
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:dapm_kcontrol_add_widget
   Cyclomatic Complexity 17 sound/soc/soc-dapm.c:dapm_widget_power_read_file
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:soc_dapm_test_bits
   Cyclomatic Complexity 8 sound/soc/soc-dapm.c:dapm_supply_check_power
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:snd_soc_dapm_free_kcontrol
   Cyclomatic Complexity 42 sound/soc/soc-dapm.c:snd_soc_dai_link_event
   Cyclomatic Complexity 2 include/linux/device.h:devm_kmalloc_array
   Cyclomatic Complexity 1 include/linux/device.h:devm_kcalloc
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:snd_soc_dapm_alloc_kcontrol
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:dapm_debugfs_cleanup
   Cyclomatic Complexity 7 sound/soc/soc-dapm.c:dapm_mark_endpoints_dirty
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:dapm_kcontrol_get_value
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_kcontrol_widget
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_kcontrol_dapm
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:snd_soc_dapm_force_bias_level
   Cyclomatic Complexity 9 sound/soc/soc-dapm.c:snd_soc_dapm_set_bias_level
   Cyclomatic Complexity 10 sound/soc/soc-dapm.c:dapm_pre_sequence_async
   Cyclomatic Complexity 11 sound/soc/soc-dapm.c:dapm_post_sequence_async
   Cyclomatic Complexity 47 sound/soc/soc-dapm.c:dapm_power_widgets
   Cyclomatic Complexity 9 sound/soc/soc-dapm.c:soc_dapm_mux_update_power
   Cyclomatic Complexity 9 sound/soc/soc-dapm.c:soc_dapm_mixer_update_power
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:soc_dapm_stream_event
   Cyclomatic Complexity 9 sound/soc/soc-dapm.c:soc_dapm_shutdown_dapm
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:snd_soc_dapm_dai_get_connected_widgets
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:dapm_regulator_event
   Cyclomatic Complexity 4 sound/soc/soc-dapm.c:dapm_pinctrl_event
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:dapm_clock_event
   Cyclomatic Complexity 4 sound/soc/soc-dapm.c:snd_soc_dapm_debugfs_init
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:snd_soc_dapm_mux_update_power
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:snd_soc_dapm_mixer_update_power
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:snd_soc_dapm_free_widget
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_reset_cache
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:dapm_free_widgets
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:snd_soc_dapm_sync_unlocked
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_sync
   Cyclomatic Complexity 4 sound/soc/soc-dapm.c:snd_soc_dapm_add_routes
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:snd_soc_dapm_del_routes
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:snd_soc_dapm_weak_routes
   Cyclomatic Complexity 11 sound/soc/soc-dapm.c:snd_soc_dapm_get_volsw
   Cyclomatic Complexity 11 sound/soc/soc-dapm.c:snd_soc_dapm_put_volsw
   Cyclomatic Complexity 5 sound/soc/soc-dapm.c:snd_soc_dapm_get_enum_double
   Cyclomatic Complexity 8 sound/soc/soc-dapm.c:snd_soc_dapm_put_enum_double
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_info_pin_switch
   Cyclomatic Complexity 24 sound/soc/soc-dapm.c:snd_soc_dapm_new_control_unlocked
   Cyclomatic Complexity 13 sound/soc/soc-dapm.c:dapm_kcontrol_data_alloc
   Cyclomatic Complexity 14 sound/soc/soc-dapm.c:dapm_create_or_share_kcontrol
   Cyclomatic Complexity 9 sound/soc/soc-dapm.c:dapm_new_mixer
   Cyclomatic Complexity 10 sound/soc/soc-dapm.c:dapm_new_mux
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:dapm_new_pga
   Cyclomatic Complexity 13 sound/soc/soc-dapm.c:snd_soc_dapm_new_widgets
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:snd_soc_dapm_new_dai
   Cyclomatic Complexity 8 sound/soc/soc-dapm.c:dapm_connect_dai_link_widgets
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_new_control
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:snd_soc_dapm_new_controls
   Cyclomatic Complexity 6 sound/soc/soc-dapm.c:snd_soc_dapm_new_dai_widgets
   Cyclomatic Complexity 14 sound/soc/soc-dapm.c:snd_soc_dapm_link_dai_widgets
   Cyclomatic Complexity 5 sound/soc/soc-dapm.c:snd_soc_dapm_connect_dai_link_widgets
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_stream_event
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_enable_pin_unlocked
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_enable_pin
   Cyclomatic Complexity 3 sound/soc/soc-dapm.c:snd_soc_dapm_force_enable_pin_unlocked
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_force_enable_pin
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_disable_pin_unlocked
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_disable_pin
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:snd_soc_dapm_put_pin_switch
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_nc_pin_unlocked
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_nc_pin
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:snd_soc_dapm_get_pin_status
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_get_pin_switch
   Cyclomatic Complexity 2 sound/soc/soc-dapm.c:snd_soc_dapm_ignore_suspend
   Cyclomatic Complexity 1 sound/soc/soc-dapm.c:snd_soc_dapm_free
   Cyclomatic Complexity 7 sound/soc/soc-dapm.c:snd_soc_dapm_shutdown
   sound/soc/soc-dapm.c: In function 'snd_soc_dai_link_event':
>> sound/soc/soc-dapm.c:3768:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return ret;
            ^~~

vim +/ret +3768 sound/soc/soc-dapm.c

4ba1327a Mark Brown         2008-05-13  3613  
c74184ed Mark Brown         2012-04-04  3614  static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
c74184ed Mark Brown         2012-04-04  3615  				  struct snd_kcontrol *kcontrol, int event)
c74184ed Mark Brown         2012-04-04  3616  {
4a75aae1 Charles Keepax     2018-09-05  3617  	struct snd_soc_dapm_path *path;
c74184ed Mark Brown         2012-04-04  3618  	struct snd_soc_dai *source, *sink;
249dc495 Charles Keepax     2018-08-15  3619  	struct snd_soc_pcm_runtime *rtd = w->priv;
c6615082 Nikesh Oswal       2015-02-02  3620  	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
c74184ed Mark Brown         2012-04-04  3621  	struct snd_pcm_substream substream;
9747cec2 Mark Brown         2012-04-26  3622  	struct snd_pcm_hw_params *params = NULL;
8053f216 Nicolin Chen       2016-07-26  3623  	struct snd_pcm_runtime *runtime = NULL;
3ba66feb Takashi Iwai       2018-07-25  3624  	unsigned int fmt;
c74184ed Mark Brown         2012-04-04  3625  	int ret;
c74184ed Mark Brown         2012-04-04  3626  
bf4edea8 Takashi Iwai       2013-11-07  3627  	if (WARN_ON(!config) ||
a3423b02 Lars-Peter Clausen 2015-08-11  3628  	    WARN_ON(list_empty(&w->edges[SND_SOC_DAPM_DIR_OUT]) ||
a3423b02 Lars-Peter Clausen 2015-08-11  3629  		    list_empty(&w->edges[SND_SOC_DAPM_DIR_IN])))
bf4edea8 Takashi Iwai       2013-11-07  3630  		return -EINVAL;
c74184ed Mark Brown         2012-04-04  3631  
c74184ed Mark Brown         2012-04-04  3632  	/* Be a little careful as we don't want to overflow the mask array */
c74184ed Mark Brown         2012-04-04  3633  	if (config->formats) {
c74184ed Mark Brown         2012-04-04  3634  		fmt = ffs(config->formats) - 1;
c74184ed Mark Brown         2012-04-04  3635  	} else {
30a6a1a4 Liam Girdwood      2012-11-19  3636  		dev_warn(w->dapm->dev, "ASoC: Invalid format %llx specified\n",
c74184ed Mark Brown         2012-04-04  3637  			 config->formats);
c74184ed Mark Brown         2012-04-04  3638  		fmt = 0;
c74184ed Mark Brown         2012-04-04  3639  	}
c74184ed Mark Brown         2012-04-04  3640  
c74184ed Mark Brown         2012-04-04  3641  	/* Currently very limited parameter selection */
9747cec2 Mark Brown         2012-04-26  3642  	params = kzalloc(sizeof(*params), GFP_KERNEL);
9747cec2 Mark Brown         2012-04-26  3643  	if (!params) {
9747cec2 Mark Brown         2012-04-26  3644  		ret = -ENOMEM;
9747cec2 Mark Brown         2012-04-26  3645  		goto out;
9747cec2 Mark Brown         2012-04-26  3646  	}
9747cec2 Mark Brown         2012-04-26  3647  	snd_mask_set(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT), fmt);
c74184ed Mark Brown         2012-04-04  3648  
9747cec2 Mark Brown         2012-04-26  3649  	hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->min =
c74184ed Mark Brown         2012-04-04  3650  		config->rate_min;
9747cec2 Mark Brown         2012-04-26  3651  	hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->max =
c74184ed Mark Brown         2012-04-04  3652  		config->rate_max;
c74184ed Mark Brown         2012-04-04  3653  
9747cec2 Mark Brown         2012-04-26  3654  	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->min
c74184ed Mark Brown         2012-04-04  3655  		= config->channels_min;
9747cec2 Mark Brown         2012-04-26  3656  	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max
c74184ed Mark Brown         2012-04-04  3657  		= config->channels_max;
c74184ed Mark Brown         2012-04-04  3658  
c74184ed Mark Brown         2012-04-04  3659  	memset(&substream, 0, sizeof(substream));
c74184ed Mark Brown         2012-04-04  3660  
8053f216 Nicolin Chen       2016-07-26  3661  	/* Allocate a dummy snd_pcm_runtime for startup() and other ops() */
8053f216 Nicolin Chen       2016-07-26  3662  	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
8053f216 Nicolin Chen       2016-07-26  3663  	if (!runtime) {
8053f216 Nicolin Chen       2016-07-26  3664  		ret = -ENOMEM;
8053f216 Nicolin Chen       2016-07-26  3665  		goto out;
8053f216 Nicolin Chen       2016-07-26  3666  	}
8053f216 Nicolin Chen       2016-07-26  3667  	substream.runtime = runtime;
249dc495 Charles Keepax     2018-08-15  3668  	substream.private_data = rtd;
8053f216 Nicolin Chen       2016-07-26  3669  
c74184ed Mark Brown         2012-04-04  3670  	switch (event) {
c74184ed Mark Brown         2012-04-04  3671  	case SND_SOC_DAPM_PRE_PMU:
c74184ed Mark Brown         2012-04-04  3672  		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
4a75aae1 Charles Keepax     2018-09-05  3673  		snd_soc_dapm_widget_for_each_source_path(w, path) {
4a75aae1 Charles Keepax     2018-09-05  3674  			source = path->source->priv;
4a75aae1 Charles Keepax     2018-09-05  3675  
9900a422 Kuninori Morimoto  2017-09-25  3676  			if (source->driver->ops->startup) {
4a75aae1 Charles Keepax     2018-09-05  3677  				ret = source->driver->ops->startup(&substream,
4a75aae1 Charles Keepax     2018-09-05  3678  								   source);
9b8ef9f6 Jeeja KP           2015-10-20  3679  				if (ret < 0) {
9b8ef9f6 Jeeja KP           2015-10-20  3680  					dev_err(source->dev,
4a75aae1 Charles Keepax     2018-09-05  3681  						"ASoC: startup() failed: %d\n",
4a75aae1 Charles Keepax     2018-09-05  3682  						ret);
9b8ef9f6 Jeeja KP           2015-10-20  3683  					goto out;
9b8ef9f6 Jeeja KP           2015-10-20  3684  				}
9b8ef9f6 Jeeja KP           2015-10-20  3685  				source->active++;
9b8ef9f6 Jeeja KP           2015-10-20  3686  			}
93e6958a Benoit Cousson     2014-07-08  3687  			ret = soc_dai_hw_params(&substream, params, source);
93e6958a Benoit Cousson     2014-07-08  3688  			if (ret < 0)
9747cec2 Mark Brown         2012-04-26  3689  				goto out;
4a75aae1 Charles Keepax     2018-09-05  3690  		}
c74184ed Mark Brown         2012-04-04  3691  
c74184ed Mark Brown         2012-04-04  3692  		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
4a75aae1 Charles Keepax     2018-09-05  3693  		snd_soc_dapm_widget_for_each_sink_path(w, path) {
4a75aae1 Charles Keepax     2018-09-05  3694  			sink = path->sink->priv;
4a75aae1 Charles Keepax     2018-09-05  3695  
9900a422 Kuninori Morimoto  2017-09-25  3696  			if (sink->driver->ops->startup) {
4a75aae1 Charles Keepax     2018-09-05  3697  				ret = sink->driver->ops->startup(&substream,
4a75aae1 Charles Keepax     2018-09-05  3698  								 sink);
9b8ef9f6 Jeeja KP           2015-10-20  3699  				if (ret < 0) {
9b8ef9f6 Jeeja KP           2015-10-20  3700  					dev_err(sink->dev,
4a75aae1 Charles Keepax     2018-09-05  3701  						"ASoC: startup() failed: %d\n",
4a75aae1 Charles Keepax     2018-09-05  3702  						ret);
9b8ef9f6 Jeeja KP           2015-10-20  3703  					goto out;
9b8ef9f6 Jeeja KP           2015-10-20  3704  				}
9b8ef9f6 Jeeja KP           2015-10-20  3705  				sink->active++;
9b8ef9f6 Jeeja KP           2015-10-20  3706  			}
93e6958a Benoit Cousson     2014-07-08  3707  			ret = soc_dai_hw_params(&substream, params, sink);
93e6958a Benoit Cousson     2014-07-08  3708  			if (ret < 0)
9747cec2 Mark Brown         2012-04-26  3709  				goto out;
4a75aae1 Charles Keepax     2018-09-05  3710  		}
c74184ed Mark Brown         2012-04-04  3711  		break;
c74184ed Mark Brown         2012-04-04  3712  
c74184ed Mark Brown         2012-04-04  3713  	case SND_SOC_DAPM_POST_PMU:
4a75aae1 Charles Keepax     2018-09-05  3714  		snd_soc_dapm_widget_for_each_sink_path(w, path) {
4a75aae1 Charles Keepax     2018-09-05  3715  			sink = path->sink->priv;
4a75aae1 Charles Keepax     2018-09-05  3716  
da18396f Mark Brown         2013-02-06  3717  			ret = snd_soc_dai_digital_mute(sink, 0,
da18396f Mark Brown         2013-02-06  3718  						       SNDRV_PCM_STREAM_PLAYBACK);
c74184ed Mark Brown         2012-04-04  3719  			if (ret != 0 && ret != -ENOTSUPP)
4a75aae1 Charles Keepax     2018-09-05  3720  				dev_warn(sink->dev,
4a75aae1 Charles Keepax     2018-09-05  3721  					 "ASoC: Failed to unmute: %d\n", ret);
9747cec2 Mark Brown         2012-04-26  3722  			ret = 0;
4a75aae1 Charles Keepax     2018-09-05  3723  		}
c74184ed Mark Brown         2012-04-04  3724  		break;
c74184ed Mark Brown         2012-04-04  3725  
c74184ed Mark Brown         2012-04-04  3726  	case SND_SOC_DAPM_PRE_PMD:
4a75aae1 Charles Keepax     2018-09-05  3727  		snd_soc_dapm_widget_for_each_sink_path(w, path) {
4a75aae1 Charles Keepax     2018-09-05  3728  			sink = path->sink->priv;
4a75aae1 Charles Keepax     2018-09-05  3729  
da18396f Mark Brown         2013-02-06  3730  			ret = snd_soc_dai_digital_mute(sink, 1,
da18396f Mark Brown         2013-02-06  3731  						       SNDRV_PCM_STREAM_PLAYBACK);
c74184ed Mark Brown         2012-04-04  3732  			if (ret != 0 && ret != -ENOTSUPP)
4a75aae1 Charles Keepax     2018-09-05  3733  				dev_warn(sink->dev,
4a75aae1 Charles Keepax     2018-09-05  3734  					 "ASoC: Failed to mute: %d\n", ret);
9747cec2 Mark Brown         2012-04-26  3735  			ret = 0;
4a75aae1 Charles Keepax     2018-09-05  3736  		}
4a75aae1 Charles Keepax     2018-09-05  3737  
4a75aae1 Charles Keepax     2018-09-05  3738  		snd_soc_dapm_widget_for_each_source_path(w, path) {
4a75aae1 Charles Keepax     2018-09-05  3739  			source = path->source->priv;
9b8ef9f6 Jeeja KP           2015-10-20  3740  
9b8ef9f6 Jeeja KP           2015-10-20  3741  			source->active--;
9900a422 Kuninori Morimoto  2017-09-25  3742  			if (source->driver->ops->shutdown) {
9b8ef9f6 Jeeja KP           2015-10-20  3743  				substream.stream = SNDRV_PCM_STREAM_CAPTURE;
4a75aae1 Charles Keepax     2018-09-05  3744  				source->driver->ops->shutdown(&substream,
4a75aae1 Charles Keepax     2018-09-05  3745  							      source);
4a75aae1 Charles Keepax     2018-09-05  3746  			}
9b8ef9f6 Jeeja KP           2015-10-20  3747  		}
9b8ef9f6 Jeeja KP           2015-10-20  3748  
4a75aae1 Charles Keepax     2018-09-05  3749  		snd_soc_dapm_widget_for_each_sink_path(w, path) {
4a75aae1 Charles Keepax     2018-09-05  3750  			sink = path->sink->priv;
4a75aae1 Charles Keepax     2018-09-05  3751  
9b8ef9f6 Jeeja KP           2015-10-20  3752  			sink->active--;
9900a422 Kuninori Morimoto  2017-09-25  3753  			if (sink->driver->ops->shutdown) {
9b8ef9f6 Jeeja KP           2015-10-20  3754  				substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
9b8ef9f6 Jeeja KP           2015-10-20  3755  				sink->driver->ops->shutdown(&substream, sink);
9b8ef9f6 Jeeja KP           2015-10-20  3756  			}
4a75aae1 Charles Keepax     2018-09-05  3757  		}
c74184ed Mark Brown         2012-04-04  3758  		break;
c74184ed Mark Brown         2012-04-04  3759  
c74184ed Mark Brown         2012-04-04  3760  	default:
a6ed0608 Takashi Iwai       2013-11-06  3761  		WARN(1, "Unknown event %d\n", event);
75881df3 Sudip Mukherjee    2015-09-10  3762  		ret = -EINVAL;
c74184ed Mark Brown         2012-04-04  3763  	}
c74184ed Mark Brown         2012-04-04  3764  
9747cec2 Mark Brown         2012-04-26  3765  out:
8053f216 Nicolin Chen       2016-07-26  3766  	kfree(runtime);
9747cec2 Mark Brown         2012-04-26  3767  	kfree(params);
9747cec2 Mark Brown         2012-04-26 @3768  	return ret;
c74184ed Mark Brown         2012-04-04  3769  }
c74184ed Mark Brown         2012-04-04  3770  

:::::: The code at line 3768 was first introduced by commit
:::::: 9747cec21e2d55ee996249b01ec30dd32389c0ba ASoC: dapm: Move CODEC<->CODEC params off stack

:::::: TO: Mark Brown <broonie@opensource.wolfsonmicro.com>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
o70HDAPFrLEyxv0/q0MnOh18AQA=

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--RnlQjJ0d97Da+TV1--
