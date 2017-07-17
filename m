From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] Revert "ASoC: ux500: drop platform DAI
	assignments"
Date: Mon, 17 Jul 2017 10:07:37 +0200
Message-ID: <20170717080737.GA29638@localhost>
References: <20170712155530.17765-1-johan@kernel.org>
 <20170712155530.17765-2-johan@kernel.org>
 <CACRpkdbOkxTstPdvUSMe3J+BF1ifnQoJNCf657U+UTHr=aBREQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B70E266E0B
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 10:07:29 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id t72so12587936lff.0
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 01:07:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdbOkxTstPdvUSMe3J+BF1ifnQoJNCf657U+UTHr=aBREQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, stable <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 14, 2017 at 03:36:57PM +0200, Linus Walleij wrote:
> On Wed, Jul 12, 2017 at 5:55 PM, Johan Hovold <johan@kernel.org> wrote:
> 
> > This reverts commit f1013cdeeeb9 ("ASoC: ux500: drop platform DAI
> > assignments"), which seems to have been based on a misunderstanding and
> > prevents the platform driver callbacks from being made (e.g. to
> > preallocate DMA memory).
> >
> > The real culprit for the warnings about attempts to create duplicate
> > procfs entries was commit 99b04f4c4051 ("ASoC: add Component level
> > pcm_new/pcm_free" that broke PCM creation on systems that use more than
> > one platform component.
> >
> > Fixes: f1013cdeeeb9 ("ASoC: ux500: drop platform DAI assignments")
> > Cc: stable <stable@vger.kernel.org>     # 4.11
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> These static assignments should go away, but not for the wrong reason.
> So this patch is fully in order given the source of the bug.

I assume you'll still need the of-related bits though (platform_of_node)
even if you eventually make this driver use DT-instantiation only.

Thanks again,
Johan
