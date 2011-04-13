From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: Call snd_soc_new_widgets() after
 registering cards DAPM widgets
Date: Tue, 12 Apr 2011 17:38:47 -0700
Message-ID: <20110413003847.GC24267@opensource.wolfsonmicro.com>
References: <1302629465-21315-1-git-send-email-lars@metafoo.de>
	<1302629465-21315-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60A0A103800
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 02:38:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302629465-21315-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 12, 2011 at 07:31:02PM +0200, Lars-Peter Clausen wrote:
> After registering new DAPM widgets nd_soc_new_widgets() must be called,
> otherwise DAPM for those new widgets will not work.
> 
> snd_soc_new_widgets() is placed after the card late_probe call, so cards
> can register new DAPM widgets in there.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

There's already a call for this in post_component_init(), it just needs
to be moved later in the sequence now.
