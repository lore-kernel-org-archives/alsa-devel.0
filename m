From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Change RT wq to singlethread wq
Date: Thu, 26 Nov 2009 15:47:46 +0000
Message-ID: <20091126154746.GA10674@rakim.wolfsonmicro.main>
References: <1259236511-25805-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1259236511-25805-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-next-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, sfr@canb.auug.org.au, tj@kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 26, 2009 at 01:55:11PM +0200, Peter Ujfalusi wrote:
> RT workqueue is going away in the near future, replace it with
> singlethread wq for now, which is still supported.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
