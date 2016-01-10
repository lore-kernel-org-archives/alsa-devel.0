From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Sun, 10 Jan 2016 15:36:34 -0600
Message-ID: <5692CEE2.2040504@tabi.org>
References: <5677107C.60904@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5677107C.60904@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Maciej S. Szmigiero wrote:
> There is no guarantee that on fsl_ssi module load
> SSI registers will have their power-on-reset values.
>
> In fact, if the driver is reloaded the values in
> registers will be whatever they were set to previously.
>
> This fixes hard lockup on fsl_ssi module reload,
> at least in AC'97 mode.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero<mail@maciej.szmigiero.name>

Acked-by: Timur Tabi <timur@tabi.org>

I'm surprised that we're actually encouraging drivers to contain 
hard-coded register values.
