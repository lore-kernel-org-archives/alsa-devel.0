From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: adau1977: Add MICBIAS example in DT bindings
Date: Fri, 22 Feb 2019 08:31:12 -0600
Message-ID: <CAL_JsqL+iuEeXPewzYmHe43-57+Oskpk=ie0D5oYXoRAkW186Q@mail.gmail.com>
References: <20190219141139.24216-1-bogdan.togorean@gmail.com> <20190219141139.24216-2-bogdan.togorean@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219141139.24216-2-bogdan.togorean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan Togorean <bogdan.togorean@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 19, 2019 at 8:12 AM Bogdan Togorean
<bogdan.togorean@gmail.com> wrote:
>
> Add MICBIAS property to the optional devicetree bindings.
>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/adi,adau1977.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
> index e79aeef73f28..87c16e6f2e7c 100644
> --- a/Documentation/devicetree/bindings/sound/adi,adau1977.txt
> +++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
> @@ -23,6 +23,12 @@ Optional properties:
>   - DVDD-supply: supply voltage for the digital core, please consult
>                  Documentation/devicetree/bindings/regulator/regulator.txt
>
> +- adi,micbias: configures the voltage setting for the MICBIAS pin.
> +               Select 0/1/2/3/4/5/6/7/8 to specify MICBIAS voltage
> +               5V/5.5V/6V/6.5V/7V/7.5V/8V/8.5V/9V
> +               If not specified the default value will be "7" meaning 8.5 Volts.
> +               This property is only valid for the ADAU1977

There's no shortage of mic bias properties for codecs. We should
define a common property for this.

But looks like this is already applied, so what's one more...

Rob
