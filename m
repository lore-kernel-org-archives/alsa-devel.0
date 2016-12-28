From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC : fsl_ssi : Correct the condition to
 check AC97 mode
Date: Wed, 28 Dec 2016 15:53:07 -0200
Message-ID: <CAOMZO5DgtyJrFwa0-VZmXZYQVbMxtsHRuoRbAHw5CX2K7aVMkQ@mail.gmail.com>
References: <20161228110636.GA14768@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161228110636.GA14768@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 28, 2016 at 9:06 AM, Harisangam, Sharvari (S.)
<sharvari.harisangam@visteon.com> wrote:
>  Corrected the condition to check if ssi is configured for AC97
>  mode. Other modes like dsp_a also satisfy the ANDing condition.
>
> Signed-off-by: Sharvari Harisangam <sharvari.harisangam@visteon.com>

This has been fixed in 4.3 kernel by commit:

5b64c173cdea211 ("ASoC: fsl_ssi: Fix checking of dai format for AC97 mode")
