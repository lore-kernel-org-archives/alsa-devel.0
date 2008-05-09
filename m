From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Fri, 09 May 2008 14:03:18 +0200
Message-ID: <48243D86.7020504@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl> <s5hzlr0105c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id CCD0B24443
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 14:02:12 +0200 (CEST)
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Glauber Costa <gcosta@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Pete Clements <clem@clem.clem-digital.net>
List-Id: alsa-devel@alsa-project.org

On 09-05-08 08:06, Takashi Iwai wrote:

> Thanks for catching it.  Yeah, the patch looks buggy.  We had an
> implicit assumption that dev = NULL for ISA devices that require 24bit
> DMA.
> 
> How about the patch below?  It's against the latest Linus git tree.

Yes, works well. Thank you.

Rene.
