From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/2] ASoC: core: Option to reorder widget
	power sequence
Date: Thu, 2 Dec 2010 13:05:16 +0000
Message-ID: <20101202130516.GC859@rakim.wolfsonmicro.main>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2AE47103A73
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 14:05:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Thu, Dec 02, 2010 at 02:03:08PM +0200, Peter Ujfalusi wrote:

> The first patch implements a new flag for the core to reorder the sequence to:
> 1. User enable the bypass
> 2. The bit enabling the bypass got changed.
> 3. DAPM power up sequence takes place
> 3.1 codec DAPM widgets got powered on, codec is enabled
> 3.2 External speaker enabled

Is this OK on power down?  On power down we'll adjust the input path to
the widget then power down the output path so noise introduced by
switching away from the current source will get amplified.  Keeping the
current sequence for power down seems more consistent with what you're
trying to do.

Looking at the mailing list archive the issues previously were partly
things being obscured by this being in terms of the then very
non-standard TWL4030 code and also this:

| I think there's something useful we can do with DAPM here (independantly
| of anything in TWL4030), probably involving splitting up the routing
| change walk to run power down first and then power up but the current
| patch feels like it's going to cause at least as many problems as it
| solves.

We've now got the split power down/power up sequences - ideally what
we'd be able to do here is get the route update to happen in between the
power down and power up sequences.
