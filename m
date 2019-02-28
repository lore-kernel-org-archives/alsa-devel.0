From: Hynninen Jukka <jukka.hynninen@vaisala.com>
Subject: Re: WM8510 on i.MX6
Date: Thu, 28 Feb 2019 15:59:00 +0000
Message-ID: <AM5PR0602MB29009FDDAB4A7F207BADAA7A99750@AM5PR0602MB2900.eurprd06.prod.outlook.com>
References: <36af3e2d-fe67-0d34-6990-a0019f5b84d0@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F37C3F896C0
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 16:59:02 +0100 (CET)
In-Reply-To: <36af3e2d-fe67-0d34-6990-a0019f5b84d0@kontron.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Frieder,

Perhaps this is because simple-card does not have capability of configuring WM8510 codec PLL and clock divisors? See this thread I started few years back:
https://mailman.alsa-project.org/pipermail/alsa-devel/2017-September/125767.html

We ended up patching those three lines into WM8510 codec driver. We would still be interested to implement this missing link in a proper, generic manner, if we could just figure out what would be the correct place to do it.


-Jukka

-----Original Message-----
From: Alsa-devel <alsa-devel-bounces@alsa-project.org> On Behalf Of Schrempf Frieder
Sent: torstai 28. helmikuuta 2019 10.54
To: alsa-devel@alsa-project.org
Subject: [SUSPICIOUS MESSAGE] [alsa-devel] WM8510 on i.MX6

Hi,

I have a board with i.MX6 and a WM8510 codec and I can play audio using an old vendor kernel (3.14) and my own asoc machine driver [1].

Now I want to run this with something more recent (currently trying on
4.14) and upstream drivers like simple-card or fsl-asoc-card.

The problem is I'm only getting a little bit of noise from the speakers but nothing more.

I would really appreciate it if someone more knowledgeable could have a quick look and maybe come up with some ideas how I can proceed debugging.

Thanks,
Frieder

[1] https://secure-web.cisco.com/1cEfWyuVF6-7tLBWcKcbV4q0wrmACgHA_c9qGq80VjziKKNT0jnOKl9HA7OiERigQZfZD9ylmZbHLXBpqXY90df-3pn3jr9BZepFQr83kRgawT4YcvpK2Rmd6kYx4UWXf3hIVZL3e-02lOxOrdYVI7GImecIacQ_2Gx2kb2G5XGXn9Xi9GS6M2V65XAjXYVTKFXao-2ySBapmt-qp4gKhBcNU_ehcsvW2s-arYmJFcStxcYBhoZCOp1SRT5961IeekyuBbWMmPetZ-BEc0pPE8uCFBjba4fWe0qfsyNEebgIMprRM72T9rqDsDrYRunRf5oO1y21_SiuSkvvTo0sQQMlKDH00GI54BcXvqaLnSRXM2Zfwun-9A3ZmAKa00mxy/https%3A%2F%2Fpaste.ee%2Fp%2FVuZbg

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
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://secure-web.cisco.com/12rjkHN8w-zo4qdOKo1yt9xPPcmBaclCQR4WQF2k_Jj49zFHnCrViRkRAqrsmfCcWU39fS_DL_iZHc-IffMyz8RpVtMX0Vs0yiXUH0tWXkuHFgYtW7wXDRpBMdRYxoz3-p1lD5bujtMJ3yB7vcypNXtuKxDV22Hjku4wZ3gQ1K8jk9O0Guh8fRdtsYEuhLDg_luRoGMQ7RFaGd6OlP-yK60kgJN-KIN5g-Px7OF8RL_WEW5JG_5twI9C2fhE_a_ZlnV_k4eHPoN27A-vFf_l-kT_T5lzdFXL9HHb4qWXmK2h-euJq2BQmT-6uBcvaXLCX5NsRijFIkgrDb0HdoXGeF52UWGb5qjhQzwVbo3T0d6UtDfKHw2UBj0RRxXXaMLL63n3f5h9pP0O_gG6XYlHZ0w/https%3A%2F%2Fmailman.alsa-project.org%2Fmailman%2Flistinfo%2Falsa-devel
