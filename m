From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/4] ASoC: TWL4030: Add pre-DAC digital mux
	controls
Date: Mon, 1 Dec 2008 13:37:38 +0000
Message-ID: <20081201133738.GG13758@sirena.org.uk>
References: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
	<200812011409.40695.peter.ujfalusi@nokia.com>
	<20081201124605.GE13758@sirena.org.uk>
	<200812011525.12656.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 182BB2447D
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 14:37:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812011525.12656.peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 01, 2008 at 03:25:12PM +0200, Peter Ujfalusi wrote:

> In respect of PM, there is no power control before the DACs in TWL.
> A simple chain looks like this (I2S stereo playback to HeadSet):

It's not just the DACs themselves, it's everything after the DACs too.
If DAPM thinks a DAC is powered off it won't power anything that has
inputs connected only to that DAC up.

> What I'm trying to do with the DAPM at the moment:
> Have the MUX settings tied to the outputs.
> Based on the selected input (to the output), connect it to the correct APGA 
> with power switch.
> APGA connects to the corresponding DAC with power switch.

In general you should only have user-visible switches for things that
are conditionally connected.  If the APGA can only source input from a
single DAC then let DAPM figure out if it needs to be turned on based on
the inputs and outputs.  This is often important for amplifiers which
may pass signals through unexpectedly when powered down.

> How it will affect the existing codec drivers?

The changes are all on the device registration side so for the stuff
you're doing there should be no substantial effect - the other parts
have already been merged.
