From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm8940: Fix mask for setting BCLKDIV
Date: Thu, 27 Oct 2011 12:00:48 +0200
Message-ID: <20111027100048.GC22369@opensource.wolfsonmicro.com>
References: <1319704053.2673.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319704053.2673.0.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Paulson-Ellis <chris@edesix.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 27, 2011 at 04:27:33PM +0800, Axel Lin wrote:
> According to the datasheet:
> BCLK is controlled by BIT[4:2] of WM8940_CLOCK(06h) register.

Applied, thanks.
