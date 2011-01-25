From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: correct link specifications for
 corgi, poodle and spitz
Date: Tue, 25 Jan 2011 15:16:30 +0000
Message-ID: <1295968590.3322.256.camel@odin>
References: <1295637257-28299-1-git-send-email-dbaryshkov@gmail.com>
	<20110125150317.GG31453@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A18CF103929
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 16:16:36 +0100 (CET)
Received: by wyi11 with SMTP id 11so5675182wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 07:16:36 -0800 (PST)
In-Reply-To: <20110125150317.GG31453@opensource.wolfsonmicro.com>
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
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-25 at 15:03 +0000, Mark Brown wrote:
> On Fri, Jan 21, 2011 at 10:14:17PM +0300, Dmitry Eremin-Solenikov wrote:
> > ASoC DAI link descriptions for Corgi, Poodle and Spitz platforms
> > contained incorrect names for cpu_dai and codec, which effectievly disabled sound
> > on theese platforms. Fix that errors.
> 
> Ccing in Liam who you forgot to CC - please make sure you CC all
> maintainers on patches.
> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > ---
> >  sound/soc/pxa/corgi.c  |    4 ++--
> >  sound/soc/pxa/poodle.c |    2 +-
> >  sound/soc/pxa/spitz.c  |    4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >

Looks fine to me.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
