From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add WM8510 driver
Date: Thu, 5 Jun 2008 09:47:32 +0100
Message-ID: <20080605084732.GA30658@sirena.org.uk>
References: <1212597211-14495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hiqwp401i.wl%tiwai@suse.de>
	<20080604192455.GA10244@opensource.wolfsonmicro.com>
	<s5hr6bc98z8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CEAF9245DF
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 10:47:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr6bc98z8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Brett Saunders <breton.saunders@ntlworld.com>, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 04, 2008 at 11:38:19PM +0200, Takashi Iwai wrote:
> OK.  I just wanted to confirm since the patch had no extra From: line
> although the comment in the code shows Liam as the author.

Ideally we'd be able to merge the full history.

> This is likely superfluous.

> > +#include <sound/initval.h>

> Ditto.

Needed for SNDRV_DEFAULT_IDX1 and SNDRV_DEFAULT_STR1.

> > +	codec->reg_cache_size = sizeof(wm8510_reg);

> Isn't this ARRAY_SIZE()?  Looks like the all codec codes set the wrong
> values for this...

Not all, but most.
