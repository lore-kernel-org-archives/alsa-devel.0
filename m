From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm9081: Don't write WM9081_BIAS_ENA bit to
 WM9081_VMID_CONTROL register
Date: Tue, 8 Nov 2011 15:38:56 +0000
Message-ID: <20111108153856.GD5632@opensource.wolfsonmicro.com>
References: <1320475639.8360.1.camel@phoenix>
 <1320475761.8360.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320475761.8360.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 05, 2011 at 02:49:21PM +0800, Axel Lin wrote:
> WM9081_BIAS_ENA is the bit[1] of WM9081_BIAS_CONTROL_1 register (05h).
> Current code incorrectly write it to WM9081_VMID_CONTROL(04h) register.

This one seems to work happily - applied, thanks!
