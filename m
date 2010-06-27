From: David Dillow <dave@thedillows.org>
Subject: Re: [PATCH] sis7019: fix capture issues with multiple
 periods per buffer
Date: Sun, 27 Jun 2010 10:46:08 -0400
Message-ID: <1277649968.2438.34.camel@obelisk.thedillows.org>
References: <1277589872.2438.5.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 6224E103896
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 16:46:14 +0200 (CEST)
In-Reply-To: <1277589872.2438.5.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-06-26 at 18:04 -0400, David Dillow wrote:
> When using a timing voice to clock out periods during capture, the
> driver would slowly loose synchronization and never catch up, eventually
> reaching a point where it no longer generated interrupts.

> ---
> This has survived overnight testing at 44.1 kHz/16 bit/mono without issue.

Only to die at 12 hours and ~15 minutes. It did not trip any of the
instrumentation I was using to verify operation, so this may be a
different problem. I'm looking into it.

Dave
