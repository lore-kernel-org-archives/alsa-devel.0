From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [asoc:for-4.20 399/404]
 sound/soc/soc-dapm.c:3768:9: warning: 'ret' may be used uninitialized in
 this function
Date: Thu, 6 Sep 2018 16:10:32 +0100
Message-ID: <20180906151032.GE1653@imbe.wolfsonmicro.main>
References: <201809061931.yYLg0BtW%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 544672673F4
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 17:10:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201809061931.yYLg0BtW%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 06, 2018 at 07:46:38PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-4.20
> head:   9ab708aef61f5620113269a9d1bdb1543d1207d0
> commit: 4a75aae17b2a802a7267206414050408392c374c [399/404] ASoC: dapm: Add support for multi-CODEC CODEC to CODEC links
> config: x86_64-randconfig-x006-201835 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 4a75aae17b2a802a7267206414050408392c374c
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
>    sound/soc/soc-dapm.c: In function 'snd_soc_dai_link_event':
> >> sound/soc/soc-dapm.c:3768:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      return ret;
>             ^~~

Odd didn't show up on my system, guess I need to update my GCC.
Apologies will get a fixup patch out shortly.

Thanks,
Charles
