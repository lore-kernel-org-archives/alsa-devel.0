From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/5] ALSA: emu10k1: add optional debug printouts with DMA
 addresses
Date: Mon, 22 Jan 2018 06:07:01 +0800
Message-ID: <201801220517.ZlAl02eD%fengguang.wu@intel.com>
References: <b3853e16-0ac1-d2b5-3473-cac73ef05b05@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3853e16-0ac1-d2b5-3473-cac73ef05b05@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: kbuild-all@01.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.15-rc8 next-20180119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maciej-S-Szmigiero/ALSA-emu10k1-remove-reserved_page/20180122-022950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/pci/emu10k1/memory.c:62:17: sparse: incorrect type in assignment (different base types) @@ expected unsigned int <noident> @@ got ed int <noident> @@
   sound/pci/emu10k1/memory.c:62:17: expected unsigned int <noident>
   sound/pci/emu10k1/memory.c:62:17: got restricted __le32 <noident>
>> sound/pci/emu10k1/memory.c:63:17: sparse: cast to restricted __le32
   sound/pci/emu10k1/memory.c:74:17: sparse: incorrect type in assignment (different base types) @@ expected unsigned int <noident> @@ got ed int <noident> @@
   sound/pci/emu10k1/memory.c:74:17: expected unsigned int <noident>
   sound/pci/emu10k1/memory.c:74:17: got restricted __le32 <noident>
   sound/pci/emu10k1/memory.c:75:17: sparse: cast to restricted __le32

vim +63 sound/pci/emu10k1/memory.c

    48	
    49	#if PAGE_SIZE == 4096 && !IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
    50	/* page size == EMUPAGESIZE */
    51	/* fill PTB entrie(s) corresponding to page with addr */
    52	#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
    53	/* fill PTB entrie(s) corresponding to page with silence pointer */
    54	#define set_silent_ptb(emu,page)	__set_ptb_entry(emu,page,emu->silent_page.addr)
    55	#else
    56	/* fill PTB entries -- we need to fill UNIT_PAGES entries */
    57	static inline void set_ptb_entry(struct snd_emu10k1 *emu, int page, dma_addr_t addr)
    58	{
    59		int i;
    60		page *= UNIT_PAGES;
    61		for (i = 0; i < UNIT_PAGES; i++, page++) {
  > 62			__set_ptb_entry(emu, page, addr);
  > 63			dev_dbg(emu->card->dev, "mapped page %d to entry %.8x\n", page,
    64				(unsigned int)__get_ptb_entry(emu, page));
    65			addr += EMUPAGESIZE;
    66		}
    67	}
    68	static inline void set_silent_ptb(struct snd_emu10k1 *emu, int page)
    69	{
    70		int i;
    71		page *= UNIT_PAGES;
    72		for (i = 0; i < UNIT_PAGES; i++, page++) {
    73			/* do not increment ptr */
    74			__set_ptb_entry(emu, page, emu->silent_page.addr);
    75			dev_dbg(emu->card->dev, "mapped silent page %d to entry %.8x\n",
    76				page, (unsigned int)__get_ptb_entry(emu, page));
    77		}
    78	}
    79	#endif /* PAGE_SIZE */
    80	
    81	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
