From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
Date: Fri, 26 Apr 2019 15:10:10 +0300
Message-ID: <CAEnQRZCPPr1iHvKEj=fOsE8A2iW=XZd=CaoFqAoUqJftg4pN9Q@mail.gmail.com>
References: <20190421193853.10188-1-daniel.baluta@nxp.com> <20190421193853.10188-3-daniel.baluta@nxp.com>
 <20190426100025.GD14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426100025.GD14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 26, 2019 at 1:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Apr 21, 2019 at 07:39:09PM +0000, Daniel Baluta wrote:
> > Basically the same actions as for system PM, so make use
> > of pm_runtime_force_suspend/pm_runtime_force_resume.
>
> This doesn't apply against current code, please check and resend.

Hi Mark,

This patch is already applied:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=812ad463e0894d78e93ab8017e0edbe69038c55c

The only patch left in the series that needs to be applied is this:

https://www.spinics.net/lists/alsa-devel/msg89733.html

I will reply also to that email, to be easier for you to find it.
