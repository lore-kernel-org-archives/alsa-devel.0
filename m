From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 05/17] ASoC: twl6040: Chip initialization
 cleanup
Date: Mon, 19 Sep 2011 23:16:32 +0100
Message-ID: <20110919221632.GD23179@opensource.wolfsonmicro.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
 <1316090379-30760-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316090379-30760-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 03:39:27PM +0300, Peter Ujfalusi wrote:
> There is no need to write to the vio registers at probe time, since most
> them either read only, or shared with MFD or not used.
> On the other hand it is a good idea to updated the ASICREV register in
> the cache at this time.

Applied, thanks.
