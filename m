From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix clock control issue in master mode
Date: Wed, 28 Aug 2019 13:02:32 -0300
Message-ID: <CAOMZO5BF6M4McwGTuNU8jM41+N3jeaJp+U2ST5JY7e+yv8GO_A@mail.gmail.com>
References: <1567012817-12625-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567012817-12625-1-git-send-email-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

On Wed, Aug 28, 2019 at 2:21 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The test case is
> arecord -Dhw:0 -d 10 -f S16_LE -r 48000 -c 2 temp.wav &
> aplay -Dhw:0 -d 30 -f S16_LE -r 48000 -c 2 test.wav
>
> There will be error after end of arecord:
> aplay: pcm_write:2051: write error: Input/output error
>
> Capture and Playback work in parallel in master mode, one
> substream stops, the other substream is impacted, the
> reason is that clock is disabled wrongly.
>
> The clock's reference count is not increased when second
> substream starts, the hw_param() function returns in the
> beginning because first substream is enabled, then in end
> of first substream, the hw_free() disables the clock.
>
> This patch is to move the clock enablement to the place
> before checking of the device enablement in hw_param().
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

It would be nice if you could add a Fixes tag as well.
