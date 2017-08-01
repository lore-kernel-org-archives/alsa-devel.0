From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/bridge: adv7511: restrict audio
 sample sizes
Date: Tue, 1 Aug 2017 13:52:35 +0100
Message-ID: <e5506e72-9788-c65d-6467-6590174f825a@linaro.org>
References: <20170731224944.9986-1-srinivas.kandagatla@linaro.org>
 <20170731224944.9986-3-srinivas.kandagatla@linaro.org>
 <7d700845-da72-5c40-31f9-c3faa7ca93a2@st.com>
 <ce018632-0b7a-7e34-6a3d-c191155a17ae@linaro.org>
 <20170801122840.6demhukafhtpeaby@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com
 [209.85.128.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E04026691A
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 14:52:38 +0200 (CEST)
Received: by mail-wr0-f177.google.com with SMTP id k71so6468626wrc.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Aug 2017 05:52:38 -0700 (PDT)
In-Reply-To: <20170801122840.6demhukafhtpeaby@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Archit Taneja <architt@codeaurora.org>, Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org



On 01/08/17 13:28, Mark Brown wrote:
> On Tue, Aug 01, 2017 at 01:24:03PM +0100, Srinivas Kandagatla wrote:
>> On 01/08/17 09:42, Arnaud Pouliquen wrote:
>>> On 08/01/2017 12:49 AM, srinivas.kandagatla@linaro.org wrote:
> 
>>> I already used ADV7513 and i did not observe this limitation.
> 
>>> I had a look to ADV7533 data-sheet. it should support 32 and 64 bits I2S
> 
>> ADV7511_REG_AUDIO_CFG3(0x14) register definition in datasheet and the code
>> in this driver suggest that It only supports 16Bit and 24Bit samples.
> 
> The amount of data it pays attention to in the frame is not the same as
> the size of the frame.
I agree.

> 
>>> format bus, with 16 or 24 bits precision sample. So it should support
>>> SNDRV_PCM_FMTBIT_S32_LE and SNDRV_PCM_FMTBIT_S32_BE
> 
>>> As example, if you configure bus in Left justified format with 24 bits
>>> sample length, 32 bits application samples should be truncated to 24
>>> bits samples at ADV7533 I2S interface level (LSB dropped).
> 
>> May be we can do that to make the user happy but isn't this just truncate
>> the resolution to 24Bit then?
> 
>> And it's a false indication that we are supporting 32bit samples.
>> Which am not very happy with.
> 
> This is what the sample_bits field in the DAI structure is for.ya.
But still reporting that driver supports 32 bit samples when it does not 
really support all 32 bits, is kinda misleading to user.
Isn't it?

And the driver would be end up with hacked up code for each case.


--srini

> 
