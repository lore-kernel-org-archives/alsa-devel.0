From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_hubs: Remove unneeded count variable in
 wait_for_dc_servo
Date: Fri, 7 Oct 2011 11:13:50 +0100
Message-ID: <20111007101350.GC19080@opensource.wolfsonmicro.com>
References: <1317974065.16830.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317974065.16830.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 03:54:25PM +0800, Axel Lin wrote:
> The count variable is not required, decrement timeout in the while loop
> can achieve the same effect.

Having the count original timeout there is helpful when debugging and
there's not going to be any meaningful cost from having both.
