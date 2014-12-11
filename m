From: "Kenneth Westfield" <kwestfie@codeaurora.org>
Subject: Re: [Patch v2 02/11] ASoC: qcom: Add device tree binding docs
Date: Thu, 11 Dec 2014 00:23:55 -0800
Message-ID: <fdc53daed0c7c41168a14de6b2983895.squirrel@www.codeaurora.org>
Reply-To: kwestfie@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, December 9, 2014 7:37 am, Mark Brown wrote:
> On Mon, Dec 08, 2014 at 02:01:04PM -0800, Kenneth Westfield wrote:
>> From: Kenneth Westfield <kwestfie@codeaurora.org>

>> Add documentation to the sound directory of the
>> device-tree bindings for IPQ806x audio drivers.
> Please don't send multiple separate changes in a single patch.  One change per patch.

In an effort to reduce the number of patches, would it be possible to package the DT doc with its
respective driver in one patch?  Or does the DT doc need to be in a patch by itself?  I've seen
examples of both.

Also, I will combine the partial addition of each driver to its respective Kconfig/Makefile
entries.  For this, I believe I need to start with an empty Kconfig/Makefile in the first patch?


-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,  a Linux Foundation
Collaborative Project
