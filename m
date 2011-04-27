From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: prevent compilers from optimising
 pll calculation into __aeabi__uldivmod
Date: Wed, 27 Apr 2011 16:12:49 +0100
Message-ID: <20110427151249.GE31952@opensource.wolfsonmicro.com>
References: <1303889252-6722-1-git-send-email-bs14@csr.com>
	<s5h8vuwgl7f.wl%tiwai@suse.de>
	<BANLkTi=RuNgN_+26GBrwoHJuz1xSM=YcfQ@mail.gmail.com>
	<s5h1v0ogk6k.wl%tiwai@suse.de>
	<BANLkTimm3wB+EcBZMZzW2SoeJkibisdBWQ@mail.gmail.com>
	<20110427143002.GC31952@opensource.wolfsonmicro.com>
	<BANLkTimOdPO=LJNAM8EqXnMcx3xHPcoOXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E101D1038C5
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 17:12:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimOdPO=LJNAM8EqXnMcx3xHPcoOXA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, Barry Song <bs14@csr.com>, Takashi Iwai <tiwai@suse.de>, linaro-toolchain@lists.linaro.org, Zhiwu Song <zhiwu.song@csr.com>, Binghua Duan <binghua.duan@csr.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 27, 2011 at 11:00:18PM +0800, Barry Song wrote:
> 2011/4/27 Mark Brown <broonie@opensource.wolfsonmicro.com>

> > If we do have to do something in the callers rather than in do_div() the
> > annotation seems substantially more taseful than inserting a random asm
> > into the code.

> I agree. for this patch which will not be applied, people can just get
> information about how to workaround the gcc issue while they have the
> same problem. google can find there are other people who failed to
> compile wm8974 module too. eg.
> http://irclogs.ubuntu.com/2010/03/30/%23ubuntu-arm.txt

> Andrew Stubbs, Michael Hope in Linaro's toolchain team are working
> hard on this gcc issue. there have been many update today:
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48783

Is this just some Linaro toolchain that has the issue rather than a
vanilla GCC release?  If so and they fix the compiler bug it doesn't
seem terribly useful to bodge it in mainline.
