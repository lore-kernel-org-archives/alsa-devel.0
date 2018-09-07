From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs
	include/delay.h
Date: Fri, 7 Sep 2018 10:52:24 -0700
Message-ID: <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
References: <20180907002728.112770-1-grundler@chromium.org>
 <20180907121128.GH17459@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D00F626777B
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 19:52:38 +0200 (CEST)
Received: by mail-io1-f68.google.com with SMTP id v14-v6so2183222iob.4
 for <alsa-devel@alsa-project.org>; Fri, 07 Sep 2018 10:52:38 -0700 (PDT)
In-Reply-To: <20180907121128.GH17459@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, Grant Grundler <grundler@chromium.org>, lgirdwood@gmail.com, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 7, 2018 at 5:11 AM Mark Brown <broonie@kernel.org> wrote:

> On Thu, Sep 06, 2018 at 05:27:28PM -0700, Grant Grundler wrote:
> > Commit ca917f9fe1a0fab added use of usleep_range() but not
> > the corresponding "include <linux/delay.h>". The result is
> > with Chrome OS won't build because warnings are forced
> > to be errors:
> >
> mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:734:2:
> error: implicit declaration of function 'usleep_range'
> [-Werror,-Wimplicit-function-declaration]
> >         usleep_range(10000, 11000);
> >         ^
>
> Note that this isn't causing a warning upstream, presumably due to an
> implicit inclusion that isn't present in the v4.4 kernel that you appear
> to be using, or gets missed due to config differences.
>

Ok. Is this just an observation or are these reasons to not accept the
change?

cheers,
grant
