From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Refector DAPM event handler
Date: Thu, 17 Jul 2008 14:48:06 +0100
Message-ID: <20080717134756.GE15333@sirena.org.uk>
References: <1216292376-2583-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5habgghe74.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1805C2437C
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 15:48:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5habgghe74.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 17, 2008 at 02:45:19PM +0200, Takashi Iwai wrote:

> With this patch, dapm_update_bits() is called even when
> power_change=0, so it changes the behavior.  You can check
> power_change only once and skip the rest via continue if it's false.

Fixed - dapm_update_bits() already suppresses duplicate writes.

> Also, better to put parentheses around bit-and operation.

Fixed.  As with some other things it might be worth adding checks you
want like this to checkpatch.

> Anyway, if the indent level really matters, you should better to put
> it as a function.

The new indentation level is fine - the major issue was that the old
layout was over 80 columns already (checkpatch!), plus the way it was
structured would lead to exploding nesting levels when new cases were
added.  Splitting it out would only move it away from the handling of
other widgets which wouldn't help so much.

I'll resubmit shortly.
