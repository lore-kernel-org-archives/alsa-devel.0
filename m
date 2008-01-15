From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA:  Enable chipset gcap usage
Date: Tue, 15 Jan 2008 06:56:30 -0800
Message-ID: <1200408990.27806.78.camel@razman.gruemaster.com>
References: <1200339867.27806.25.camel@razman.gruemaster.com>
	<s5hprw32xnl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 269472417E
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 15:56:36 +0100 (CET)
In-Reply-To: <s5hprw32xnl.wl%tiwai@suse.de>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Yea, I had fixed the GCAP oops in line 63 of the patch (1776 in
hda_intel.c), but apparently sent the wrong patch version.  My bad.

Thanks for the catch.

Tobin

On Tue, 2008-01-15 at 11:25 +0100, Takashi Iwai wrote:

> At Mon, 14 Jan 2008 11:44:27 -0800,
> Tobin Davis wrote:
> > 
> > I tweaked this as promised, and ran it through the checkpatch.pl utility from
> > kernel git tree.  I have tested it on my Asus Z62F laptop as well as a few
> > systems in my work environment without issue.
> > 
> > Summary:  hda_intel.c use gcap register to determine number of streams supported
> > by southbridge.
> > 
> > This patch quieries the southbridge for the number of streams supported by the
> > southbridge in most chipsets, and reads these values from the chipset directly. 
> > Most systems are hardwired for 4 streams in each direction, but newer chipsets
> > change that capability.  As a fallback, the old hardcoded method is still
> > available.
> > 
> > Signed off by Tobin Davis <tdavis@dsl-only.net>                                 
> 
> Thanks.  I applied the patch after fixing some issues.
> (It didn't even compile :)
> 
> 
> Takashi

-- 
Tobin Davis  


Criticism comes easier than craftsmanship.
		-- Zeuxis
