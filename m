From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] ASoC: sgtl5000: Fix the cache handling
Date: Sat, 24 May 2014 16:13:42 -0300
Message-ID: <CAOMZO5DRv9sBHpsY_kJCOT0-PrRYbY9KF0t7JCBVXuGb=W7Njw@mail.gmail.com>
References: <1400856538-26859-1-git-send-email-festevam@gmail.com>
 <20140523183357.GL22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 0182A2610A0
 for <alsa-devel@alsa-project.org>; Sat, 24 May 2014 21:13:44 +0200 (CEST)
Received: by mail-vc0-f180.google.com with SMTP id hy4so7734055vcb.11
 for <alsa-devel@alsa-project.org>; Sat, 24 May 2014 12:13:42 -0700 (PDT)
In-Reply-To: <20140523183357.GL22111@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 23, 2014 at 3:33 PM, Mark Brown <broonie@kernel.org> wrote:

> Looking at the code what I'd expect to happen here is that
> set_bias_level() manages the cache enable, turning on cache only mode
> just before it turns the regulators off and restoring normal mode just
> after enabling them, then calling _restore_regs() after that.  The
> resume call should just be a call to set_bias_level() then.

Thanks, Mark. Your suggestion works fine.
