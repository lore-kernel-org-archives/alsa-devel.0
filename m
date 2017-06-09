From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:for-linus 17/20]
 sound/drivers/opl3/opl3_oss.c:256:22: sparse: incompatible types for 'case'
 statement
Date: Sat, 10 Jun 2017 05:32:17 +0800
Message-ID: <201706100548.4CxWlgsn%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E4762676E3
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 23:32:23 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-linus
head:   8c6e31b25e15da191e3f2dafe3223f0eadc2db7f
commit: d710684b7e2ee5500b6ced18f69fbb05c05cad60 [17/20] ALSA: seq: Allow the tristate build of OSS emulation
reproduce:
        # apt-get install sparse
        git checkout d710684b7e2ee5500b6ced18f69fbb05c05cad60
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
   sound/drivers/opl3/opl3_oss.c:172:12: sparse: using member 'private_data' in incomplete struct snd_seq_oss_arg
   sound/drivers/opl3/opl3_oss.c:173:12: sparse: using member 'addr' in incomplete struct snd_seq_oss_arg
   sound/drivers/opl3/opl3_oss.c:174:12: sparse: using member 'addr' in incomplete struct snd_seq_oss_arg
   sound/drivers/opl3/opl3_oss.c:190:19: sparse: using member 'private_data' in incomplete struct snd_seq_oss_arg
   sound/drivers/opl3/opl3_oss.c:254:19: sparse: using member 'private_data' in incomplete struct snd_seq_oss_arg
   sound/drivers/opl3/opl3_oss.c:256:22: sparse: undefined identifier 'SNDCTL_FM_LOAD_INSTR'
   sound/drivers/opl3/opl3_oss.c:262:22: sparse: undefined identifier 'SNDCTL_SYNTH_MEMAVL'
   sound/drivers/opl3/opl3_oss.c:265:22: sparse: undefined identifier 'SNDCTL_FM_4OP_ENABLE'
