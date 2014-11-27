From: Bryan Huntsman <bryanh@codeaurora.org>
Subject: Re: [PATCH 7/9] ASoC: qcom: Add ability to build QCOM drivers
Date: Wed, 26 Nov 2014 17:26:28 -0800
Message-ID: <54767DC4.7060808@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org> <1416423169-21865-8-git-send-email-kwestfie@codeaurora.org> <20141125220737.GX7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141125220737.GX7712@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 11/25/2014 02:07 PM, Mark Brown wrote:
> On Wed, Nov 19, 2014 at 10:52:47AM -0800, Kenneth Westfield wrote:
> 
>> +++ b/sound/soc/qcom/Kconfig
>> @@ -0,0 +1,43 @@
...
>> +# Permission to use, copy, modify, and/or distribute this software for any
>> +# purpose with or without fee is hereby granted, provided that the above
>> +# copyright notice and this permission notice appear in all copies.
>> +#
>> +# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
>> +# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
>> +# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
>> +# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
>> +# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
>> +# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
>> +# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> 
> Please just license the file under the GPL, all the drivers that get
> built from here are GPLed - I can't see any reason for this to have an
> odd license.

Why is there even a license blurb here?  Just drop it.

- Bryan


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
