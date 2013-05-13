From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH 2/2] sgtl5000.txt: Explain the required and
	optional power supplies
Date: Mon, 13 May 2013 11:07:19 -0500
Message-ID: <CAKGA1bmku3o1dJXTMVMwU3NJmEZ2tRD-SQ8JD+5hDLc2GRcXUg@mail.gmail.com>
References: <1368459567-26780-1-git-send-email-fabio.estevam@freescale.com>
 <1368459567-26780-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D88CD26163E
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 18:07:40 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id lf11so745777vcb.26
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 09:07:40 -0700 (PDT)
In-Reply-To: <1368459567-26780-2-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Eric Nelson <eric.nelson@boundarydevices.com>, "troy.kisky" <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

I would say;

"VDDD is an optional supply and could be unconnected on designs. In
this case an internal regulator is used."

The original sentence has 'and' twice, which looks a little weird in
English. I will also advocate "could" instead of "can," since it's the
past tense (i.e. the board is already designed and we are merely
describing a board in the binding, not dictating design methodology in
the binding). That said,

Signed-off-by: Matt Sealey <matt@genesi-usa.com>

I have a question that is slightly related.

It is possible to direct the SGTL5000 VDDD charge pump source to VDDA
or VDDIO via CHIP_LINREG_CTRL. It is automatically set to the highest
voltage of VDDA/VDDIO (differing voltages) or VDDA (both the same and
higher than 3.1V) at "start."

It may be prudent for some boards that supply >3.1V to dictate
switching to VDDIO as the charge pump supply, and I wonder how we'd
actually define that. Supplying a regulator for VDDD and matching it
would not suit the case where a single 3.3V supply went to all
supplies (VDDD, VDDA, VDDIO) which I have seen. It would need a
property.. VDDD-source maybe?

If you were going for a low-noise design without a dedicated VDDD, I
would think you'd want to keep VDDA decoupled from the digital logic
and that isn't the default..

On Mon, May 13, 2013 at 10:39 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> sgtl5000 has two power supplies that are mandatory: VDDA and VDDIO.
>
> VDDD is an optional supply and can be left unconnected and in this case an
> internal regulator is used.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  .../devicetree/bindings/sound/sgtl5000.txt         |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
> index 9cc4444..3537a7d 100644
> --- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
> +++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
> @@ -5,9 +5,19 @@ Required properties:
>
>  - reg : the I2C address of the device
>
> +- VDDA-supply: the regulator for VDDA supply
> +
> +- VDDIO-supply: the regulator for VDDIO supply
> +
> +Optional properties:
> +
> +- VDDD-supply: the regulator for VDDD supply
> +
>  Example:
>
>  codec: sgtl5000@0a {
>         compatible = "fsl,sgtl5000";
>         reg = <0x0a>;
> +       VDDA-supply = <&vdda_reg>;
> +       VDDIO-supply = <&vddio_reg>;
>  };
> --
> 1.7.9.5
>
>



-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
