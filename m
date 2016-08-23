From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: ALSA: compress: Memset timestamp structure to zero.
Date: Tue, 23 Aug 2016 21:31:00 +0530
Message-ID: <20160823160100.GZ2890@localhost>
References: <1471959637-18163-1-git-send-email-luis.henriques@canonical.com>
 <1471959637-18163-2-git-send-email-luis.henriques@canonical.com>
 <s5hwpj761kt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hwpj761kt.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Luis Henriques <luis.henriques@canonical.com>, Krishnankutty Kolathappilly <kkolat@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 23, 2016 at 03:45:38PM +0200, Takashi Iwai wrote:
> On Tue, 23 Aug 2016 15:40:37 +0200,
> Luis Henriques wrote:
> > 
> > From: Krishnankutty Kolathappilly <kkolat@codeaurora.org>
> > 
> > snd_compr_tstamp is initialized using aggregate initialization
> > that does not zero out the padded bytes. Initialize timestamp
> > structure to zero using memset to avoid this.
> > 
> > CRs-Fixed: 568717
> > Change-Id: I7a7d188705161f06201f1a1f2945bb6acd633d5d
> > Signed-off-by: Krishnankutty Kolathappilly <kkolat@codeaurora.org>
> 
> Vinod already informed me about this, and we agreed that it doesn't
> make any sense.  What does it really fix?

Btw is there a process to make this CVE invalidated?

-- 
~Vinod