>> sound/drivers/opl3/opl3_oss.c:256:22: sparse: incompatible types for 'case' statement
   sound/drivers/opl3/opl3_oss.c:262:22: sparse: incompatible types for 'case' statement
   sound/drivers/opl3/opl3_oss.c:265:22: sparse: incompatible types for 'case' statement
   sound/drivers/opl3/opl3_oss.c:213:19: sparse: using member 'private_data' in incomplete struct snd_seq_oss_arg
   sound/drivers/opl3/opl3_oss.c:215:23: sparse: undefined identifier 'FM_PATCH'
   sound/drivers/opl3/opl3_oss.c:217:28: sparse: undefined identifier 'OPL3_PATCH'
   sound/drivers/opl3/opl3_oss.c:229:16: sparse: using member 'channel' in incomplete struct sbi_instrument
   sound/drivers/opl3/opl3_oss.c:230:17: sparse: using member 'channel' in incomplete struct sbi_instrument
   sound/drivers/opl3/opl3_oss.c:236:36: sparse: using member 'channel' in incomplete struct sbi_instrument
   sound/drivers/opl3/opl3_oss.c:238:44: sparse: using member 'channel' in incomplete struct sbi_instrument
   sound/drivers/opl3/opl3_oss.c:282:19: sparse: using member 'private_data' in incomplete struct snd_seq_oss_arg
   sound/drivers/opl3/opl3_oss.c:49:10: sparse: unknown field name in initializer
   sound/drivers/opl3/opl3_oss.c:50:10: sparse: unknown field name in initializer
   sound/drivers/opl3/opl3_oss.c:51:10: sparse: unknown field name in initializer
   sound/drivers/opl3/opl3_oss.c:52:10: sparse: unknown field name in initializer
   sound/drivers/opl3/opl3_oss.c:53:10: sparse: unknown field name in initializer
   sound/drivers/opl3/opl3_oss.c:54:10: sparse: unknown field name in initializer
   sound/drivers/opl3/opl3_oss.c:63:59: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:73:39: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:84:13: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:85:17: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:87:13: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:98:13: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:99:13: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:107:17: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:109:28: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:110:47: sparse: no member 'oss_chset' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:124:47: sparse: undefined identifier 'SNDRV_SEQ_DEV_ID_OSS'
   sound/drivers/opl3/opl3_oss.c:128:13: sparse: no member 'oss_seq_dev' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:131:12: sparse: using member 'type' in incomplete struct snd_seq_oss_reg
   sound/drivers/opl3/opl3_oss.c:133:20: sparse: using member 'subtype' in incomplete struct snd_seq_oss_reg
   sound/drivers/opl3/opl3_oss.c:134:20: sparse: using member 'nvoices' in incomplete struct snd_seq_oss_reg
   sound/drivers/opl3/opl3_oss.c:136:20: sparse: using member 'subtype' in incomplete struct snd_seq_oss_reg
   sound/drivers/opl3/opl3_oss.c:137:20: sparse: using member 'nvoices' in incomplete struct snd_seq_oss_reg
   sound/drivers/opl3/opl3_oss.c:139:12: sparse: using member 'oper' in incomplete struct snd_seq_oss_reg
   sound/drivers/opl3/opl3_oss.c:140:12: sparse: using member 'private_data' in incomplete struct snd_seq_oss_reg
   sound/drivers/opl3/opl3_oss.c:151:17: sparse: no member 'oss_seq_dev' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:153:21: sparse: no member 'oss_seq_dev' in struct snd_opl3
   sound/drivers/opl3/opl3_oss.c:256:22: sparse: Expected constant expression in case statement
   sound/drivers/opl3/opl3_oss.c:262:22: sparse: Expected constant expression in case statement
   sound/drivers/opl3/opl3_oss.c:265:22: sparse: Expected constant expression in case statement
   sound/drivers/opl3/opl3_oss.c:24:41: warning: 'struct snd_seq_oss_arg' declared inside parameter list will not be visible outside of this definition or declaration
    static int snd_opl3_open_seq_oss(struct snd_seq_oss_arg *arg, void *closure);
                                            ^~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:25:42: warning: 'struct snd_seq_oss_arg' declared inside parameter list will not be visible outside of this definition or declaration
    static int snd_opl3_close_seq_oss(struct snd_seq_oss_arg *arg);
                                             ^~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:26:42: warning: 'struct snd_seq_oss_arg' declared inside parameter list will not be visible outside of this definition or declaration
    static int snd_opl3_ioctl_seq_oss(struct snd_seq_oss_arg *arg, unsigned int cmd, unsigned long ioarg);
                                             ^~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:27:47: warning: 'struct snd_seq_oss_arg' declared inside parameter list will not be visible outside of this definition or declaration
    static int snd_opl3_load_patch_seq_oss(struct snd_seq_oss_arg *arg, int format, const char __user *buf, int offs, int count);
                                                  ^~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:28:42: warning: 'struct snd_seq_oss_arg' declared inside parameter list will not be visible outside of this definition or declaration
    static int snd_opl3_reset_seq_oss(struct snd_seq_oss_arg *arg);
                                             ^~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:48:15: error: variable 'oss_callback' has initializer but incomplete type
    static struct snd_seq_oss_callback oss_callback = {
                  ^~~~~~~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:49:2: error: unknown field 'owner' specified in initializer
     .owner =  THIS_MODULE,
     ^
   In file included from sound/drivers/opl3/opl3_oss.c:21:0:
   include/linux/export.h:35:21: warning: excess elements in struct initializer
    #define THIS_MODULE (&__this_module)
                        ^
   sound/drivers/opl3/opl3_oss.c:49:12: note: in expansion of macro 'THIS_MODULE'
     .owner =  THIS_MODULE,
               ^~~~~~~~~~~
   include/linux/export.h:35:21: note: (near initialization for 'oss_callback')
    #define THIS_MODULE (&__this_module)
                        ^
   sound/drivers/opl3/opl3_oss.c:49:12: note: in expansion of macro 'THIS_MODULE'
     .owner =  THIS_MODULE,
               ^~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:50:2: error: unknown field 'open' specified in initializer
     .open =  snd_opl3_open_seq_oss,
     ^
   sound/drivers/opl3/opl3_oss.c:50:11: warning: excess elements in struct initializer
     .open =  snd_opl3_open_seq_oss,
              ^~~~~~~~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:50:11: note: (near initialization for 'oss_callback')
   sound/drivers/opl3/opl3_oss.c:51:2: error: unknown field 'close' specified in initializer
     .close = snd_opl3_close_seq_oss,
     ^
   sound/drivers/opl3/opl3_oss.c:51:11: warning: excess elements in struct initializer
     .close = snd_opl3_close_seq_oss,
              ^~~~~~~~~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:51:11: note: (near initialization for 'oss_callback')
   sound/drivers/opl3/opl3_oss.c:52:2: error: unknown field 'ioctl' specified in initializer
     .ioctl = snd_opl3_ioctl_seq_oss,
     ^
   sound/drivers/opl3/opl3_oss.c:52:11: warning: excess elements in struct initializer
     .ioctl = snd_opl3_ioctl_seq_oss,
              ^~~~~~~~~~~~~~~~~~~~~~
   sound/drivers/opl3/opl3_oss.c:52:11: note: (near initialization for 'oss_callback')
   sound/drivers/opl3/opl3_oss.c:53:2: error: unknown field 'load_patch' specified in initializer
     .load_patch = snd_opl3_load_patch_seq_oss,
     ^
   sound/drivers/opl3/opl3_oss.c:53:16: warning: excess elements in struct initializer
     .load_patch = snd_opl3_load_patch_seq_oss,

vim +/case +256 sound/drivers/opl3/opl3_oss.c

5e246b85 Takashi Iwai   2008-08-08  166  		return -ENXIO;
^1da177e Linus Torvalds 2005-04-16  167  
^1da177e Linus Torvalds 2005-04-16  168  	if ((err = snd_opl3_synth_setup(opl3)) < 0)
^1da177e Linus Torvalds 2005-04-16  169  		return err;
^1da177e Linus Torvalds 2005-04-16  170  
^1da177e Linus Torvalds 2005-04-16  171  	/* fill the argument data */
^1da177e Linus Torvalds 2005-04-16 @172  	arg->private_data = opl3;
^1da177e Linus Torvalds 2005-04-16  173  	arg->addr.client = opl3->oss_chset->client;
^1da177e Linus Torvalds 2005-04-16  174  	arg->addr.port = opl3->oss_chset->port;
^1da177e Linus Torvalds 2005-04-16  175  
^1da177e Linus Torvalds 2005-04-16  176  	if ((err = snd_opl3_synth_use_inc(opl3)) < 0)
^1da177e Linus Torvalds 2005-04-16  177  		return err;
^1da177e Linus Torvalds 2005-04-16  178  
^1da177e Linus Torvalds 2005-04-16  179  	opl3->synth_mode = SNDRV_OPL3_MODE_SYNTH;
^1da177e Linus Torvalds 2005-04-16  180  	return 0;
^1da177e Linus Torvalds 2005-04-16  181  }
^1da177e Linus Torvalds 2005-04-16  182  
^1da177e Linus Torvalds 2005-04-16  183  /* close OSS sequencer */
5b1646a8 Takashi Iwai   2005-11-17  184  static int snd_opl3_close_seq_oss(struct snd_seq_oss_arg *arg)
^1da177e Linus Torvalds 2005-04-16  185  {
5b1646a8 Takashi Iwai   2005-11-17  186  	struct snd_opl3 *opl3;
^1da177e Linus Torvalds 2005-04-16  187  
5e246b85 Takashi Iwai   2008-08-08  188  	if (snd_BUG_ON(!arg))
5e246b85 Takashi Iwai   2008-08-08  189  		return -ENXIO;
^1da177e Linus Torvalds 2005-04-16  190  	opl3 = arg->private_data;
^1da177e Linus Torvalds 2005-04-16  191  
^1da177e Linus Torvalds 2005-04-16  192  	snd_opl3_synth_cleanup(opl3);
^1da177e Linus Torvalds 2005-04-16  193  
^1da177e Linus Torvalds 2005-04-16  194  	snd_opl3_synth_use_dec(opl3);
^1da177e Linus Torvalds 2005-04-16  195  	return 0;
^1da177e Linus Torvalds 2005-04-16  196  }
^1da177e Linus Torvalds 2005-04-16  197  
^1da177e Linus Torvalds 2005-04-16  198  /* load patch */
^1da177e Linus Torvalds 2005-04-16  199  
^1da177e Linus Torvalds 2005-04-16  200  /* from sound_config.h */
^1da177e Linus Torvalds 2005-04-16  201  #define SBFM_MAXINSTR	256
^1da177e Linus Torvalds 2005-04-16  202  
5b1646a8 Takashi Iwai   2005-11-17  203  static int snd_opl3_load_patch_seq_oss(struct snd_seq_oss_arg *arg, int format,
^1da177e Linus Torvalds 2005-04-16  204  				       const char __user *buf, int offs, int count)
^1da177e Linus Torvalds 2005-04-16  205  {
5b1646a8 Takashi Iwai   2005-11-17  206  	struct snd_opl3 *opl3;
224a0332 Takashi Iwai   2007-10-30  207  	struct sbi_instrument sbi;
224a0332 Takashi Iwai   2007-10-30  208  	char name[32];
224a0332 Takashi Iwai   2007-10-30  209  	int err, type;
^1da177e Linus Torvalds 2005-04-16  210  
5e246b85 Takashi Iwai   2008-08-08  211  	if (snd_BUG_ON(!arg))
5e246b85 Takashi Iwai   2008-08-08  212  		return -ENXIO;
^1da177e Linus Torvalds 2005-04-16  213  	opl3 = arg->private_data;
^1da177e Linus Torvalds 2005-04-16  214  
224a0332 Takashi Iwai   2007-10-30  215  	if (format == FM_PATCH)
224a0332 Takashi Iwai   2007-10-30  216  		type = FM_PATCH_OPL2;
224a0332 Takashi Iwai   2007-10-30  217  	else if (format == OPL3_PATCH)
224a0332 Takashi Iwai   2007-10-30  218  		type = FM_PATCH_OPL3;
224a0332 Takashi Iwai   2007-10-30  219  	else
224a0332 Takashi Iwai   2007-10-30  220  		return -EINVAL;
^1da177e Linus Torvalds 2005-04-16  221  
^1da177e Linus Torvalds 2005-04-16  222  	if (count < (int)sizeof(sbi)) {
45203832 Takashi Iwai   2009-02-05  223  		snd_printk(KERN_ERR "FM Error: Patch record too short\n");
^1da177e Linus Torvalds 2005-04-16  224  		return -EINVAL;
^1da177e Linus Torvalds 2005-04-16  225  	}
^1da177e Linus Torvalds 2005-04-16  226  	if (copy_from_user(&sbi, buf, sizeof(sbi)))
^1da177e Linus Torvalds 2005-04-16  227  		return -EFAULT;
^1da177e Linus Torvalds 2005-04-16  228  
^1da177e Linus Torvalds 2005-04-16  229  	if (sbi.channel < 0 || sbi.channel >= SBFM_MAXINSTR) {
45203832 Takashi Iwai   2009-02-05  230  		snd_printk(KERN_ERR "FM Error: Invalid instrument number %d\n",
224a0332 Takashi Iwai   2007-10-30  231  			   sbi.channel);
^1da177e Linus Torvalds 2005-04-16  232  		return -EINVAL;
^1da177e Linus Torvalds 2005-04-16  233  	}
^1da177e Linus Torvalds 2005-04-16  234  
224a0332 Takashi Iwai   2007-10-30  235  	memset(name, 0, sizeof(name));
224a0332 Takashi Iwai   2007-10-30  236  	sprintf(name, "Chan%d", sbi.channel);
^1da177e Linus Torvalds 2005-04-16  237  
224a0332 Takashi Iwai   2007-10-30  238  	err = snd_opl3_load_patch(opl3, sbi.channel, 127, type, name, NULL,
224a0332 Takashi Iwai   2007-10-30  239  				  sbi.operators);
224a0332 Takashi Iwai   2007-10-30  240  	if (err < 0)
^1da177e Linus Torvalds 2005-04-16  241  		return err;
224a0332 Takashi Iwai   2007-10-30  242  
224a0332 Takashi Iwai   2007-10-30  243  	return sizeof(sbi);
^1da177e Linus Torvalds 2005-04-16  244  }
^1da177e Linus Torvalds 2005-04-16  245  
^1da177e Linus Torvalds 2005-04-16  246  /* ioctl */
5b1646a8 Takashi Iwai   2005-11-17  247  static int snd_opl3_ioctl_seq_oss(struct snd_seq_oss_arg *arg, unsigned int cmd,
^1da177e Linus Torvalds 2005-04-16  248  				  unsigned long ioarg)
^1da177e Linus Torvalds 2005-04-16  249  {
5b1646a8 Takashi Iwai   2005-11-17  250  	struct snd_opl3 *opl3;
^1da177e Linus Torvalds 2005-04-16  251  
5e246b85 Takashi Iwai   2008-08-08  252  	if (snd_BUG_ON(!arg))
5e246b85 Takashi Iwai   2008-08-08  253  		return -ENXIO;
^1da177e Linus Torvalds 2005-04-16  254  	opl3 = arg->private_data;
^1da177e Linus Torvalds 2005-04-16  255  	switch (cmd) {
^1da177e Linus Torvalds 2005-04-16 @256  		case SNDCTL_FM_LOAD_INSTR:
45203832 Takashi Iwai   2009-02-05  257  			snd_printk(KERN_ERR "OPL3: "
45203832 Takashi Iwai   2009-02-05  258  				   "Obsolete ioctl(SNDCTL_FM_LOAD_INSTR) used. "
45203832 Takashi Iwai   2009-02-05  259  				   "Fix the program.\n");

:::::: The code at line 256 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
