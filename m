From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/4] ALSA: usb-audio: AudioStreaming Power Domain parsing
Date: Fri, 20 Jul 2018 01:48:10 +0800
Message-ID: <201807200103.6g4nrbJl%fengguang.wu@intel.com>
References: <20180719112215.4219-3-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180719112215.4219-3-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: kbuild-all@01.org, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Jorge,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.18-rc5 next-20180719]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jorge-Sanjuan/usb-audio-Add-UAC3-Power-Domains/20180719-212009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/usb/stream.c:562:5: sparse: symbol 'snd_usb_add_audio_stream_v3' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
