From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 04/17] MFD: twl6040: Fix power on GPIO
 handling
Date: Mon, 19 Sep 2011 23:16:19 +0100
Message-ID: <20110919221619.GC23179@opensource.wolfsonmicro.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
 <1316090379-30760-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316090379-30760-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 03:39:26PM +0300, Peter Ujfalusi wrote:
> Avoid requesting the audpwron gpio in case of ES1.0
> revision.
> In the past we requested the gpio, but we did not
> free it up, since we made the check for the revision
> later. This results later checks for gpio validity to
> fail, leaving the gpio reserved (even after the driver
> has been removed).

Applied, thanks.
