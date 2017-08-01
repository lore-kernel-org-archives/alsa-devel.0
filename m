From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: adv7511: restrict audio
 sample sizes
Date: Tue, 1 Aug 2017 17:50:03 +0200
Message-ID: <3bf60afb-d260-badd-7340-6d54a4decd62@st.com>
References: <20170731224944.9986-1-srinivas.kandagatla@linaro.org>
 <20170731224944.9986-3-srinivas.kandagatla@linaro.org>
 <7d700845-da72-5c40-31f9-c3faa7ca93a2@st.com>
 <ce018632-0b7a-7e34-6a3d-c191155a17ae@linaro.org>
 <20170801122840.6demhukafhtpeaby@sirena.org.uk>
 <e5506e72-9788-c65d-6467-6590174f825a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F92B26691A
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 17:50:06 +0200 (CEST)
In-Reply-To: <e5506e72-9788-c65d-6467-6590174f825a@linaro.org>
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
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Airlie <airlied@linux.ie>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Hello Srinivas,

On 08/01/2017 02:52 PM, Srinivas Kandagatla wrote:
>>>> As example, if you configure bus in Left justified format with 24 bits
>>>> sample length, 32 bits application samples should be truncated to 24
>>>> bits samples at ADV7533 I2S interface level (LSB dropped).
>>
>>> May be we can do that to make the user happy but isn't this just truncate
>>> the resolution to 24Bit then?
>>
>>> And it's a false indication that we are supporting 32bit samples.
>>> Which am not very happy with.
>>
>> This is what the sample_bits field in the DAI structure is for.ya.
> But still reporting that driver supports 32 bit samples when it does not 
> really support all 32 bits, is kinda misleading to user.
> Isn't it?
> 
> And the driver would be end up with hacked up code for each case.

By experience, this is usual. As example, if you have a look to codec
ad193x (i take one randomly) it support 16, 20, 24 and 32 bits frames.
But if you have a look to AD1939 data-sheet it supports 24-bits conversion.
Some other examples could be 13-bits DAC/ADC with 16 bits samples.

In term of audio quality, truncation to a 24 bits sample should generate
an negligible additional error equal to the LSB bit: -20log(2^24)= -144dB.

It is just a personal opinion, but if have the choice between do
truncation in software (application or alsa-lib) and in hardware, i
would prefer the second one.

Regards
arnaud
