From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Add support for multi register mux
Date: Mon, 07 Apr 2014 14:54:11 +0200
Message-ID: <53429FF3.9060106@metafoo.de>
References: <1396656730-30145-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396656730-30145-1-git-send-email-aruns@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, swarren@wwwdotorg.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Songhee Baek <sbaek@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 04/05/2014 02:12 AM, Arun Shamanna Lakshmi wrote:
> 1. Modify soc_enum struct to handle pointers for reg and mask
> 2. Add dapm get and put APIs for multi register one hot encoded mux
> 3. Update snd_soc_dapm_update struct to support multiple reg update
>
> Signed-off-by: Arun S L <aruns@nvidia.com>
> Signed-off-by: Songhee Baek <sbaek@nvidia.com>

Looks good to me, so:

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>


As Takashi said it is not that nice that there is a bit of code churn by 
having to update all the existing users of e->reg and e->mask. But 
implementing this properly seems to cause even more code churn. And I think 
it will be done best in an effort to consolidate the kcontrol helpers and 
the DAPM kcontrol helpers by adding an additional layer of abstraction 
between the kcontrols and the hardware access that translates between the 
logical value and the physical value(s).

E.g. something like

struct kcontrol_ops {
	int (*read)(...);
	int (*write)(...);
};

And then have one kind of ops for each kind of control type and at the high 
level only have put and get handlers for enums and for switches/volumes.

- Lars
