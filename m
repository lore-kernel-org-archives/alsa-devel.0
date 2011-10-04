From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] mfd: Add WM1811 support
Date: Tue, 4 Oct 2011 11:58:27 +0100
Message-ID: <20111004105827.GF3250@opensource.wolfsonmicro.com>
References: <1317149407-27635-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20111004101902.GV4118@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111004101902.GV4118@sortiz-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 12:19:02PM +0200, Samuel Ortiz wrote:
> On Tue, Sep 27, 2011 at 07:50:05PM +0100, Mark Brown wrote:

> > Due to the ASoC cross dependencies it seems like it'll be easier to
> > merge this via ASoC - Samuel, does this make sense to you?

> It does.
> Liam, please add my:
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Hrm, actually there's a bit of overlap with "mfd: Add more checks for
WM8994 being active during suspend" from your tree.  It's only a one
line change (adding the WM1811 device ID) so I don't see any problem
with just applying that during -rc, or I could cherry-pick that change
over now?  Anyway, I've applied the patch just now.
