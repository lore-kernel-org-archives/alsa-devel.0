From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Fix use-after-free in wm2000 - don't
 release_firmware() twice
Date: Tue, 24 Jan 2012 11:34:49 +0000
Message-ID: <20120124113449.GA14888@opensource.wolfsonmicro.com>
References: <alpine.LNX.2.00.1201232224250.8772@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD6B524570
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 12:34:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1201232224250.8772@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Ian Lartey <ian@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 23, 2012 at 10:28:44PM +0100, Jesper Juhl wrote:
> In wm2000_i2c_probe(), if we take the true branch in

Applied, thanks.
