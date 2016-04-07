From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/6] ASoC: davinci-mcbsp: add binding for
 McBSP
Date: Thu, 7 Apr 2016 16:33:26 +0300
Message-ID: <570661A6.6020804@ti.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F60261ADC
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 15:33:32 +0200 (CEST)
In-Reply-To: <1459948893-4206-2-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 04/06/16 16:21, Petr Kulhavy wrote:
> Add devicetree binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx
> MultiChannel Buffered Serial Port (McBSP)
> =

> The optional register range "dat" is not implemented at the moment.
> The current driver supports only DMA into RX/TX registers but no FIFO.
> Once the FIFO is implemented in the driver the "dat" range will be used.
> =

> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
>  .../bindings/sound/davinci-mcbsp-audio.txt         | 57 ++++++++++++++++=
++++++

I would drop the -audio postfix.
I know the McASP introduced this and it is annoying. Let's not repeat it ag=
ain...

>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp=
-audio.txt
> =

> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp-audio.=
txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp-audio.txt
> new file mode 100644
> index 000000000000..f60fceb927dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp-audio.txt
> @@ -0,0 +1,57 @@
> +Texas Instruments DaVinci McBSP module
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
> +audio interface found in some TI DaVinci processors like e.g. the DA850,
> +DM6446, DA355.

Given that the driver is actually a driver for daVinci ASP and it completely
ignores registers introduced when the IP is renamed from ASP to McBSP, shou=
ld
we say something about this? That the ASP is compatible or subset of McBSP
(w/o the multichannel support) and these bindings could be used for ASP, wi=
th
adding new compatible?
Or just leave that out and bother with it when we have such a device booting
with DT?

> +
> +
> +Required properties:
> +~~~~~~~~~~~~~~~~~~~~
> +- compatible : "ti,da850-mcbsp-audio"
> +
> +- reg : physical base address and length of the controller memory mapped
> +        region(s).
> +- reg-names : Should contain:
> +         * "mpu" for the main registers (required). For compatibility wi=
th
> +           existing software, it is recommended this is the first entry.
> +         * "dat" for the data FIFO (optional).
> +
> +- dmas: two element list of DMA controller phandles and DMA request line
> +        ordered pairs.
> +- dma-names: identifier string for each DMA request line in the dmas pro=
perty.
> +	     These strings correspond 1:1 with the ordered pairs in dmas. The d=
ma
> +	     identifiers must be "rx" and "tx".
> +
> +Optional properties:
> +~~~~~~~~~~~~~~~~~~~~
> +- interrupts : Interrupt numbers for McBSP
> +- interrupt-names : Known interrupt names are "rx" and "tx"
> +
> +- pinctrl-0: Should specify pin control group used for this controller.
> +- pinctrl-names: Should contain only one value - "default", for more det=
ails
> +  		 please refer to pinctrl-bindings.txt
> +
> +- channel-combine : boolean. If present L and R channels are combined in=
to one
> +		DMA transfer, however the labelling of the channels is swapped.
> +		Therefore this option should be used only if the channels can
> +		be swapped back at the codec side again.
> +
> +Example (AM1808):
> +~~~~~~~~~~~~~~~~~
> +
> +mcbsp0: mcbsp@1d10000 {
> +	compatible =3D "ti,davinci-mcbsp-audio";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mcbsp0_pins>;
> +
> +	reg =3D 	<0x00110000 0x1000>,
> +		<0x00310000 0x1000>;
> +	reg-names =3D "mpu", "dat";
> +	interrupts =3D <97 98>;
> +	interrupts-names =3D "rx", "tx";
> +	dmas =3D <&edma0 3
> +		&edma0 2>;
> +	dma-names =3D "tx", "rx";
> +	status =3D "okay";
> +};
> =



-- =

P=E9ter
