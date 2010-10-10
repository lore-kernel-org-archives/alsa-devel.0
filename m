From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Use delayed work for debounce of
 GPIO based jacks
Date: Sun, 10 Oct 2010 11:38:57 +0100
Message-ID: <1286707137.3429.18.camel@odin>
References: <1286406301-25767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20101007085431.879415b7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 32A4910380F
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 12:39:04 +0200 (CEST)
In-Reply-To: <20101007085431.879415b7.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ujfalusi <peter.ujfalusi@nokia.com>, Peter@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-10-07 at 08:54 +0300, Jarkko Nikula wrote:
> On Wed,  6 Oct 2010 16:05:01 -0700
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > Rather than block the workqueue by sleeping to do the debounce use delayed
> > work to implement the debounce time. This should also mean that we extend
> > the debounce time on each new bounce, potentially allowing shorter debounce
> > times for clean insertions.
> > 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> > 
> > This is completely untested as I do not have any systems to hand which
> > can make use of this functionality but I believe it should work - I've
> > CCed a couple of the OMAP people since they seem to be the main users.
> > 
> >  include/sound/soc.h  |    2 +-
> >  sound/soc/soc-jack.c |   11 +++++------
> >  2 files changed, 6 insertions(+), 7 deletions(-)
> > 
> Works fine on N900 when testing with
> hexdump /dev/input/by-path/platform-soc-audio-event
> 
> I have a vague memory that user space and actual state can get soon out
> of sync if using delay based debouncing only and doing some insane plug
> in/out cycle. So this is a step to right direction for implementing
> more advanced debouncing.
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
