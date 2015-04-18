From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: Intel: fix a compiling issue
Date: Sat, 18 Apr 2015 14:19:37 +0200
Message-ID: <CAOf5uw=x2F9AFxoFwGNh-2FbjX-E7sZuki5e6t71JH0amyAb-w@mail.gmail.com>
References: <1428893250-21092-1-git-send-email-yang.jie@intel.com>
 <20150418121106.GM26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id F168B2619BE
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 14:19:38 +0200 (CEST)
Received: by oift201 with SMTP id t201so95379805oif.3
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 05:19:38 -0700 (PDT)
In-Reply-To: <20150418121106.GM26185@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi

On Apr 18, 2015 8:11 PM, "Mark Brown" <broonie@kernel.org> wrote:
>
> On Mon, Apr 13, 2015 at 10:47:30AM +0800, Jie Yang wrote:
> > Fix the compiling issue that we don't have snd_soc_suspend/resume()
> > when CONFIG_PM_SLEEP is not defined.
>
> > +#ifdef CONFIG_PM_SLEEP
> >       snd_soc_resume(pdata->soc_card->dev);
> > -
> > +#endif
>
> Rather than have the ifdefs in the users it seems like it'd be better to
> fix this by providing static inline stub functions in the headers.  That
> way nothing else will run into the same trouble.
>

This was my "English" suggestion

Thanks

Michael

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
