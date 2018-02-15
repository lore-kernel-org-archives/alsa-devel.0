From: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Subject: Re: [asoc:topic/intel 4/4]
 sound/soc/codecs/hdac_hdmi.c:725:42: error: 'struct hdac_ext_device' has no
 member named 'hdac'; did you mean 'hdev'?
Date: Thu, 15 Feb 2018 22:19:55 +0530
Message-ID: <460034f7-dfbe-6df0-6eb5-ef7b1d707f31@intel.com>
References: <201802160039.DQJdakQc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 60116267C5D
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 17:49:58 +0100 (CET)
In-Reply-To: <201802160039.DQJdakQc%fengguang.wu@intel.com>
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
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org



On 2/15/2018 9:56 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   753597fbb7031ff147d4f2862426699e4ad8efca
> commit: 753597fbb7031ff147d4f2862426699e4ad8efca [4/4] ASoC: hdac_hdmi : Ensuring proper setting of output widget power state
> config: i386-randconfig-x075-201806 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          git checkout 753597fbb7031ff147d4f2862426699e4ad8efca
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>     sound/soc/codecs/hdac_hdmi.c: In function 'hdac_hdmi_set_power_state':
>>> sound/soc/codecs/hdac_hdmi.c:725:42: error: 'struct hdac_ext_device' has no member named 'hdac'; did you mean 'hdev'?

My bad i missed it. Shared v2 for this.

-Abhijeet
>        if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state)) {
>                                               ^~~~
>                                               hdev
>     sound/soc/codecs/hdac_hdmi.c:727:32: error: 'struct hdac_ext_device' has no member named 'hdac'; did you mean 'hdev'?
>          snd_hdac_codec_read(&edev->hdac, nid, 0,
>                                     ^~~~
>                                     hdev
>     sound/soc/codecs/hdac_hdmi.c:730:46: error: 'struct hdac_ext_device' has no member named 'hdac'; did you mean 'hdev'?
>          state = snd_hdac_sync_power_state(&edev->hdac,
>                                                   ^~~~
>                                                   hdev
>
> vim +725 sound/soc/codecs/hdac_hdmi.c
>
>     717	
>     718	static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
>     719				     hda_nid_t nid, unsigned int pwr_state)
>     720	{
>     721		int count;
>     722		unsigned int state;
>     723	
>     724		if (get_wcaps(&edev->hdev, nid) & AC_WCAP_POWER) {
>   > 725			if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state)) {
>     726				for (count = 0; count < 10; count++) {
>     727					snd_hdac_codec_read(&edev->hdac, nid, 0,
>     728							AC_VERB_SET_POWER_STATE,
>     729							pwr_state);
>     730					state = snd_hdac_sync_power_state(&edev->hdac,
>     731							nid, pwr_state);
>     732					if (!(state & AC_PWRST_ERROR))
>     733						break;
>     734				}
>     735			}
>     736	
>     737		}
>     738	}
>     739	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
