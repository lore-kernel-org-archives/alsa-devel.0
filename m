From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] MIPS/sound: DB1200 audio support depends on
 MIPS arch.
Date: Thu, 10 Nov 2011 11:36:38 +0000
Message-ID: <20111110113637.GE29931@opensource.wolfsonmicro.com>
References: <20111110122241.eed1e785e4c015a51b9ef585@canb.auug.org.au>
 <1320924059-4142-1-git-send-email-manuel.lauss@googlemail.com>
 <20111110113448.GF21630@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111110113448.GF21630@sirena.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 11:34:48AM +0000, Mark Brown wrote:
> On Thu, Nov 10, 2011 at 12:20:59PM +0100, Manuel Lauss wrote:
> > DB1200 audio support should only be visible if MIPS/Alchemy arch is
> > selected.  Fixes an x86-allmodconfig build failure in linux-next.
> 
> Applied but *always* CC maintainers on patches.

Sorry, actually not applied as it's not against mainline - please
resubmit against mainline.
