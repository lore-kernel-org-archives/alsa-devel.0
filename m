From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 01/17] MFD: twl6040: Remove global pointer
 for platform_device
Date: Mon, 19 Sep 2011 23:17:05 +0100
Message-ID: <20110919221705.GE23179@opensource.wolfsonmicro.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
 <1316090379-30760-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316090379-30760-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 03:39:23PM +0300, Peter Ujfalusi wrote:
> There is no need to keep global pointer for the platform
> device, since it is only used for dev_* prints, and the
> device pointer available within the twl6040 structure.

Applied, thanks.
