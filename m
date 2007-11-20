From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASoC merge
Date: Tue, 20 Nov 2007 12:43:11 -0500
Message-ID: <9e4733910711200943oea9a057jb92815b88bb6903f@mail.gmail.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910711200659o84d6eebud65150e542b938ba@mail.gmail.com>
	<20071120165654.GC1744@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id E7F5F24A7A
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 18:43:16 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so1497497nzf
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 09:43:15 -0800 (PST)
In-Reply-To: <20071120165654.GC1744@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/20/07, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 20, 2007 at 09:59:15AM -0500, Jon Smirl wrote:
>
> > In asoc v2 soc-core is changed from being a platform driver into
> > subsys_initcall(asoc_bus_init); Is this change going in anytime soon?
> > subsys call is the right way, the alsa core is not a platform device.
> > This will bring asoc into alignment with i2c which already uses
> > subsys_initcall.
>
> I can't give any actual hard timescales for anything but this merge is
> a first step on the way to doing that.  My plan was to try to get the
> pending ASoC v1 changes merged into mainline so that there is only one
> place to keep track of when merging into ASoC v2 development.
>

I've got a patch for the PowerPC that removes platform bus, it's
of_platform bus on the PowerPC. Removing platform bus exposes all
kinds of things that shouldn't be on it, like the ASoC core.

-- 
Jon Smirl
jonsmirl@gmail.com
