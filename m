From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 17/32] ASoC: rt5651: Allow specifying
 over-current thresholds through device-properties
Date: Fri, 2 Mar 2018 16:18:52 -0600
Message-ID: <20180302221852.p3m5u4xgbbdr4crg@rob-hp-laptop>
References: <20180225104713.4745-1-hdegoede@redhat.com>
 <20180225104713.4745-18-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 062252674DD
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 23:18:54 +0100 (CET)
Received: by mail-ot0-f193.google.com with SMTP id h8so10094696oti.6
 for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2018 14:18:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180225104713.4745-18-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 25, 2018 at 11:46:58AM +0100, Hans de Goede wrote:
> OVer-Current-Detection (OVCD) for the micbias current is used to detect if
> an inserted jack is a headset or headphones (mic shorted to ground).
> =

> Some boards may need different values for the OVCD threshold because of a
> resistor on the board in serial with or parallel to the jack mic contact.
> =

> This commit adds support for the sofar unset OVCD scale-factor register
> values and adds support for specifying non-default values for both the
> current threshold and the scale-factor through device-properties.
> =

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/sound/rt5651.txt | 11 ++++++

Please split to a separate patch.

>  include/sound/rt5651.h                             | 11 ++++++
>  sound/soc/codecs/rt5651.c                          | 42 ++++++++++++++++=
+++++-
>  sound/soc/codecs/rt5651.h                          | 10 ++++++
>  4 files changed, 73 insertions(+), 1 deletion(-)
> =

> diff --git a/Documentation/devicetree/bindings/sound/rt5651.txt b/Documen=
tation/devicetree/bindings/sound/rt5651.txt
> index 1632c0cf6123..8cb7ee8e79cf 100644
> --- a/Documentation/devicetree/bindings/sound/rt5651.txt
> +++ b/Documentation/devicetree/bindings/sound/rt5651.txt
> @@ -22,6 +22,17 @@ Optional properties:
>    2: Use JD1_2 pin for jack-dectect
>    3: Use JD2 pin for jack-dectect
>  =

> +- realtek,over-current-threshold
> +  u32, micbias over-current detection threshold in =B5A, valid values are
> +  600, 1500 and 2000=B5A.

Needs a unit suffix as defined in property-units.txt

> +
> +- realtek,over-current-scale-factor
> +  u32, micbias over-current detection scale-factor, valid values are:
> +  0: Scale current by 0.5
> +  1: Scale current by 0.75
> +  2: Scale current by 1.0
> +  3: Scale current by 1.5
> +
>  Pins on the device (for linking into audio routes) for RT5651:
>  =

>    * DMIC L1
