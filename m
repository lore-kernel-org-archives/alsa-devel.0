From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC PCM drivers without progress counters breaks
 snd_pcm_status
Date: Wed, 26 Oct 2011 14:22:26 +0100
Message-ID: <20111026132226.GB5114@sirena.org.uk>
References: <A612847CFE53224C91B23E3A5B48BAC74BFCF3FBD6@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E499624964
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 15:22:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74BFCF3FBD6@xmail3.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Magnus Olsson <magnus.olsson@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 26, 2011 at 11:25:03AM +0200, Magnus Olsson wrote:

Always CC maintainers on mails and fix your mail client so that it word
wraps within paragraphs for legibility.

> 1)      If DMA HW supports progress counter, implement it.

This is just a basic quality of implementation issue - if the driver
isn't taking advantage of the hardware the driver is obviously not doing
a good job and should be improved.

> 2)      If DMA HW is not supported, implement it in software (estimate
> position using elapsed time since last irq). Only requires driver
> changes.

No, we can't do this.  The pointer isn't just there for AV sync, it also
gives userspace information about where the hardware is at in the buffer
so we need to keep in sync with what the driver is doing.

> 3)      If DMA HW is not supported, return use last irq timestamp as
> the timestamp returned by snd_pcm_status_get_htstamp() . Probably
> requires ALSA Core changes.

This is pretty much what's happening right now, userspace should be
using the period information if it doesn't have anything better.
