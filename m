From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: txx9: Add __exit_p at necessary place
Date: Mon, 3 Oct 2011 14:15:49 +0100
Message-ID: <20111003131549.GG3731@opensource.wolfsonmicro.com>
References: <1317605912.2588.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317605912.2588.0.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 09:38:32AM +0800, Axel Lin wrote:
> We have __exit annotation for txx9aclc_generic_remove(),
> thus add __devexit_p to wrap it.

Applied, thanks.
