From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fix dependencies for wm8962
Date: Tue, 30 Sep 2014 16:26:18 -0700
Message-ID: <20140930232617.GA1732@Asurada>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
 <20140930174241.GA1296@Asurada>
 <20140930230906.GQ4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DA4A2610A3
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 01:26:26 +0200 (CEST)
Received: by mail-pd0-f180.google.com with SMTP id fp1so6008673pdb.11
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 16:26:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140930230906.GQ4273@sirena.org.uk>
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

On Wed, Oct 01, 2014 at 12:09:06AM +0100, Mark Brown wrote:
> On Tue, Sep 30, 2014 at 10:42:42AM -0700, Nicolin Chen wrote:
> > On Tue, Sep 30, 2014 at 05:45:10PM +0100, Mark Brown wrote:
> 
> > > That select shouldn't be there in the first place, I asked Nicolin to
> > > fix this when I applied the driver but he's not got round to it yet.
> 
> > I think I might have missed something around those days, even though
> > the 'Applied' mail seemly doesn't have any comment against this part:
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080083.html
> 
> > Is that possible for you to copy and paste the comments again?
> 
> I suspect it was on an earlier version of the patch or a cover letter;
> IIRC you were resending while I was reviewing.

I checked the Archive, the patch only got one version without cover
letter. And this version only got one reply which is the Applied mail.
I guess your earlier reply might have been swallowed somehow so I
couldn't read it.

Anyway, it's my fault that I didn't pay attention to the Kconfig part.
The driver is initially designed for imx-cs42888, but I changed my mind
to merge it with others before I sent it. And I didn't rewrite the part
inside the Kconfig. Will be careful next time.

And I think Fabio's suggestion/patch has no problem right?

Thank you
Nicolin
