From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC:kirkwood: Don't raise an error when no DAI format
Date: Sun, 28 Sep 2014 16:12:07 +0100
Message-ID: <20140928151207.GI5182@n2100.arm.linux.org.uk>
References: <20140928150342.CC21B786A1D@smtpfb1-g21.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140928150342.CC21B786A1D@smtpfb1-g21.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 28, 2014 at 04:19:27PM +0200, Jean-Francois Moine wrote:
> The two DAIs of the kirkwood controller have a unique PCM format.
> 
> The simple-card sets the audio hardware definitions of all CPU DAIs.
> The PCM format is defined only when it is present in the DT.
> 
> This patch prevents the controller to raise an error when
> the DT audio card definition by the simple card contains the PCM
> format of one CPU DAI only.

I think this is a silly idea - why should every driver have additional code
to detect when it's called to do thing.  Why doesn't the simple card code
always pass the required format?

Looking at other drivers, no one else does this; they all appear to require
the proper format to be specified.

What some drivers do (eg, omap-mcbsp.c) is to block set_fmt when the
DAI is already in use - setting a flag "configured" in hw_params, and
clearing it in shutdown.  Maybe following this will solve your problem.

In any case, random drivers doing stuff differently without reason is
really not a good idea.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
