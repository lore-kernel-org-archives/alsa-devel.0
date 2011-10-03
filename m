From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Staticise simtec_audio_resume()
Date: Mon, 3 Oct 2011 14:16:36 +0100
Message-ID: <20111003131636.GJ3731@opensource.wolfsonmicro.com>
References: <1317629512.2820.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317629512.2820.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, Ben Dooks <ben@simtec.co.uk>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 04:11:52PM +0800, Axel Lin wrote:
> It is exported via resume callback of struct dev_pm_ops rather than referenced
> directly and so should be staticised.

Applied, thanks.
