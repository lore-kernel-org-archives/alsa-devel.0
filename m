From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 0/9] ASoC: QCOM: Add support for ipq806x SOC
Date: Wed, 19 Nov 2014 14:16:10 -0600
Message-ID: <AE8D85F1-A1E0-4656-B160-37AA3300FE58@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


On Nov 19, 2014, at 12:52 PM, Kenneth Westfield <kwestfie@codeaurora.or=
g> wrote:

> From: Kenneth Westfield <kwestfie@codeaurora.org>
>=20
> This set of patches adds support for audio on the Qualcomm Technologi=
es
> ipq806x SOC.
>=20
> The ipq806x SOC has audio-related hardware blocks in its low-power au=
dio
> subsystem (or LPASS).  One of the relevant blocks in the LPASS is its
> low-power audio interface (or LPAIF).  This encapsulates the MI2S por=
t,
> which is what these drivers are configured to use.  The I2S pins are
> connected to an external DAC/amp chip.  In addition, a single GPIO is
> connected to the same DAC/amp, which gives the SOC enable/disable
> control.
>=20
> The specific drivers added are:
> - a machine driver that handles the board-specific pins
> - a native driver that handles hardware access to the LPAIF
> - a CPU DAI driver for controlling the LPAIF block
> - a PCM MI2S platform driver
>=20
> Corresponding additions to the device tree for the ipq806x and its
> documentation has also been added.  Also, as this is a new directory,
> the MAINTAINERS file has been updated as well.
>=20
> - Ken

Some general comments, you shouldn=92t have gerrit Change-Id=92s in com=
mit messages, the Kconfig/Makefile changes should be part of the patch =
that adds the code associated with them.

- k

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project
