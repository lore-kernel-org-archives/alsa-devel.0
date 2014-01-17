From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8804: Allow control of master clock divider in
	PLL generation
Date: Fri, 17 Jan 2014 09:48:19 +0000
Message-ID: <20140117094819.GA2826@opensource.wolfsonmicro.com>
References: <alpine.DEB.2.02.1401142030110.23472@parallels-Parallels-Virtual-Platform>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1401142030110.23472@parallels-Parallels-Virtual-Platform>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Matuschek <daniel@matuschek.net>
Cc: alsa-devel@alsa-project.org, Dimitris.Papastamos@wolfsonmicro.com, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, perex@perex.cz, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 14, 2014 at 08:34:10PM +0100, Daniel Matuschek wrote:
> WM8804 can run with PLL frequencies of 256xfs and 128xfs for
> most sample rates. At 192kHz only 128xfs is supported. The
> existing driver selects 128xfs automatically for some lower
> samples rates. By using an additional mclk_div divider, it
> is now possible to control the behaviour. This allows using
> 256xfs PLL frequency on all sample rates up to 96kHz. It
> should allow lower jitter and better signal quality. The
> behavior has to be controlled by the sound card driver,
> because some sample frequency share the same setting. e.g.
> 192kHz and 96kHz use 24.576MHz master clock. The only
> difference is the MCLK divider.
> 
> Signed-off-by: Daniel Matuschek <daniel@matuschek.net>

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>


Sorry about the slight delay travelling with limited internet at
the mo.

Thanks,
Charles
