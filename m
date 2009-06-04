From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Thu, 4 Jun 2009 15:12:25 +0200
Message-ID: <20090604131225.GL26688@buzzloop.caiaq.de>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090604123632.GC11496@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 845B6103958
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 15:12:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090604123632.GC11496@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2009 at 01:36:32PM +0100, Mark Brown wrote:
> On Wed, Jun 03, 2009 at 08:33:42PM +0800, Eric Miao wrote:
> > Make the pxa I2S configuration generic, add support for Left_J, add
> > support for variable frame width like 32fs, 48fs, 64fs and 96fs
> 
> I'm OK with this from a code review point of view providing Daniel is
> happy from a testing point of view.  I'll need to fire up my Zylonite
> and test on that as well - I'll update the machine driver as required
> assuming everything works OK.

I'll need some time to test that. Hope to get back to you soon.

Daniel
