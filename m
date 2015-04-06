From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/intel 37/37]
 sound/soc/intel/atom/sst/sst_drv_interface.c:277:19: sparse: cast removes
 address space of expression
Date: Tue, 7 Apr 2015 03:06:06 +0800
Message-ID: <201504070339.UuD6nVub%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jie Yang <yang.jie@intel.com>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
head:   b97169da06992ef04081e66ed22bbdb23dbf6610
commit: b97169da06992ef04081e66ed22bbdb23dbf6610 [37/37] ASoC: Intel: create atom folder and move atom platform files in
reproduce:
  # apt-get install sparse
  git checkout b97169da06992ef04081e66ed22bbdb23dbf6610
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/intel/atom/sst/sst_drv_interface.c:277:19: sparse: cast removes address space of expression
>> sound/soc/intel/atom/sst/sst_drv_interface.c:278:17: sparse: incorrect type in argument 2 (different address spaces)
   sound/soc/intel/atom/sst/sst_drv_interface.c:278:17:    expected void const volatile [noderef] <asn:2>*src
   sound/soc/intel/atom/sst/sst_drv_interface.c:278:17:    got void *
>> sound/soc/intel/atom/sst/sst_drv_interface.c:285:19: sparse: cast removes address space of expression
>> sound/soc/intel/atom/sst/sst_drv_interface.c:285:14: sparse: incorrect type in assignment (different address spaces)
   sound/soc/intel/atom/sst/sst_drv_interface.c:285:14:    expected void [noderef] <asn:2>*addr
   sound/soc/intel/atom/sst/sst_drv_interface.c:285:14:    got void *
>> sound/soc/intel/atom/sst/sst_drv_interface.c:372:19: sparse: cast removes address space of expression
>> sound/soc/intel/atom/sst/sst_drv_interface.c:373:17: sparse: incorrect type in argument 2 (different address spaces)
   sound/soc/intel/atom/sst/sst_drv_interface.c:373:17:    expected void const volatile [noderef] <asn:2>*src
   sound/soc/intel/atom/sst/sst_drv_interface.c:373:17:    got void *
>> sound/soc/intel/atom/sst/sst_drv_interface.c:560:19: sparse: cast removes address space of expression
>> sound/soc/intel/atom/sst/sst_drv_interface.c:561:25: sparse: incorrect type in argument 2 (different address spaces)
   sound/soc/intel/atom/sst/sst_drv_interface.c:561:25:    expected void const volatile [noderef] <asn:2>*src
   sound/soc/intel/atom/sst/sst_drv_interface.c:561:25:    got void *
--
>> sound/soc/intel/atom/sst/sst_loader.c:55:26: sparse: incorrect type in argument 1 (different address spaces)
   sound/soc/intel/atom/sst/sst_loader.c:55:26:    expected void [noderef] <asn:2>*to
   sound/soc/intel/atom/sst/sst_loader.c:55:26:    got void *dst
>> sound/soc/intel/atom/sst/sst_loader.c:55:31: sparse: incorrect type in argument 2 (different address spaces)
   sound/soc/intel/atom/sst/sst_loader.c:55:31:    expected void const *from
   sound/soc/intel/atom/sst/sst_loader.c:55:31:    got void const [noderef] <asn:2>*src
>> sound/soc/intel/atom/sst/sst_loader.c:220:43: sparse: incorrect type in argument 2 (different address spaces)
   sound/soc/intel/atom/sst/sst_loader.c:220:43:    expected void *destn
   sound/soc/intel/atom/sst/sst_loader.c:220:43:    got void [noderef] <asn:2>*
--
>> sound/soc/intel/atom/sst/sst_pvt.c:114:20: sparse: symbol 'read_shim_data' was not declared. Should it be static?
>> sound/soc/intel/atom/sst/sst_pvt.c:127:6: sparse: symbol 'write_shim_data' was not declared. Should it be static?

Please review and possibly fold the followup patch.

vim +277 sound/soc/intel/atom/sst/sst_drv_interface.c

