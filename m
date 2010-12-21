From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add optional pointer to machine
 audio routes to snd_soc_card
Date: Tue, 21 Dec 2010 16:29:40 +0000
Message-ID: <20101221162940.GB21871@opensource.wolfsonmicro.com>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
	<201012201322.49437.peter.ujfalusi@nokia.com>
	<20101220120201.GB26706@rakim.wolfsonmicro.main>
	<201012210942.15878.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26C8124553
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 17:29:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012210942.15878.peter.ujfalusi@nokia.com>
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

On Tue, Dec 21, 2010 at 09:42:15AM +0200, Peter Ujfalusi wrote:
> On Monday 20 December 2010 14:02:01 ext Mark Brown wrote:

> > I don't see anything different here with multi-component?  The general
> > idea is that by default a floating output or input should be treated as
> > connected.

> As I said, it is another issue. It is just that for me it is more logical to 
> treat the floating inputs/outputws as not connected. It is not that big problem, 
> since from machine driver I can mark the unsused pins as nc.

The reason it's this way round is that this way we default to allowing
audio to pass through the system.  Generally when people are bringing up
a new system they're much more worried about the hardware being at all
functional than power optimisation - in many systems power isn't a
concern at all.  This way there's less obstacles to getting audio up,
and people can go through and optimise later if they need to.

> > > Now if you enable the bypass on codec2, it shall not bring up the codec2
> > > bias, since we do not have full route.

> > This isn't abundantly clear - there may potentially be analogue
> > interface issues if two devices which aren't connected aren't both
> > powered up and down together.  Robust system design should avoid these
> > issues but I'd prefer it if software were conservative and at the very
> > least always had an option to ensure everything is powered on at once.

> If you look at things in card level, I still think that in the case I have 
> described the codec2 shall not change bias level.
> If it does before the playback starts on the codec1, we might end up hearing the 
> pop from codec1 powering up, since the codec2 path has been already up (with the 
> speaker enabled).

Like I say if the speaker is unconditionally enabled DAPM will keep the
speaker output path up anyway so it's going to be up regardless of
anything else.  If the bias management functions are enabling output
drivers they're doing something wrong anyway.
