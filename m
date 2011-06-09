From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2] ASoC: core - Separate out PCM operations
	into new file.
Date: Thu, 9 Jun 2011 15:08:16 +0100
Message-ID: <20110609140816.GG12865@opensource.wolfsonmicro.com>
References: <1307627153-3282-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 302E6103B81
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 16:08:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307627153-3282-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011 at 02:45:53PM +0100, Liam Girdwood wrote:
> In preparation for Dynamic PCM support (AKA DSP support).
> 
> There will be future patches that add support to allow PCMs to be dynamically
> routed to multiple DAIs at startup and also during stream runtime. This patch
> moves the ASoC core PCM operaitions into a new file called soc-pcm.c.  This will
> in simplify the ASoC core features into distinct files.

Applied, thanks.
