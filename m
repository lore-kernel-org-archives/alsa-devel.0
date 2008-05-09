From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Fri, 9 May 2008 10:55:11 +0200
Message-ID: <20080509085511.GE2592@elte.hu>
References: <4823AAF2.7070102@keyaccess.nl> <s5hzlr0105c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	by alsa0.perex.cz (Postfix) with ESMTP id DFECF243B1
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 10:55:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzlr0105c.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@keyaccess.nl>, Linux Kernel <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Glauber Costa <gcosta@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Pete Clements <clem@clem.clem-digital.net>
List-Id: alsa-devel@alsa-project.org


* Takashi Iwai <tiwai@suse.de> wrote:

> Thanks for catching it.  Yeah, the patch looks buggy.  We had an 
> implicit assumption that dev = NULL for ISA devices that require 24bit 
> DMA.
> 
> How about the patch below?  It's against the latest Linus git tree.

good catch! Queued it up for testing. Jesse, do you concur?

	Ingo
