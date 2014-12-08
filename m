From: "Kenneth Westfield" <kwestfie@codeaurora.org>
Subject: Re: [PATCH 9/9] ARM: dts: Model IPQ LPASS audio hardware
Date: Mon, 8 Dec 2014 14:07:12 -0800
Message-ID: <87490f54e5c4c0c4dd81298a08e5d81c.squirrel@www.codeaurora.org>
Reply-To: kwestfie@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, November 19, 2014 2:54 pm, Courtney Cavin wrote:
> On Wed, Nov 19, 2014 at 07:52:49PM +0100, Kenneth Westfield wrote:
>> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>> @@ -2,6 +2,7 @@
>>  #include "skeleton.dtsi"
>>  #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
>> +#include <dt-bindings/clock/qcom,lcc-ipq806x.h>
> Neither this file nor an associated clock controller driver exists in mainline.  Is there some
other series this depends on?
> -Courtney

This patch series has a dependency on the following patch series from linux-arm-msm: [PATCH v2
0/8] qcom audio clock control drivers
http://thread.gmane.org/gmane.linux.ports.arm.msm/10793


-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,  a Linux Foundation
Collaborative Project
