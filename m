From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Default enabling of mixer controls
Date: Tue, 9 Jun 2009 09:15:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030591A9D1@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030591A896@dbde02.ent.ti.com>
	<20090608121447.GD7858@sirena.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB030591A903@dbde02.ent.ti.com>
	<20090608143910.GA6413@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 2913B2447A
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 05:45:35 +0200 (CEST)
In-Reply-To: <20090608143910.GA6413@rakim.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Monday, June 08, 2009 8:09 PM
> To: Aggarwal, Anuj
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Default enabling of mixer controls
> 
> On Mon, Jun 08, 2009 at 07:54:00PM +0530, Aggarwal, Anuj wrote:
> 
> > 	/* Enable Analog Left Capture Route AUXL */
> > 	reg = codec->read(codec, TWL4030_REG_ANAMICL);
> > 	reg |= TWL4030_AUXL_EN;
> > 	codec->write(codec, TWL4030_REG_ANAMICL, reg);
> 
> > After that, if I do a get on Analog Left Capture Route AUXL (or the
> other),
> > I am seeing that it has been turned ON. However, when I try to capture,
> > It doesn't work. I have to disable it first and then re-enable it to
> > capture properly.
> 
> Hrm, you'll be missing some internal DAPM state updates.  Currently the
> most direct way to do that would be to go through the actual control
> interface and there's not a particularly nice way of doing that that
> from the kernel that I'm aware of.
> 
> Is this not something you can have user space do?
[Aggarwal, Anuj] Since this was by default enabled in my earlier codec driver, I wanted to make the change transparent to the end user. However,
since the same can be done from user space too, it should not be a problem for my customer.
