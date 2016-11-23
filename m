From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ALSA SoC MAX98927 driver - Initial release
Date: Thu, 24 Nov 2016 02:13:44 +0800
Message-ID: <201611240218.Lg3buQ9j%fengguang.wu@intel.com>
References: <1479877026-5172-1-git-send-email-RyanS.Lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479877026-5172-1-git-send-email-RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, yesanishhere-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org, Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, nh6z-fFIq/eER6g8@public.gmane.org, ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Ryan,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.9-rc6 next-20161123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ryan-Lee/ALSA-SoC-MAX98927-driver-Initial-release/20161124-004840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/max98927.c:941:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
