From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH] drm: msm: Add ASoC generic hdmi audio codec support.
Date: Mon, 6 Jun 2016 13:39:44 +0100
Message-ID: <57556F10.9020608@linaro.org>
References: <1464962161-17337-1-git-send-email-srinivas.kandagatla@linaro.org>
 <57556B2C.8000403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57556B2C.8000403@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 06/06/16 13:23, Jyri Sarha wrote:
> On 06/03/16 16:56, Srinivas Kandagatla wrote:
>> >This patch adds support to generic audio codec via
>> >ASoC hdmi-codec infrastucture which is merged recently.
>> >
> I know nothing about msm HW, but from the hdmi-codec point of view this
> looks like a correct usage. However, the hdmi-codec could probably do
> more to connect the hdmi audio infoframe's channel allocation field and
> ALSA's channel mapping API together.

Yes, that would be nice to get the channel allocation into hdmi-codec.

>
> There looks to be a bug in selecting 44100 sample rate bellow.
>

Thanks for spotting this, yes this looks like a typo, I will fix this in v2.

Thanks,
srini

> BR,
> Jyri
>
>> >Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> >---
>> >  drivers/gpu/drm/msm/Kconfig     |   1 +
>> >  drivers/gpu/drm/msm/hdmi/hdmi.c | 120 +++++++++++++++++++++++++++++++++++++++-
>> >  drivers/gpu/drm/msm/hdmi/hdmi.h |  14 +++++
>> >  3 files changed, 134 insertions(+), 1 deletion(-)
>>
>> >diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
>> >index 51b9ea5..3281496 100644
>> >--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
>> >+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
>> >@@ -19,6 +19,7 @@
>> >  #include <linux/of_irq.h>
>> >  #include <linux/of_gpio.h>
>> >
>> >+#include <sound/hdmi-codec.h>
>> >  #include "hdmi.h"
>> >
>> >  void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on)
>> >@@ -434,6 +435,114 @@ static int msm_hdmi_get_gpio(struct device_node *of_node, const char *name)
>> >  	return gpio;
...
>> >+	case 32000:
>> >+		rate = HDMI_SAMPLE_RATE_32KHZ;
>> >+		break;
>> >+	case 44100:
>> >+		rate = HDMI_SAMPLE_RATE_48KHZ;
>> >+		break;
> This looks like a bug...
>
