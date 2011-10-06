From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Replace remaining use of *_volsw_2r with *_volsw
Date: Thu, 6 Oct 2011 11:16:59 +0100
Message-ID: <20111006101658.GC14518@opensource.wolfsonmicro.com>
References: <20111006132204.29c84ed7349daf8c4aa39c3b@canb.auug.org.au>
 <1317884352-17067-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317884352-17067-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Liam Girdwood <lrg@ti.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 06, 2011 at 09:59:12AM +0300, Peter Ujfalusi wrote:
> The snd_soc_*_volsw_2r functionality has been merged to
> *volsw callbacks.
> Few places still used the get, or put variant of volsw_2r,
> replace those with the corresponding *_volsw.

Applied, thanks.
