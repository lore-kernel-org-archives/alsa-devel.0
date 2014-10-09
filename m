From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re:
	=?utf-8?q?No_sound_captured_with_SGTL5000_on_i=2EMX6?=
	=?utf-8?q?_in_I=C2=B2S_master_mode?=
Date: Thu, 9 Oct 2014 16:02:07 +0200
Message-ID: <CAL8zT=gEMwbJq=3Tf6FAg2_fyAK4Q07-hVn5eYZKFSBfC-8iBQ@mail.gmail.com>
References: <20140918170524.GA6080@Asurada>
 <CAOMZO5AqtNm3kwndUYszAuMfJ4CMOz4pwZRmE+04cEDtz98agg@mail.gmail.com>
 <20140918174935.GB6432@Asurada>
 <CAOMZO5AXN4p01=oGCydHUm6sPdt5NRNXO+4EOKQ1T7ZKUwVfMw@mail.gmail.com>
 <20140918180742.GC6432@Asurada>
 <CAOMZO5AvWecqimJkZcwysvsmPiq8Fa2Hm_XppCH3E1+vyjVzFQ@mail.gmail.com>
 <20140918183910.GF6432@Asurada>
 <CAOMZO5BJbzizB4r8vvtJEBzv+DhsyRmYMUoQL2D-dQhBorGkzA@mail.gmail.com>
 <20140918235045.GA4148@Asurada>
 <CAL8zT=hdT0otjqkQeBmfQgNsfdoapCv3NnHMwNxfxydu1+44Ww@mail.gmail.com>
 <20140919075228.GA4376@Asurada>
 <CAL8zT=jWQ4ZTGpohWHGTfbxgj547ukcZEUg7XdQsWzwq1=JiVA@mail.gmail.com>
 <CAL8zT=gELK8+LOgVn6qXnaTm=Vcx=zn8OxfQBh_9m28NQtR2pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 29CBD264F35
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 16:02:24 +0200 (CEST)
Received: by mail-oi0-f41.google.com with SMTP id u20so2765010oif.14
 for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2014 07:02:22 -0700 (PDT)
In-Reply-To: <CAL8zT=gELK8+LOgVn6qXnaTm=Vcx=zn8OxfQBh_9m28NQtR2pA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, Michael Trimarchi <michael@amarulasolutions.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi

I use fsl-asoc-card now.

This is working when compiling as a module, and when doing a modprobe
manually, but when I compile it as built-in, with these :
CONFIG_SND_SOC_IMX_SGTL5000 is not set
CONFIG_SND_SOC_FSL_ASOC_CARD=y
CONFIG_SND_SOC_SGTL5000=y

I get the following error :
[   13.561618] fsl-asoc-card sound: ASoC: CODEC DAI sgtl5000 not registered
[   13.568503] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[   13.574992] platform sound: Driver fsl-asoc-card requests probe deferral

It loops on it during boot, and never registers...

If I have :
CONFIG_SND_SOC_IMX_SGTL5000 is not set
CONFIG_SND_SOC_FSL_ASOC_CARD=m
CONFIG_SND_SOC_SGTL5000=m

And after login :
$> lsmod
Module                  Size  Used by
snd_soc_sgtl5000       14074  0
$> modprobe snd-soc-fsl-asoc-card
[   65.300995] fsl-asoc-card sound: ASoC: CODEC DAI sgtl5000 not registered
[   65.307963] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[   65.314423] platform sound: Driver fsl-asoc-card requests probe deferral
$> rmmod snd-soc-sgtl5000
$> modprobe snd-soc-sgtl5000
[  138.936753] sgtl5000 1-000a: sgtl5000 revision 0x11
[  138.987974] 1-000a: 1200 mV normal
[  139.000923] sgtl5000 1-000a: Using internal LDO instead of VDDD
[  139.032169] fsl-asoc-card sound: sgtl5000 <-> 2028000.ssi mapping ok
[  139.038624] fsl-asoc-card sound: ASoC: no source widget found for
ASRC-Playback
[  139.045984] fsl-asoc-card sound: ASoC: Failed to add route
ASRC-Playback -> direct -> CPU-Playback
[  139.055187] fsl-asoc-card sound: ASoC: no sink widget found for ASRC-Capture
[  139.062253] fsl-asoc-card sound: ASoC: Failed to add route
CPU-Capture -> direct -> ASRC-Capture

The routes are not ok, but I think I read something about it another
thread, but it works.
It seems that if snd-soc-sgtl5000 is already registered then it does
not work. It is probably due to my DT ?

Here is an extract of the DT :
/ {
    sound {
        compatible = "fsl,imx6q-vbx3-sgtl5000",
                 "fsl,imx-audio-sgtl5000";
        model = "imx6q-vbx3-sgtl5000";
        ssi-controller = <&ssi1>;
        audio-codec = <&codec>;
        audio-routing =
            "MIC_IN", "Mic Jack",
            "Mic Jack", "Mic Bias",
            "A1N1L", "Line In Jack",
            "A1N1R", "Line In Jack";
        mux-int-port = <1>;
        mux-ext-port = <5>;
    };
};

&i2c2 {
    clock-frequency = <100000>;
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_i2c2>;
    status = "okay";

    codec: sgtl5000@0a {
        compatible = "fsl,sgtl5000";
        reg = <0x0a>;
        clocks = <&clks 201>;
        VDDA-supply = <&vgen6_reg>;
        VDDIO-supply = <&vgen6_reg>;
        sysclk = <24000000>;
    };
};

Thanks,
JM
