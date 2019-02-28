From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: WM8510 on i.MX6
Date: Thu, 28 Feb 2019 08:54:22 +0000
Message-ID: <36af3e2d-fe67-0d34-6990-a0019f5b84d0@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skedge03.snt-world.com (skedge03.snt-world.com [91.208.41.68])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64EA5F806F6
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 09:54:28 +0100 (CET)
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge03.snt-world.com (Postfix) with ESMTPS id 091816533AC
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 09:54:23 +0100 (CET)
Content-Language: en-US
Content-ID: <2B8BEF5BE0FF77459E0A6A7939508457@snt-world.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a board with i.MX6 and a WM8510 codec and I can play audio using 
an old vendor kernel (3.14) and my own asoc machine driver [1].

Now I want to run this with something more recent (currently trying on 
4.14) and upstream drivers like simple-card or fsl-asoc-card.

The problem is I'm only getting a little bit of noise from the speakers 
but nothing more.

I would really appreciate it if someone more knowledgeable could have a 
quick look and maybe come up with some ideas how I can proceed debugging.

Thanks,
Frieder

[1] https://paste.ee/p/VuZbg

My devicetree setup for the simple-card approach looks like this:

sound {
	compatible = "simple-audio-card";
	simple-audio-card,name = "wm8510-audio";
	simple-audio-card,format = "i2s";
	simple-audio-card,bitclock-master = <&sound_codec>;
	simple-audio-card,frame-master = <&sound_codec>;
	simple-audio-card,widgets =
		"Speaker", "Ext Spk";
	simple-audio-card,routing =
		"Ext Spk", "SPKOUTP",
		"Ext Spk", "SPKOUTN";

	assigned-clocks = <&clks IMX6QDL_CLK_CKO2_SEL>,
			  <&clks IMX6QDL_CLK_CKO2>;
	assigned-clock-parents = <&clks IMX6QDL_CLK_OSC>,
				 <&clks IMX6QDL_CLK_CKO2_PODF>;
	assigned-clock-rates = <0 24000000>;

	sound_master: simple-audio-card,cpu {
		sound-dai = <&ssi2>;
	};

	sound_codec: simple-audio-card,codec {
		sound-dai = <&codec>;
		clocks = <&clks IMX6QDL_CLK_CKO2>;
	};
};

&audmux {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_audmux>;
	status = "okay";

	ssi2 {
		fsl,audmux-port = <1>;
		fsl,port-config = <
			(IMX_AUDMUX_V2_PTCR_SYN |
			 IMX_AUDMUX_V2_PTCR_TFSEL(4) |
			 IMX_AUDMUX_V2_PTCR_TCSEL(4) |
			 IMX_AUDMUX_V2_PTCR_TFSDIR |
			 IMX_AUDMUX_V2_PTCR_TCLKDIR)
			IMX_AUDMUX_V2_PDCR_RXDSEL(4)
		>;
	};

	aud5 {
		fsl,audmux-port = <4>;
		fsl,port-config = <
			IMX_AUDMUX_V2_PTCR_SYN
			IMX_AUDMUX_V2_PDCR_RXDSEL(1)
		>;
	};
};

&ssi2 {
	status = "okay";
};

&i2c2 {
	status = "okay";
	clock-frequency = <100000>;
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_i2c2>;

	codec: wm8510@1a {
		#sound-dai-cells = <0>;
		compatible = "wlf,wm8510";
		reg = <0x1a>;
	};
};

&iomuxc {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_sound_mclk>;

	pinctrl_sound_mclk: sound {
		/* WM8510 MCLK */
		fsl,pins = <
			MX6QDL_PAD_NANDF_CS2__CCM_CLKO2	0x130b0
		>;
	};

	pinctrl_audmux: audmux {
		fsl,pins = <
			MX6QDL_PAD_KEY_COL0__AUD5_TXC	0x130b0
			MX6QDL_PAD_KEY_COL1__AUD5_TXFS	0x130b0
			MX6QDL_PAD_KEY_ROW1__AUD5_RXD	0x130b0
			MX6QDL_PAD_KEY_ROW0__AUD5_TXD	0x130b0
		>;
	};
};
