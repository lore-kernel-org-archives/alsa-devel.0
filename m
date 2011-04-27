From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: One HW register bit affecting two paths
Date: Wed, 27 Apr 2011 10:08:29 +0100
Message-ID: <20110427090829.GB16666@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04973BBD1E@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 858761038BA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 11:08:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04973BBD1E@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 26, 2011 at 11:47:43AM -0700, Stephen Warren wrote:

> When alsamixer sets one of these controls, both the Left ADC Input and
> Right ADC Input controls read back with the value that was set, since
> they both read from the same register bit. However, if only one of the
> controls is actually manipulated, then only the paths associated with
> that single widget are updated by dapm_mux_update_power. To solve this,
> the user must currently also toggle the other control back to the
> original value and then to the new value in order to update the paths.

Right, I had assumed we must've fixed this at some point in the past
without me noticing when you sent the original patch as I'd expected
you'd have seen issues in your testing.

> Solution 2: Sharing controls:

This seems the best solution to me.

> Solution 3: Stereo widgets:

The problem I see with this one is that someone's doubtless going to
come up with something other than stereo controls, for example a single
control that affects six channel surround sound data streams.  Sharing
the control seems like it scales up better to odd combinations of
channels.
