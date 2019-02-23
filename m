From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove unsupported formats in i2s master mode
Date: Sat, 23 Feb 2019 08:49:27 -0500
Message-ID: <CAGngYiXx9_iaeRJdfT2O=PPUaWJOr=pbWBgOfTmP8EcRU+MGvg@mail.gmail.com>
References: <20190221153550.1932-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221153550.1932-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 21, 2019 at 10:35 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Fix by constraining the frame bits in i2s master mode
> to 32 * channels. This will filter out those formats
> that the ssi cannot support.
>

Russell King (ARM Linux) informs me that this is not correct, and that
the problem
should be approached differently.

Please remove from consideration if you hadn't done so already.
Thanks :)
