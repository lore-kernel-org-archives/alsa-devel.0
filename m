From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_esai: Add freq check in set_dai_sysclk()
Date: Sun, 8 Apr 2018 22:31:54 -0300
Message-ID: <CAOMZO5D-HNjLyLHft4OiTt806ePJvMbuhKZ4yzO07pD2-w4kqA@mail.gmail.com>
References: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 8, 2018 at 9:33 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> The freq parameter indicates the physical frequency of an actual
> input clock or a desired frequency of an output clock for HCKT/R.
> It should never be passed 0. This might cause Division-by-zero.
>
> So this patch adds a check to fix it.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