7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  271  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  272  	/* update bytes sent */
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  273  	stream->cumm_bytes += bytes;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  274  	dev_dbg(dev, "bytes copied %d inc by %ld\n", stream->cumm_bytes, bytes);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  275  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  276  	memcpy_fromio(&fw_tstamp,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30 @277  		((void *)(ctx->mailbox + ctx->tstamp)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30 @278  		+(str_id * sizeof(fw_tstamp))),
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  279  		sizeof(fw_tstamp));
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  280  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  281  	fw_tstamp.bytes_copied = stream->cumm_bytes;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  282  	dev_dbg(dev, "bytes sent to fw %llu inc by %ld\n",
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  283  			fw_tstamp.bytes_copied, bytes);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  284  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30 @285  	addr =  ((void *)(ctx->mailbox + ctx->tstamp)) +
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  286  			(str_id * sizeof(fw_tstamp));
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  287  	offset =  offsetof(struct snd_sst_tstamp, bytes_copied);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  288  	sst_shim_write(addr, offset, fw_tstamp.bytes_copied);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  289  	return 0;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  290  }
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  291  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  292  static int sst_cdev_set_metadata(struct device *dev,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  293  		unsigned int str_id, struct snd_compr_metadata *metadata)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  294  {
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  295  	int retval = 0;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  296  	struct stream_info *str_info;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  297  	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  298  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  299  	dev_dbg(dev, "set metadata for stream %d\n", str_id);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  300  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  301  	str_info = get_stream_info(ctx, str_id);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  302  	if (!str_info)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  303  		return -EINVAL;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  304  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  305  	dev_dbg(dev, "pipe id = %d\n", str_info->pipe_id);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  306  	retval = sst_prepare_and_post_msg(ctx, str_info->task_id, IPC_CMD,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  307  			IPC_IA_SET_STREAM_PARAMS_MRFLD, str_info->pipe_id,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  308  			sizeof(*metadata), metadata, NULL,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  309  			true, true, true, false);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  310  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  311  	return retval;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  312  }
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  313  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  314  static int sst_cdev_stream_pause(struct device *dev, unsigned int str_id)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  315  {
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  316  	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  317  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  318  	return sst_pause_stream(ctx, str_id);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  319  }
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  320  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  321  static int sst_cdev_stream_pause_release(struct device *dev,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  322  		unsigned int str_id)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  323  {
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  324  	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  325  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  326  	return sst_resume_stream(ctx, str_id);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  327  }
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  328  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  329  static int sst_cdev_stream_start(struct device *dev, unsigned int str_id)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  330  {
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  331  	struct stream_info *str_info;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  332  	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  333  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  334  	str_info = get_stream_info(ctx, str_id);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  335  	if (!str_info)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  336  		return -EINVAL;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  337  	str_info->prev = str_info->status;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  338  	str_info->status = STREAM_RUNNING;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  339  	return sst_start_stream(ctx, str_id);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  340  }
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  341  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  342  static int sst_cdev_stream_drop(struct device *dev, unsigned int str_id)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  343  {
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  344  	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  345  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  346  	return sst_drop_stream(ctx, str_id);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  347  }
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  348  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  349  static int sst_cdev_stream_drain(struct device *dev, unsigned int str_id)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  350  {
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  351  	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  352  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  353  	return sst_drain_stream(ctx, str_id, false);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  354  }
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  355  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  356  static int sst_cdev_stream_partial_drain(struct device *dev,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  357  		unsigned int str_id)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  358  {
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  359  	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  360  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  361  	return sst_drain_stream(ctx, str_id, true);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  362  }
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  363  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  364  static int sst_cdev_tstamp(struct device *dev, unsigned int str_id,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  365  		struct snd_compr_tstamp *tstamp)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  366  {
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  367  	struct snd_sst_tstamp fw_tstamp = {0,};
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  368  	struct stream_info *stream;
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  369  	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  370  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  371  	memcpy_fromio(&fw_tstamp,
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30 @372  		((void *)(ctx->mailbox + ctx->tstamp)
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30 @373  		+(str_id * sizeof(fw_tstamp))),
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  374  		sizeof(fw_tstamp));
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  375  
7adab122 sound/soc/intel/sst/sst_drv_interface.c Vinod Koul 2014-10-30  376  	stream = get_stream_info(ctx, str_id);

:::::: The code at line 277 was first introduced by commit
:::::: 7adab122a57c5ade8efc2e4de67c72b084c31cda ASoC: Intel: sst - add compressed ops handling

:::::: TO: Vinod Koul <vinod.koul@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
