From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776 codec ALSA
 driver
Date: Tue, 17 Apr 2012 16:02:34 +0100
Message-ID: <20120417150234.GB22575@sirena.org.uk>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
 <1334611118-10301-4-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1334611118-10301-4-git-send-email-linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 16, 2012 at 11:18:37PM +0200, Ondrej Zary wrote:
> Needed by Philips PSC724 subdriver. The code does not contain any
> card-specific bits so it can be used by any other ALSA driver.

Same comments as the previous patch, this should be using ASoC.  In this
case the device has in fact been supported in mainline since 2.6.32...
