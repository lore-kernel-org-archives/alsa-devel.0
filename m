From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Date: Fri, 7 Sep 2018 12:28:28 -0700
Message-ID: <CANEJEGteyDV2pWjC=z_btexMOcYnRER8ScqVTYqxZQO6DOsNTQ@mail.gmail.com>
References: <20180907002728.112770-1-grundler@chromium.org>
 <20180907121128.GH17459@sirena.org.uk> <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
 <20180907175620.GL17459@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907175620.GL17459@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: Grant Grundler <grundler@chromium.org>, ryans.lee@maximintegrated.com, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 7, 2018 at 10:56 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Sep 07, 2018 at 10:52:24AM -0700, Grant Grundler wrote:
> > On Fri, Sep 7, 2018 at 5:11 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > Note that this isn't causing a warning upstream, presumably due to an
> > > implicit inclusion that isn't present in the v4.4 kernel that you appear
> > > to be using, or gets missed due to config differences.
>
> > Ok. Is this just an observation or are these reasons to not accept the
> > change?
>
> An observation, you should already have a mail about it being applied.

Ah ok! Thanks for pointing that out (and for reviewing/accepting the patch).

cheers,
grant
