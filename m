From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/uniphier 6/7]
 sound/soc/uniphier/aio-compress.c:314:34: sparse: cast to restricted __be16
Date: Tue, 13 Feb 2018 02:19:54 +0800
Message-ID: <201802130250.filbAbNc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CDAC2673EF
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 19:20:43 +0100 (CET)
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
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/uniphier
head:   db4cb3d04eba91db48da0032c44b83ed7185973c
commit: e98131222ff931a670739cede00d1fb9d6f83763 [6/7] ASoC: uniphier: add support for UniPhier AIO compress audio
reproduce:
        # apt-get install sparse
        git checkout e98131222ff931a670739cede00d1fb9d6f83763
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/uniphier/aio-compress.c:314:34: sparse: cast to restricted __be16
>> sound/soc/uniphier/aio-compress.c:314:34: sparse: cast to restricted __be16
>> sound/soc/uniphier/aio-compress.c:314:34: sparse: cast to restricted __be16
>> sound/soc/uniphier/aio-compress.c:314:34: sparse: cast to restricted __be16

vim +314 sound/soc/uniphier/aio-compress.c

   290	
   291	static int aio_compr_send_to_hw(struct uniphier_aio_sub *sub,
   292					char __user *buf, size_t dstsize)
   293	{
   294		u32 __user *srcbuf = (u32 __user *)buf;
   295		u32 *dstbuf = (u32 *)(sub->compr_area + sub->wr_offs);
   296		int src = 0, dst = 0, ret;
   297		u32 frm, frm_a, frm_b;
   298	
   299		while (dstsize > 0) {
   300			ret = get_user(frm, srcbuf + src);
   301			if (ret)
   302				return ret;
   303			src++;
   304	
   305			frm_a = frm & 0xffff;
   306			frm_b = (frm >> 16) & 0xffff;
   307	
   308			if (frm == IEC61937_HEADER_SIGN) {
   309				frm_a |= 0x01000000;
   310	
   311				/* Next data is Pc and Pd */
   312				sub->iec_header = true;
   313			} else {
 > 314				u16 pc = be16_to_cpu((__be16)frm_a);
   315	
   316				if (sub->iec_header && sub->iec_pc != pc) {
   317					/* Force overwrite IEC frame type */
   318					sub->iec_pc = pc;
   319					ret = aio_oport_set_stream_type(sub, pc);
   320					if (ret)
   321						return ret;
   322				}
   323				sub->iec_header = false;
   324			}
   325			dstbuf[dst++] = frm_a;
   326			dstbuf[dst++] = frm_b;
   327	
   328			dstsize -= sizeof(u32) * 2;
   329		}
   330	
   331		return 0;
   332	}
   333	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
