From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Default enabling of mixer controls
Date: Mon, 8 Jun 2009 15:39:10 +0100
Message-ID: <20090608143910.GA6413@rakim.wolfsonmicro.main>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030591A896@dbde02.ent.ti.com>
	<20090608121447.GD7858@sirena.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB030591A903@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 606302445F
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:39:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030591A903@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 07:54:00PM +0530, Aggarwal, Anuj wrote:

> 	/* Enable Analog Left Capture Route AUXL */
> 	reg = codec->read(codec, TWL4030_REG_ANAMICL);
> 	reg |= TWL4030_AUXL_EN;
> 	codec->write(codec, TWL4030_REG_ANAMICL, reg);

> After that, if I do a get on Analog Left Capture Route AUXL (or the other),
> I am seeing that it has been turned ON. However, when I try to capture,
> It doesn't work. I have to disable it first and then re-enable it to
> capture properly.

Hrm, you'll be missing some internal DAPM state updates.  Currently the
most direct way to do that would be to go through the actual control
interface and there's not a particularly nice way of doing that that
from the kernel that I'm aware of.

Is this not something you can have user space do?
