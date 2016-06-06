From: Catalin Crenguta <catalin.crenguta@gmail.com>
Subject: sgtl5000: probe failed with error -5
Date: Mon, 6 Jun 2016 15:51:54 +0300
Message-ID: <CABH3fy_NLJD8yrxuyTfcbSzYgK2D=9Hz-awBY=vy-=qZm-AAGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 963CB265713
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 14:51:55 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id c74so44621100wme.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2016 05:51:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: grant.likely@linaro.org, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm working with a phycore vybrid SoM and I'm having some troubles binding
the sgtl5000 audio codec using devicetree.
As you can see, the codec driver could not be probed due to error -5.

The dts looks like this:

sound {
compatible = "fsl,imx-audio-sgtl5000";
model = "phycore-vybrid-sgtl5000";
audio-cpu = <&sai2>;
audio-codec = <&codec>;
audio-routing =
"MIC_IN", "Mic Jack",
"Mic Jack", "Mic Bias",
"Headphone Jack", "HP_OUT";
mux-int-port = <1>;
mux-ext-port = <3>;
};

/* .... */
&i2c2 {
clock-frequency = <400000>;
pinctrl-names = "default";
pinctrl-0 = <&pinctrl_i2c2>;
status = "okay";

/* ... */

codec: sgtl5000@0a {
compatible = "fsl,sgtl5000";
reg = <0x0a>;
pinctrl-names = "default";
clocks = <&clks 150>;
micbias-resistor-k-ohms = <2>;
micbias-voltage-m-volts = <2250>;
VDDA-supply = <&reg_3p3v>;
VDDIO-supply = <&reg_3p3v>;
};
};

/* ... */
&iomuxc {
vf610-phycore {
pinctrl_i2c2: i2c2grp {
fsl,pins = <
VF610_PAD_PTA22__I2C2_SCL 0x34d3
VF610_PAD_PTA23__I2C2_SDA 0x34d3
>;
};
};
};

After the system boot, the output of dmesg looks like this:
dmesg | grep sgtl5000
[    1.856390] bus: 'i2c': add driver sgtl5000
[    1.856441] bus: 'i2c': driver_probe_device: matched device 0-000a with
driver sgtl5000
[    1.856462] bus: 'i2c': really_probe: probing driver sgtl5000 with
device 0-000a
[    1.856512] sgtl5000 0-000a: no default pinctrl state
[    1.857164] sgtl5000: probe of 0-000a failed with error -5

dmesg | grep sai
[    1.863020] bus: 'platform': add driver fsl-sai
[    1.863098] bus: 'platform': driver_probe_device: matched device
40031000.sai with driver fsl-sai
[    1.863121] bus: 'platform': really_probe: probing driver fsl-sai with
device 40031000.sai
[    1.863276] fsl-sai 40031000.sai: no sleep pinctrl state
[    1.863301] fsl-sai 40031000.sai: no idle pinctrl state
[    1.863695] driver: '40031000.sai': driver_bound: bound to device
'fsl-sai'
[    1.863726] bus: 'platform': really_probe: bound device 40031000.sai to
driver fsl-sai
