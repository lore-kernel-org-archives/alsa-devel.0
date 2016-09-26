From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [asoc:topic/intel 53/55]
 sound/soc/codecs/hdac_hdmi.c:1028:5: warning: passing argument 4 of
 'snd_hdac_acomp_get_eld' from incompatible pointer type
Date: Mon, 26 Sep 2016 14:09:51 +0530
Message-ID: <20160926083843.GA21213@kpjeeja-desk>
References: <201609251657.PliXFIzK%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 40ED52665B0
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 10:31:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201609251657.PliXFIzK%fengguang.wu@intel.com>
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
Cc: Sandeep Tayal <sandeepx.tayal@intel.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 25, 2016 at 04:13:04PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   2d995e5dc283adbfbf9c1eb81bf35ca7af2d22a6
> commit: fe27f4e0545d3fc1b0518fafb4fe0460d757651d [53/55] ASoC: hdac_hdmi: use audio component framework to read ELD
> config: x86_64-randconfig-n0-09251512 (attached as .config)
> compiler: gcc-4.8 (Debian 4.8.4-1) 4.8.4
> reproduce:
>         git checkout fe27f4e0545d3fc1b0518fafb4fe0460d757651d
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
Hi Mark,

This patch has dependency [1] with the i915 API changes for MST. This is
not merged yet
 
Can this patch be reverted or staged until the i915 API changes are
merged?

Sorry I should have explicitly mention this in cover letter

[1]: https://patchwork.freedesktop.org/series/10571/.

-- 
Jeeja

> All warnings (new ones prefixed by >>):
> 
>    sound/soc/codecs/hdac_hdmi.c: In function 'hdac_hdmi_present_sense':
>    sound/soc/codecs/hdac_hdmi.c:1028:5: warning: passing argument 3 of 'snd_hdac_acomp_get_eld' makes pointer from integer without a cast [enabled by default]
>         ELD_MAX_SIZE);
>         ^
>    In file included from sound/soc/codecs/hdac_hdmi.c:30:0:
>    include/sound/hda_i915.h:14:5: note: expected 'bool *' but argument is of type 'int'
>     int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid,
>         ^
> >> sound/soc/codecs/hdac_hdmi.c:1028:5: warning: passing argument 4 of 'snd_hdac_acomp_get_eld' from incompatible pointer type [enabled by default]
>         ELD_MAX_SIZE);
>         ^
>    In file included from sound/soc/codecs/hdac_hdmi.c:30:0:
>    include/sound/hda_i915.h:14:5: note: expected 'char *' but argument is of type 'bool *'
>     int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid,
>         ^
>    sound/soc/codecs/hdac_hdmi.c:1028:5: warning: passing argument 5 of 'snd_hdac_acomp_get_eld' makes integer from pointer without a cast [enabled by default]
>         ELD_MAX_SIZE);
>         ^
>    In file included from sound/soc/codecs/hdac_hdmi.c:30:0:
>    include/sound/hda_i915.h:14:5: note: expected 'int' but argument is of type 'char *'
>     int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid,
>         ^
>    sound/soc/codecs/hdac_hdmi.c:1028:5: error: too many arguments to function 'snd_hdac_acomp_get_eld'
>         ELD_MAX_SIZE);
>         ^
>    In file included from sound/soc/codecs/hdac_hdmi.c:30:0:
>    include/sound/hda_i915.h:14:5: note: declared here
>     int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid,
>         ^
> 
> vim +/snd_hdac_acomp_get_eld +1028 sound/soc/codecs/hdac_hdmi.c
> 
>   1012	
>   1013		return 0;
>   1014	}
>   1015	
>   1016	static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin)
>   1017	{
>   1018		struct hdac_ext_device *edev = pin->edev;
>   1019		struct hdac_hdmi_priv *hdmi = edev->private_data;
>   1020		struct hdac_hdmi_pcm *pcm;
>   1021		int size;
>   1022	
>   1023		mutex_lock(&hdmi->pin_mutex);
>   1024		pin->eld.monitor_present = false;
>   1025	
>   1026		size = snd_hdac_acomp_get_eld(&edev->hdac, pin->nid, -1,
>   1027					&pin->eld.monitor_present, pin->eld.eld_buffer,
> > 1028					ELD_MAX_SIZE);
>   1029	
>   1030		if (size > 0) {
>   1031			size = min(size, ELD_MAX_SIZE);
>   1032			if (hdac_hdmi_parse_eld(edev, pin) < 0)
>   1033				size = -EINVAL;
>   1034		}
>   1035	
>   1036		if (size > 0) {
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
