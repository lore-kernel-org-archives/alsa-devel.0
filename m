From: "Kenneth Westfield" <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH 0/9] ASoC: QCOM: Add support for ipq806x
 SOC
Date: Fri, 21 Nov 2014 12:24:33 -0800
Message-ID: <9e2e849728c593bf1b8cde3ede3a1628.squirrel@www.codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
    <AE8D85F1-A1E0-4656-B160-37AA3300FE58@codeaurora.org>
Reply-To: kwestfie@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <AE8D85F1-A1E0-4656-B160-37AA3300FE58@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Bryan Huntsman <bryanh@codeaurora.org>, Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, November 19, 2014 12:16 pm, Kumar Gala wrote:
>
> On Nov 19, 2014, at 12:52 PM, Kenneth Westfield <kwestfie@codeaurora.=
org> wrote:
>
>> From: Kenneth Westfield <kwestfie@codeaurora.org>
>>
>> This set of patches adds support for audio on the Qualcomm Technolog=
ies
>> ipq806x SOC.
>>
>> The ipq806x SOC has audio-related hardware blocks in its low-power a=
udio
>> subsystem (or LPASS).  One of the relevant blocks in the LPASS is it=
s
>> low-power audio interface (or LPAIF).  This encapsulates the MI2S po=
rt,
>> which is what these drivers are configured to use.  The I2S pins are
>> connected to an external DAC/amp chip.  In addition, a single GPIO i=
s
>> connected to the same DAC/amp, which gives the SOC enable/disable
>> control.
>>
>> The specific drivers added are:
>> - a machine driver that handles the board-specific pins
>> - a native driver that handles hardware access to the LPAIF
>> - a CPU DAI driver for controlling the LPAIF block
>> - a PCM MI2S platform driver
>>
>> Corresponding additions to the device tree for the ipq806x and its
>> documentation has also been added.  Also, as this is a new directory=
,
>> the MAINTAINERS file has been updated as well.
>>
>> - Ken
>
> Some general comments, you shouldn=92t have gerrit Change-Id=92s in c=
ommit messages, the
> Kconfig/Makefile changes should be part of the patch that adds the co=
de associated with them.
>
> - k
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum,
> a Linux Foundation Collaborative Project
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Thank you for your comments.  I will separately address each comment sh=
ortly.

--=20
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project
