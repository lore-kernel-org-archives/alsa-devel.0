From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Thu, 10 May 2012 15:55:53 +0300
Message-ID: <4FABBAD9.8080008@ti.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73]) by alsa0.perex.cz (Postfix) with ESMTP id 532C824466
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 14:56:00 +0200 (CEST)
Received: by lbom4 with SMTP id m4so1238654lbo.2
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 05:55:57 -0700 (PDT)
In-Reply-To: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, "Cousson,
	Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 05/09/2012 04:35 PM, Mark Brown wrote:
>> That's true but what can I do with that in the ASoC machine driver?
>> The chip driver is _not_ the codec driver.
> =

> This really doesn't seem like it should be at all hard to resolve...

By not using any phandle for the codec in the dts file.
The phandle for the chip (MFD driver) is as useful as any other phandle
for me to parse things in the ASoC machine driver.

>> I can craft the pdata for the MFD child devices out from the DT
>> information but then the child devices will have no dev.of_node since
>> they were not probed via OF.  So I would have not phandle for the
>> codec to be used to define the dai-link connection within the sound
>> dts section.
> =

>> Am I missing something here?
> =

> Clearly.  This is all very circular.  Obviously if you're intent on
> using a phandle specific to the MFD child then you need to have that in
> the device tree but this is because you're making the child devices
> externally visible...  Clearly if we're not going to use the MFD
> subdevices in the DT then the links ought to reference the chip.

This boils down to this after all: how to handle an MFD device in DT?
Clearly this is not really defined.

I suppose I can go with something like this in the dts for twl6040:

twl6040: twl6040@4b {
	compatible =3D "ti,twl6040";
	reg =3D <0x4b>;
	interrupts =3D <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
	interrupt-parent =3D <&gic>;
	twl6040,audpwron_gpio =3D <&gpio4 31 0>;  /* gpio 127 */
	enable-active-high;

	interrupt-controller;
	#interrupt-cells =3D <1>;

	vio-supply =3D <&v1v8>;
	v2v1-supply =3D <&v2v1>;

	vibra {
		vddvibl-supply =3D <&vbat>;
		vddvibr-supply =3D <&vbat>;
		vibldrv_res =3D <8>;
		vibrdrv_res =3D <3>;
		viblmotor_res =3D <10>;
		vibrmotor_res =3D <10>;
	};
};

So we probe the MFD driver via DT.
We construct the mfd children struct for ASoC codec (always, since the
main function of twl6040 is to provide audio), or I can have a property
like twl6040,audio_enabled to explicitly enable the audio functionality.
We created the vibra device only if the vibra section exist.
We register use mfd_add_devices() in DT probed mode as well.

The vibra driver can get it's configuration via
pdev->dev.parent->of_node (from the MFD OF node).

As for the machine driver:

sound {
	compatible =3D "ti,abe-twl6040";
	abe-twl6040,model =3D "SDP4430";

	abe-twl6040,jack_detection =3D <1>;
	abe-twl6040,mclk_freq =3D <38400000>;

	codec,dmic =3D <&dmic_codec>;

	dai,mcpdm =3D <&mcpdm>;
	dai,dmic =3D <&dmic>;

	/* Audio routing */
	abe-twl6040,audio-routing =3D
		"Headset Stereophone", "HSOL",
		"Headset Stereophone", "HSOR",
		"Earphone Spk", "EP",
		"Ext Spk", "HFL",
		"Ext Spk", "HFR",
		"Line Out", "AUXL",
		"Line Out", "AUXR",
		"Vibrator", "VIBRAL",
		"Vibrator", "VIBRAR",
		"HSMIC", "Headset Mic",
		"Headset Mic", "Headset Mic Bias",
		"MAINMIC", "Main Handset Mic",
		"Main Handset Mic", "Main Mic Bias",
		"SUBMIC", "Sub Handset Mic",
		"Sub Handset Mic", "Main Mic Bias",
		"AFML", "Line In",
		"AFMR", "Line In",
		"DMic", "Digital Mic",
		"Digital Mic", "Digital Mic1 Bias";
};

In the driver I remove the mcpdm dai names and and the phandle for it
instead. Same for the dmic dai and for the dmic codec.
Since the twl6040 ASoC codec does not have phandle (not loaded via DT) I
do not need to touch it, I can leave the codec_name as it was.
The number of DAI links can be checked if we have for example the
codec,dmic property set. If it is set we have 2 links, if it is not set
we have one (twl6040 <-> mcpdm).

Mark: is this what you were suggesting?

-- =

P=E9ter
