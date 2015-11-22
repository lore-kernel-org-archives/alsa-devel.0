From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [asoc:topic/intel 49/50] hdac_hdmi.c:undefined
 reference to `hdmi_audio_infoframe_init'
Date: Sun, 22 Nov 2015 16:09:05 +0530
Message-ID: <20151122103905.GN25173@localhost>
References: <201511221311.BiQFW3nK%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F1942605F0
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 11:35:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201511221311.BiQFW3nK%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 22, 2015 at 01:54:13PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   07f083aba92ffdd97df41516de6f80ef27a4a21b
> commit: a657f1d05fd3eadb61f771e659f5d42940003d93 [49/50] ASoC: hdac_hdmi: Setup and start infoframe
> config: x86_64-randconfig-v0-11221310 (attached as .config)
> reproduce:
>         git checkout a657f1d05fd3eadb61f771e659f5d42940003d93
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    sound/built-in.o: In function `hdac_hdmi_playback_prepare':
> >> hdac_hdmi.c:(.text+0x55d6d): undefined reference to `hdmi_audio_infoframe_init'
> >> hdac_hdmi.c:(.text+0x55d9c): undefined reference to `hdmi_audio_infoframe_pack'

Yes we are missing HDMI core sysmbol in this rand-config. I will send fix
for this alse

-- 
~Vinod
