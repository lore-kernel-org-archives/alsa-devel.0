From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Sound: MSM soc : imported alsa for the	MSM
	from codeaurora
Date: Mon, 30 Nov 2009 11:20:52 +0000
Message-ID: <20091130112052.GA12133@sirena.org.uk>
References: <1257435101.25623.1.camel@localhost>
	<1257720370-23012-1-git-send-email-GNUtoo@no-log.org>
	<20091113145050.GC30966@sirena.org.uk>
	<1259536602.3374.129.camel@gnutoo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FFBA244B2
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 12:20:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1259536602.3374.129.camel@gnutoo-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: GNUtoo <GNUtoo@no-log.org>
Cc: alsa-devel@alsa-project.org, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 12:16:42AM +0100, GNUtoo wrote:
> On Fri, 2009-11-13 at 14:50 +0000, Mark Brown wrote:

Please remember to keep people CCed on mails.

> > This looks suspicious - it looks like what's going on is that you're
> > getting a notification from the DSP that it has consumed a data buffer
> > but this might go out of bounds and get clamped.

> The first time that it's called prtd->out[idx].used = BUF_INVALID_LEN so
> it's skipped(it's the same first bogus time than in my previous mails).

My more general comment on this stuff was that all the buffer management
code was extremely difficult to follow and hence likely to have errors.
