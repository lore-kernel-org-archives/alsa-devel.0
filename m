From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 1/1] ARM: TLV320AIC23 SoC Audio Codec: Fix errors reported
 related to input routing signals.
Date: Thu, 26 Feb 2015 14:52:09 +0300
Message-ID: <CAMo8BfLtzn3J5waTMCRgUxaoC_w=aNkRCHoFP3AFoH4dP9PTkA@mail.gmail.com>
References: <1424950347-26241-1-git-send-email-dobatog@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424950347-26241-1-git-send-email-dobatog@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriel Dobato <dobatog@gmail.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, moinejf@free.fr, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Xiubo Li <Li.Xiubo@freescale.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 26, 2015 at 2:32 PM, Gabriel Dobato <dobatog@gmail.com> wrote:
> From: dobatog <dobatog@gmail.com>
>
> The following patch, based on stable v3.19,  corrects the errors that are reported in the boot trace in reference to the Input Signals of the audio codec TLV320AIC23:
>
> tlv320aic23-codec 1-001a: Control not supported for path LLINEIN -> [NULL] -> Line Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for LLINEIN --> NULL --> Line Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route LLINEIN -> NULL -> Line Input
> tlv320aic23-codec 1-001a: Control not supported for path RLINEIN -> [NULL] -> Line Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for RLINEIN --> NULL --> Line Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route RLINEIN -> NULL -> Line Input
> tlv320aic23-codec 1-001a: Control not supported for path MICIN -> [NULL] -> Mic Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for MICIN --> NULL --> Mic Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route MICIN -> NULL -> Mic Input
>
> I am trying to set the sound system in a CM-510 (Compulab - SoM) based board with DT, using Simple-Card-Audio and  the TLV320AIC23 audio codec included in the SoM . I faced this problem and thanks to the help of Sebastian Hesselbarth who noticed the possible error located in the structure snd_soc_dapm_route tlv320aic23_intercon[] , now errors are not reported.
>
> Tested on CM-510 (Compulab SoM Board).

Tested-by: Max Filippov <jcmvbkbc@gmail.com>

> Signed-off-by: dobatog <dobatog@gmail.com>

I believe you need to use your real name here and in the From: line.

-- 
Thanks.
-- Max
