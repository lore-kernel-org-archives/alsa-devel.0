From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix setting update bits for
 WM8741_DACRMSB_ATTENUATION
Date: Mon, 3 Oct 2011 14:15:58 +0100
Message-ID: <20111003131558.GH3731@opensource.wolfsonmicro.com>
References: <1317611341.5065.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317611341.5065.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 11:09:01AM +0800, Axel Lin wrote:
> After checking the code and datasheet, I think what we want in the second
> snd_soc_update_bits call is to update WM8741_DACRMSB_ATTENUATION register
> instead of WM8741_DACRLSB_ATTENUATION.

Applied, thanks.
