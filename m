From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH V1 0/6] ASoC: tlv320aic26: Add device tree
 support and bug fixes
Date: Wed, 30 Sep 2015 13:43:13 +0300
Message-ID: <560BBCC1.4010806@ti.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
 <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 09E1C265B51
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 12:43:19 +0200 (CEST)
In-Reply-To: <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Cormier, Jonathan" <jcormier@criticallink.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Bob Duke <bduke@criticallink.com>, Mark Brown <broonie@linaro.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/25/2015 09:30 PM, Cormier, Jonathan wrote:
> Hi,
> =

> The following patches were created to get the tlv320aic26 working on our =
AM335x
> SoM.
> =

> This patch series relies on commit 93d0ad8f374c
> "ASoC: tlv320aic26: Convert to params_width()" for proper operation.
> =

> Changes since RFC:
> - Removed the unecessary "#if defined(CONFIG_OF)"
> - Dropped the DSP_B patch

All:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>


> Thanks
> -Jonathan
> =

> Cormier, Jonathan (6):
>   ASoC: tlv320aic26: Add device tree binding
>   ASoC: tlv320aic26: Fix module autoload
>   ASoC: tlv320aic26: Make SND_SOC_TLV320AIC26 user-visible
>   ASoC: tlv320aic26: Fix regmap by setting reg_defaults and reg_stride
>   ASoC: tlv320aic26: hw_params was unintentionally clearing AIC26 master
>     mode
>   ASoC: tlv320aic26: Change Capture Mute to Capture Switch to match alsa
>     documentation.
> =

>  .../devicetree/bindings/sound/tlv320aic26.txt      | 65 ++++++++++++++++=
++++++
>  sound/soc/codecs/Kconfig                           |  2 +-
>  sound/soc/codecs/tlv320aic26.c                     | 55 ++++++++++++++++=
--
>  3 files changed, 115 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic26.t=
xt
> =



-- =

P=E9ter
