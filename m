From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register volatile
Date: Thu, 24 Dec 2015 10:12:41 -0600
Message-ID: <CAOZdJXVK-_j+pF+dXsnWd0AQZWD3p9+=ziS3Byw5e2ED1W_W=g@mail.gmail.com>
References: <56770FE1.4060202@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56770FE1.4060202@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 20, 2015 at 2:30 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> SACNT register should be marked volatile since
> its WR and RD bits are cleared by SSI after
> completing the relevant operation.
> This unbreaks AC'97 register access.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

These patches seem okay, but can we hold off merging them until I get
back from vacation and have a chance to review them?
