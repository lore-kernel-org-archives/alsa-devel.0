From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix race condition in widgets
 power list creation
Date: Tue, 18 Jan 2011 11:39:56 +0000
Message-ID: <20110118113956.GE26498@opensource.wolfsonmicro.com>
References: <1295318127-17968-1-git-send-email-misael.lopez@ti.com>
	<20110118103954.GA26498@opensource.wolfsonmicro.com>
	<4D357B09.70505@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01DE6103813
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 12:40:33 +0100 (CET)
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 9076D3B438E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 11:40:32 +0000 (GMT)
Resent-Message-ID: <20110118114031.GF26498@opensource.wolfsonmicro.com>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <4D357B09.70505@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-deve@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 01:35:37PM +0200, Peter Ujfalusi wrote:

> Hmm, the patch looks quite similar to the patch I've sent back in November:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/033362.html

My thought exactly.

> On 01/18/11 12:39, ext Mark Brown wrote:

> > This needs a bit more analysis - why are we getting multiple
> > simultaneous calls to dapm_power_widgets() and is that itself safe?  The
> > ASoC locking model has always been to have a big lock around the entire
> > card rather than to lock subcomponents, and for example this isn't going
> > to make sure we're consistent with register map accesses from other
> > parts of the code.

> As far as I have traced back than, it was due to the use of dapm_sync in
> machine drivers. For me it looked that all other paths were satisfactory
> protected.
> In my case  the use of SOC_DAPM_PIN_SWITCH() instead of the custom call
> fixed the race (since this will take a card mutex, AFAIK).

I *suspect* that we're in a similar case and either the locking has been
broken by the multi-component stuff or there's other cases that need
protection, probably the jack detection code.

> PS: I might received this mail unintentionally, since I was not on the
> TO/CC, and alsa-devel neither.

> Should alsa-devel be on the CC?

Yes, I bounced on the second copy - Misael had sent two copies of the
mail, one omitting the CC, and I'd replied to the first one before I saw
the second.
