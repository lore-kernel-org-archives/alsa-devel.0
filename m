From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [RFT PATCH 1/2] ASoC: zx: i2s: Fix devm_ioremap_resource return
 value check
Date: Fri, 10 Jul 2015 09:45:26 +0900
Message-ID: <CAJKOXPdPn51TsDqB9oa5TTd2gsLCd3vdDDwvO3foE5FVg5hAAQ@mail.gmail.com>
References: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
	<20150709153329.GM11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150709153329.GM11162@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jun Nie <jun.nie@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

W dniu 10 lipca 2015 00:33 u=C5=BCytkownik Mark Brown <broonie@kernel.o=
rg> napisa=C5=82:
> On Thu, Jul 09, 2015 at 10:19:28PM +0900, Krzysztof Kozlowski wrote:
>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>> Cc: <stable@vger.kernel.org>
>
> Why are you adding a Cc to stable?  The zx driver was added in the me=
rge
> window...

My mistake, I did not check when the commit was merged. Can you strip
the CC from the patch?

Best regards,
Krzysztof
