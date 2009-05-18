From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller driver
 (v2)
Date: Tue, 19 May 2009 01:10:28 +0900 (JST)
Message-ID: <20090519.011028.74560296.anemo@mba.ocn.ne.jp>
References: <20090518142305.GE1629@sirena.org.uk>
	<20090519.002542.39155238.anemo@mba.ocn.ne.jp>
	<20090518153317.GA27195@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B74C24496
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 18:10:31 +0200 (CEST)
In-Reply-To: <20090518153317.GA27195@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Mon, 18 May 2009 16:33:18 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, May 19, 2009 at 12:25:42AM +0900, Atsushi Nemoto wrote:
> 
> > Thank you for elaboration.  Then, this untested patch (on top of the
> > last patch) is what you mean?  If yes, I will split this into arch
> > part and driver part, and then update both patches.
> 
> Partly - I'd also expect to see the resources moved around in the
> architecture code so that they are on the platform devices that are
> being used to probe the DAIs (unless that's what the architecture side
> of your patch was doing, patch wasn't quite giving me enough context to
> be 100% clear).

Now the resources are provided with "txx9aclc-ac97" platform device
which used to probe DAIs.  I will send whole patchset again after some
testing.

> You could also roll the resource requesting and unrequesting into the
> probe functions for the DAI & DMA platform devices, though that is not
> essential.

OK, I will move them into txx9aclc_ac97_dev_probe().  Then I can use
devres functions to make the resource management much simpler.

---
Atsushi Nemoto
