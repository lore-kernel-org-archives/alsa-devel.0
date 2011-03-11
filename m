From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC] arm: mini2440: Fix uda134x codec
	problem.
Date: Fri, 11 Mar 2011 12:17:04 +0000
Message-ID: <20110311121704.GF1760@opensource.wolfsonmicro.com>
References: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DAEA8244B0
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 13:17:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 09, 2011 at 09:46:20PM +0100, Marek Belisko wrote:
> ASoC audio for mini2440 platform in current kenrel doesn't work.
> First problem is samsung_asoc_dma device is missing in initialization.
> Next problem is with codec. Codec is initialized but never probed

Applied, thanks.  With changes like this you should really split things
up into a small patch series - if you ever find yourself writing
"Next problem..." or "Also..." then going on to describe a separate
change that's a sign that you should be writing a separate patch.
