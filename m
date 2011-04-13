From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: Call snd_soc_new_widgets() after
 registering cards DAPM widgets
Date: Wed, 13 Apr 2011 10:32:49 -0700
Message-ID: <20110413173249.GC18008@opensource.wolfsonmicro.com>
References: <1302629465-21315-1-git-send-email-lars@metafoo.de>
	<1302629465-21315-2-git-send-email-lars@metafoo.de>
	<20110413003847.GC24267@opensource.wolfsonmicro.com>
	<4DA597E3.807@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 92449243EC
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 19:32:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DA597E3.807@metafoo.de>
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

On Wed, Apr 13, 2011 at 02:32:35PM +0200, Lars-Peter Clausen wrote:

> But snd_soc_dapm_new_widgets also calls dapm_power_widgets which operates on
> the passed dapm_context, will it be without any effect on the DAPM context,
> when it is called on a newly allocated context?

Yup.

> Otherwise I would say call snd_soc_dapm_new_widgets once for the cards
> dapm_context and snd_soc_dapm_sync for each codec context.

There's no point in repeatedly syncing - it may cause audible issues if
we power things off due to incomplete information.  If the sync isn't
propagating over the entire system we should fix that.
