From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [sound:topic/hda-ca0132-dsp 4/11]
 sound/pci/hda/patch_ca0132.c:714 dspio_send() warn: always true condition
 '(res >= 0) => (0-u32max >= 0)'
Date: Mon, 17 Dec 2012 20:35:43 +0300
Message-ID: <20121217173543.GU5083@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id E94F62602C6
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 18:35:56 +0100 (CET)
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
To: Ian Minett <ian_minett@creativelabs.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild@01.org
List-Id: alsa-devel@alsa-project.org

Hi Ian,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/hda-ca0132-dsp
head:   cdc83c59e59d57b250be46c4b9d31e3b2b5ae589
commit: 01ef7dbffb411d9d78d1150b268d9c757f9f2f93 [4/11] ALSA: hda - Update CA0132 codec to load DSP firmware binary

+ sound/pci/hda/patch_ca0132.c:714 dspio_send() warn: always true condition '(res >= 0) => (0-u32max >= 0)'
  sound/pci/hda/patch_ca0132.c:1781 dspxfr_one_seg() info: why not propagate 'status' from dsp_dma_stop() instead of (-5)?
  sound/pci/hda/patch_ca0132.c:1950 dspxfr_image() error: potential null dereference 'dma_engine'.  (kzalloc returns null)
  sound/pci/hda/patch_ca0132.c:1950 dspxfr_image() error: we previously assumed 'dma_engine' could be null (see line 1857)

git remote add sound git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
git remote update sound
git checkout 01ef7dbffb411d9d78d1150b268d9c757f9f2f93
vim +714 sound/pci/hda/patch_ca0132.c

01ef7dbf Ian Minett 2012-09-20  698  			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xff);
01ef7dbf Ian Minett 2012-09-20  699  	mutex_unlock(&spec->chipio_mutex);
01ef7dbf Ian Minett 2012-09-20  700  }
01ef7dbf Ian Minett 2012-09-20  701  
01ef7dbf Ian Minett 2012-09-20  702  /*
01ef7dbf Ian Minett 2012-09-20  703   * CA0132 DSP IO stuffs
01ef7dbf Ian Minett 2012-09-20  704   */
01ef7dbf Ian Minett 2012-09-20  705  static int dspio_send(struct hda_codec *codec, unsigned int reg,
01ef7dbf Ian Minett 2012-09-20  706  		      unsigned int data)
01ef7dbf Ian Minett 2012-09-20  707  {
01ef7dbf Ian Minett 2012-09-20  708  	unsigned int res;
01ef7dbf Ian Minett 2012-09-20  709  	int retry = 50;
01ef7dbf Ian Minett 2012-09-20  710  
01ef7dbf Ian Minett 2012-09-20  711  	/* send bits of data specified by reg to dsp */
01ef7dbf Ian Minett 2012-09-20  712  	do {
01ef7dbf Ian Minett 2012-09-20  713  		res = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0, reg, data);
01ef7dbf Ian Minett 2012-09-20 @714  		if ((res >= 0) && (res != VENDOR_STATUS_DSPIO_BUSY))
01ef7dbf Ian Minett 2012-09-20  715  			return res;
01ef7dbf Ian Minett 2012-09-20  716  	} while (--retry);
01ef7dbf Ian Minett 2012-09-20  717  
01ef7dbf Ian Minett 2012-09-20  718  	return -EIO;
01ef7dbf Ian Minett 2012-09-20  719  }
01ef7dbf Ian Minett 2012-09-20  720  
01ef7dbf Ian Minett 2012-09-20  721  static void dspio_write_wait(struct hda_codec *codec)
01ef7dbf Ian Minett 2012-09-20  722  {

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
