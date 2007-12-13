From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH 2/2] sis7019: add support for
	pre-2.6	kernels
Date: Thu, 13 Dec 2007 12:43:47 -0500
Message-ID: <20071213174347.GA22257@thedillows.org>
References: <1197158043.3588.52.camel@obelisk.thedillows.org>
	<1197273182.31526.1225705529@webmail.messagingengine.com>
	<1197296683.3994.11.camel@obelisk.thedillows.org>
	<1197298124.31051.1225761969@webmail.messagingengine.com>
	<s5hk5ni7fvj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id CCCDE246B8
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 18:43:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk5ni7fvj.wl%tiwai@suse.de>
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

On Thu, Dec 13, 2007 at 04:50:56PM +0100, Takashi Iwai wrote:
> Yep, it seems so.  The invalid asm codes becomes an error only at
> assembler -> binary level, so it's harmless unless it's really used in
> the driver code.
> 
> Anyway, uninitialized_var() should be ported to adriver.h as well.
> Then we'll have a clean sis7019.c in alsa-driver tree, too.

I'll do the ffs() as suggested, but I rewrote the area that had the
uninitialized_var(), so I don't need them any longer.

Dave
