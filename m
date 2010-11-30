From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix compile error for s6000-i2s.c by adding a
 missing ';' character
Date: Tue, 30 Nov 2010 11:24:47 +0000
Message-ID: <20101130112447.GD7403@rakim.wolfsonmicro.main>
References: <1291081553.18485.3.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291081553.18485.3.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, dg@emlix.com, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 30, 2010 at 09:45:53AM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> I don't have toolchain to compile s6000, I'm not able to put the error message in the commit log.
> But I know this patch indeed fixes a compile error.

Daniel already posted the same patch (and a bunch of others), just
waiting for Liam's review.  The S6000 port as a whole doesn't compile
anyway at the minute (due to arch/ side issues).
