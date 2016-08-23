From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ALSA: compress: Use memdup_user()
 rather than duplicating its implementation
Date: Tue, 23 Aug 2016 09:25:48 +0530
Message-ID: <20160823035547.GS2890@localhost>
References: <566ABCD9.1060404@users.sourceforge.net>
 <7233eb00-a941-4935-dce2-7cb907272d41@users.sourceforge.net>
 <375fcd8c-ebb5-5f63-f094-347559c5b9c1@users.sourceforge.net>
 <s5hlgzpf1pk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hlgzpf1pk.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2016 at 02:05:43PM +0200, Takashi Iwai wrote:
> On Sun, 21 Aug 2016 21:43:22 +0200,
> SF Markus Elfring wrote:
> > 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 21 Aug 2016 21:02:06 +0200
> > 
> > Reuse existing functionality from memdup_user() instead of keeping
> > duplicate source code.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Applied this one, but the second patch won't be, since other people
> seem to disagree with the usefulness.

I see a v2 as well discarding patch 2 here and some other changes

-- 
~Vinod
