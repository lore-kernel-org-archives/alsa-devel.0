From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Thu, 3 Jul 2008 10:28:09 -0600
Message-ID: <20080703162809.GH2284@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 5794B24945
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 18:28:44 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so243412yxh.2
	for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2008 09:28:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 02, 2008 at 09:51:59AM -0400, Jon Smirl wrote:
> DMA, needs to be split out. Efika is AC97 on the MPC5200 and needs to
> share DMA code. The new Phytec pcm030 baseboard is AC97 too.

I agree, but I'm not sure the best way to organize a split.  I'm not
doing anything with the Efika at the moment and I haven't dug into the
details of what needs to be done for AC97.

> What does the device tree look like?

Here is the relevant excerpt, but it is not documented yet.  I haven't
made any attempt encode the layout into the device tree (clocking, etc.)

	spi@f00 {
		#address-cells = <1>;
		#size-cells = <0>;
		compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
		reg = <0xf00 0x20>;
		num-slaves = <32>;
		interrupts = <2 13 0 2 14 0>;
		interrupt-parent = <&mpc5200_pic>;

		codec1: codec@2 {
			compatible = "ti,tlv320aic26";
			linux,modalias = "tlv320aic26";
			max-speed = <1000000>;
			reg = <2>;
		};

		codec2: codec@3 {
			compatible = "ti,tlv320aic26";
			linux,modalias = "tlv320aic26";
			max-speed = <1000000>;
			reg = <3>;
		};
	};

	i2s@2200 {		// PSC2
		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
		cell-index = <1>;
		reg = <0x2200 0x100>;
		interrupts = <2 2 0>;
		interrupt-parent = <&mpc5200_pic>;
		codec-handle = <&codec1>;
	};
	i2s@2400 {		// PSC3
		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
		cell-index = <2>;
		reg = <0x2400 0x100>;
		interrupts = <2 3 0>;
		interrupt-parent = <&mpc5200_pic>;
		codec-handle = <&codec2>;
	};
