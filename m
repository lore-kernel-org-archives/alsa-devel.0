From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ALSA: dice: improve support for ancient
 firmware for DICE
Date: Mon, 23 Apr 2018 02:25:36 +0800
Message-ID: <201804230032.0xnJM97d%fengguang.wu@intel.com>
References: <20180422120759.15579-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B95E267284
 for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2018 20:26:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180422120759.15579-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, kbuild-all@01.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.17-rc1 next-20180420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Takashi-Sakamoto/ALSA-dice-improve-support-for-ancient-firmware-for-DICE/20180422-230429
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/firewire/dice/dice-transaction.c:334:21: sparse: restricted __be32 degrades to integer
   sound/firewire/dice/dice-transaction.c:336:21: sparse: restricted __be32 degrades to integer

vim +334 sound/firewire/dice/dice-transaction.c

   264	
   265	static int get_subaddrs(struct snd_dice *dice)
   266	{
   267		static const int min_values[10] = {
   268			10, 0x60 / 4,
   269			10, 0x18 / 4,
   270			10, 0x18 / 4,
   271			0, 0,
   272			0, 0,
   273		};
   274		__be32 *pointers;
   275		__be32 version;
   276		u32 data;
   277		unsigned int i;
   278		int err;
   279	
   280		pointers = kmalloc_array(ARRAY_SIZE(min_values), sizeof(__be32),
   281					 GFP_KERNEL);
   282		if (pointers == NULL)
   283			return -ENOMEM;
   284	
   285		/*
   286		 * Check that the sub address spaces exist and are located inside the
   287		 * private address space.  The minimum values are chosen so that all
   288		 * minimally required registers are included.
   289		 */
   290		err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
   291					 DICE_PRIVATE_SPACE, pointers,
   292					 sizeof(__be32) * ARRAY_SIZE(min_values), 0);
   293		if (err < 0)
   294			goto end;
   295	
   296		for (i = 0; i < ARRAY_SIZE(min_values); ++i) {
   297			data = be32_to_cpu(pointers[i]);
   298			if (data < min_values[i] || data >= 0x40000) {
   299				err = -ENODEV;
   300				goto end;
   301			}
   302		}
   303	
   304		if (be32_to_cpu(pointers[1]) > 0x18) {
   305			/*
   306			 * Check that the implemented DICE driver specification major
   307			 * version number matches.
   308			 */
   309			err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
   310					DICE_PRIVATE_SPACE +
   311					be32_to_cpu(pointers[0]) * 4 + GLOBAL_VERSION,
   312					&version, sizeof(version), 0);
   313			if (err < 0)
   314				goto end;
   315	
   316			if ((version & cpu_to_be32(0xff000000)) !=
   317							cpu_to_be32(0x01000000)) {
   318				dev_err(&dice->unit->device,
   319					"unknown DICE version: 0x%08x\n",
   320					be32_to_cpu(version));
   321				err = -ENODEV;
   322				goto end;
   323			}
   324	
   325			/* Set up later. */
   326			dice->clock_caps = 1;
   327		}
   328	
   329		dice->global_offset = be32_to_cpu(pointers[0]) * 4;
   330		dice->tx_offset = be32_to_cpu(pointers[2]) * 4;
   331		dice->rx_offset = be32_to_cpu(pointers[4]) * 4;
   332	
   333		/* Old firmware doesn't support these fields. */
 > 334		if (pointers[7] > 0)
   335			dice->sync_offset = be32_to_cpu(pointers[6]) * 4;
   336		if (pointers[9] > 0)
   337			dice->rsrv_offset = be32_to_cpu(pointers[8]) * 4;
   338	end:
   339		kfree(pointers);
   340		return err;
   341	}
   342	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
