From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Thu, 4 Nov 2010 09:43:54 -0400
Message-ID: <20101104134354.GA1201@opensource.wolfsonmicro.com>
References: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA45710384D
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 14:43:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 04, 2010 at 10:16:45AM +0200, Peter Ujfalusi wrote:

> The exisiting card->mutex can not be used for this purpose,
> since it has been taken in probe time in the
> snd_soc_instantiate_card function. Through probe calls from
> this function eventually dapm_power_widgets will be called,
> which will lead to dead lock.

Hrm.  You're right that the card mutex has issues here but just adding a
lock here leaves us with a race - whenever we make a change to widget
power we're doing a read/modify/write cycle and those aren't locked at
all.  I'm not sure if we need a lower level lock to fix that, or a
higher level lock which would make this one redundant but we ought to
think about it and make sure we've picked the right way.
