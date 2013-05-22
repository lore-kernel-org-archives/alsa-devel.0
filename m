From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] sound/soc/fsl: remove leftover release_mem_region
Date: Wed, 22 May 2013 18:04:00 +0200
Message-ID: <20130522160357.GA2917@katana>
References: <1369228886-3527-1-git-send-email-wsa@the-dreams.de>
 <1369228886-3527-3-git-send-email-wsa@the-dreams.de>
 <20130522155628.GK1627@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130522155628.GK1627@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 22, 2013 at 10:56:28AM -0500, Mark Brown wrote:
> On Wed, May 22, 2013 at 03:21:26PM +0200, Wolfram Sang wrote:
> > When converting this driver to devm_ioremap_resource, the removal of this now
> > unneeded function has been forgotten.
> 
> This doesn't apply against current code, can you please regenerate
> against topic/fsl or mainline?

? Works fine against v3.10-rc2 here. Or is mainline v3.9 for you?
