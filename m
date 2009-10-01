From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Use codec mutex in dapm_set_pga()
Date: Thu, 1 Oct 2009 13:09:31 +0100
Message-ID: <20091001120931.GF19998@rakim.wolfsonmicro.main>
References: <1254377856-5588-1-git-send-email-ext-eero.nurkkala@nokia.com>
	<20091001103714.GB14417@sirena.org.uk>
	<1254394869.2472.25.camel@eenurkka-desktop>
	<1254398184.2472.45.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3708F10391C
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:09:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254398184.2472.45.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 02:56:24PM +0300, Eero Nurkkala wrote:

> Actually, in this case: (kernel 2.6.28)

That's rather old...

> But if it didn't come from snd_soc_dapm_put_volsw(),
> but instead:
> close_delayed_work() ->
> snd_soc_dapm_stream_event() ->
> dapm_power_widgets() ->
> dapm_set_pga()
> then the codec->mutex is not taken,
> and the bug presented in the patch is out there, no?

Right, so close_delayed_work() needs to lock the card while it runs.
