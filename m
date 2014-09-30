From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fix dependencies for wm8962
Date: Tue, 30 Sep 2014 10:42:42 -0700
Message-ID: <20140930174241.GA1296@Asurada>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E75C26042A
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 19:42:52 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id p10so3199099pdj.17
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 10:42:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140930164510.GF4273@sirena.org.uk>
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
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 30, 2014 at 05:45:10PM +0100, Mark Brown wrote:
> On Tue, Sep 30, 2014 at 01:43:41PM +0200, Arnd Bergmann wrote:
> > The wm8962 driver uses the input subsystem, but is selected by
> > SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
> > resulting in this link error:
> 
> That select shouldn't be there in the first place, I asked Nicolin to
> fix this when I applied the driver but he's not got round to it yet.

I think I might have missed something around those days, even though
the 'Applied' mail seemly doesn't have any comment against this part:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080083.html

Is that possible for you to copy and paste the comments again?

Thank you
Nicolin
