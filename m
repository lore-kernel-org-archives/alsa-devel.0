From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH] sound: stm32: replace "%p" with "%pK"
Date: Sat, 7 Jul 2018 13:29:18 +0200
Message-ID: <CA+M3ks7QL6t+HLHAiW3T8hDFDNyR494y4dM20jc8YXJ7-Xbd_g@mail.gmail.com>
References: <20180706130703.22352-1-benjamin.gaignard@st.com> <s5hpo00quk4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hpo00quk4.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Alexandre Torgue <alexandre.torgue@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benjamin Gaignard <benjamin.gaignard@st.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

2018-07-06 16:59 GMT+02:00 Takashi Iwai <tiwai@suse.de>:
> On Fri, 06 Jul 2018 15:07:03 +0200,
> Benjamin Gaignard wrote:
>>
>> The format specifier "%p" can leak kernel addresses.
>> Use "%pK" instead.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> The code change itself is OK (apart from the subject prefix to be
> "ASoC").  But do we really want to patch manually every single place
> like this?  There are thousands of files using '%p'.

I have limited myself to the few remaining %p in STM32 architecture.

>
>
> thanks,
>
> Takashi
