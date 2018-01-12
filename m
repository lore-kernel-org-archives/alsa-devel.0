From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: hdac_hdmi: Ensuring proper setting of output
 widget power state
Date: Fri, 12 Jan 2018 11:16:38 +0530
Message-ID: <20180112054638.GL18649@localhost>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: abhijeet.kumar@intel.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 11, 2018 at 05:04:27PM +0530, abhijeet.kumar@intel.com wrote:
> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
> 
> When we change the resolution of DP pannel or hot plug-unplug it while
> playing an audio clip,sometimes we observe a silent playback(no audio).

can you rephrase this please

> During no audio condition, we have noticed that the power state of the
> pin or the connector is D3. Optimzing the way we set the power could
> mitigate the issue.With this changes the verb is sent to set the power

space after .

> state and response is received. Thus ensuring power state is set.

am not sure I fully understood the problem here

> 
> Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
> ---
>  sound/soc/codecs/hdac_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index f3b4f4dfae6a..e24caecf0a4f 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -718,7 +718,7 @@ static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
>  {
>  	if (get_wcaps(&edev->hdac, nid) & AC_WCAP_POWER) {
>  		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state))
> -			snd_hdac_codec_write(&edev->hdac, nid, 0,
> +			snd_hdac_codec_read(&edev->hdac, nid, 0,

how does read help instead of write?

-- 
~Vinod
