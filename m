From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: memalloc: declare
 snd_sgbuf_aligned_pages() unconditionally
Date: Fri, 27 Jul 2018 09:54:20 -0500
Message-ID: <60099a07-aedd-e1c3-e0f1-6af46da69901@linux.intel.com>
References: <20180725201556.21136-1-pierre-louis.bossart@linux.intel.com>
 <201807262256.hwoGoA35%fengguang.wu@intel.com> <s5hfu05uuts.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B9E026720C
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 16:54:30 +0200 (CEST)
In-Reply-To: <s5hfu05uuts.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, kbuild test robot <lkp@intel.com>
Cc: liam.r.girdwood@linux.intel.com, vkoul@kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On 7/27/18 12:11 AM, Takashi Iwai wrote:
> On Thu, 26 Jul 2018 16:51:55 +0200,
> kbuild test robot wrote:
>>
>> Hi Pierre-Louis,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on sound/for-next]
>> [also build test ERROR on v4.18-rc6 next-20180725]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Pierre-Louis-Bossart/ALSA-memalloc-declare-snd_sgbuf_aligned_pages-unconditionally/20180726-192035
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
>> config: alpha-allyesconfig (attached as .config)
>> compiler: alpha-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=7.2.0 make.cross ARCH=alpha
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from include/sound/pcm.h:27:0,
>>                      from sound/core/pcm_iec958.c:11:
>>     include/sound/memalloc.h: In function 'snd_sgbuf_aligned_pages':
>>>> include/sound/memalloc.h:75:17: error: 'PAGE_SIZE' undeclared (first use in this function); did you mean 'TASK_SIZE'?
>>       return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>                      ^~~~~~~~~
>>                      TASK_SIZE
> 
> OK, we need to include <asm/page.h> in this header file.
> 
> Pierre, care to resend with the fix?

yes, will do later today.
