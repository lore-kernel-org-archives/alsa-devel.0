From: kbuild test robot <lkp@intel.com>
Subject: [sound:topic/soc-cx2072x-5.2 1/2]
 sound/soc/codecs/cx2072x.c:597:18: sparse: sparse: cast to restricted
 __le32
Date: Fri, 3 May 2019 08:15:43 +0800
Message-ID: <201905030839.woSHsder%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 714B7F8075A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 02:16:24 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Simon Ho <simon.ho@conexant.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/soc-cx2072x-5.2
head:   19e7a6a1d903117b3f4520690e7f399a53852c44
commit: b3d0d3217c3c84b473918b74c33f2d626c49d267 [1/2] ASoC: Add support for Conexant CX2071X CODEC
reproduce:
        # apt-get install sparse
        git checkout b3d0d3217c3c84b473918b74c33f2d626c49d267
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/cx2072x.c:597:18: sparse: sparse: cast to restricted __le32

vim +597 sound/soc/codecs/cx2072x.c

   564	
   565	static int cx2072x_reg_read(void *context, unsigned int reg,
   566				    unsigned int *value)
   567	{
   568		struct i2c_client *client = context;
   569		struct device *dev = &client->dev;
   570		unsigned int recv_buf = 0;
   571		struct i2c_msg msgs[2];
   572		unsigned int size;
   573		u8 send_buf[2];
   574		int ret;
   575	
   576		size = cx2072x_register_size(reg);
   577	
   578		send_buf[0] = reg >> 8;
   579		send_buf[1] = reg & 0xff;
   580	
   581		msgs[0].addr = client->addr;
   582		msgs[0].len = sizeof(send_buf);
   583		msgs[0].buf = send_buf;
   584		msgs[0].flags = 0;
   585	
   586		msgs[1].addr = client->addr;
   587		msgs[1].len = size;
   588		msgs[1].buf = (u8 *)&recv_buf;
   589		msgs[1].flags = I2C_M_RD;
   590	
   591		ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
   592		if (ret != ARRAY_SIZE(msgs)) {
   593			dev_err(dev, "Failed to read register, ret = %d\n", ret);
   594			return ret < 0 ? ret : -EIO;
   595		}
   596	
 > 597		*value = le32_to_cpu(recv_buf);
   598		return 0;
   599	}
   600	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
