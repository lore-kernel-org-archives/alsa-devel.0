From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH RFC 00/15] ASoC: qcom: Add capture support.
Date: Wed, 3 Feb 2016 08:48:21 +0000
Message-ID: <56B1BED5.2090708@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160203003310.GA14436@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160203003310.GA14436@kwestfie-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks Kenneth for review comments.

On 03/02/16 00:33, Kenneth Westfield wrote:
> On Mon, Feb 01, 2016 at 09:27:02AM -0800, Srinivas Kandagatla wrote:
>> LPASS IP on QCOM SOC supports both Playback and capture
>> via I2S, but this feature is missing in existing code.
>> This patchset aims at adding capture support to lpass IP.
>> First few patches in this series does cleanup the driver
>> to make easy to add capture support.
>>
>> These patches are tested on DB410C with Headset Mic.
>
> Thanks for posting this.  I went through the changes, and it mostly
> looks good minus some small, easy-to-fix nits.
I agree with all the comments, and will send a new version with fixes.

--srini
>
