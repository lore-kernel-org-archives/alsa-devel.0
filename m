From: "Kenneth Westfield" <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH 9/9] ARM: dts: Model IPQ LPASS audio
 hardware
Date: Fri, 21 Nov 2014 12:17:25 -0800
Message-ID: <cfe24f81daa727ba7e7ace434784a04d.squirrel@www.codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
    <1416423169-21865-10-git-send-email-kwestfie@codeaurora.org>
    <20141119225443.GB13013@sonymobile.com>
Reply-To: kwestfie@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141119225443.GB13013@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Bryan Huntsman <bryanh@codeaurora.org>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, November 19, 2014 2:54 pm, Courtney Cavin wrote:

> On Wed, Nov 19, 2014 at 07:52:49PM +0100, Kenneth Westfield wrote:
>> From: Kenneth Westfield <kwestfie@codeaurora.org>
>>
>> Model the LPASS audio hardware for the IPQ806X.
>>
>> Change-Id: Ide1aa0d09c23d4496aa9c40e3c9878a968261f11
>
> As Kumar mentioned, please exclude this.
>
>> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
>> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
>
> Typically, the order of these SoB should match some sort of chain of delivery:
>  - The first should be the author of the patch
>  - The last should match the email source (you) <-- doesn't seem to be the case
>
>> ---
>>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>> index 63b2146f563b541e4994697af5ee1bbb41a4abd1..0e5b3b625f0442964aa7fbbc993c6c818fe99041 100644
>> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>> @@ -2,6 +2,7 @@
>>
>>  #include "skeleton.dtsi"
>>  #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
>> +#include <dt-bindings/clock/qcom,lcc-ipq806x.h>
>
> Neither this file nor an associated clock controller driver exists in
> mainline.  Is there some other series this depends on?
>
> -Courtney
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Courtney

Thank you for your comments.  I will separately address each comment shortly.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
