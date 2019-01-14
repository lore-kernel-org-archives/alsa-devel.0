From: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 1/3] ASoC: cs4341: fix waring unused-function
Date: Mon, 14 Jan 2019 13:49:17 +0100
Message-ID: <CADYN=9LU2fngmUZrM_E7qS7rGB7y4b45H12yZOW=X7JfaS1qqQ@mail.gmail.com>
References: <20190114095540.22956-1-anders.roxell@linaro.org> <20190114112443.GA11073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114112443.GA11073@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Jan 2019 at 12:24, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 14, 2019 at 10:55:40AM +0100, Anders Roxell wrote:
> > The driver cs4341 can be built with SPI and/or I2C, but it has to be one
> > of them at least. When I2C is set as a module we see the warning below:
>
> I'm missing patches 2 and 3 of this series and there's no cover letter.
> What's the story with dependencies?

oh, I made a mistake. It Should not be any dependencies, just this patch.

Do you want me to resend it without " 1/3]... " in the subject?

Cheers,
Anders
