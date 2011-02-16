From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/9] wm8400-codec: use mfd_data instead of driver_data
Date: Wed, 16 Feb 2011 21:29:59 +0000
Message-ID: <20110216212959.GA31254@opensource.wolfsonmicro.com>
References: <1297808729-21110-1-git-send-email-dilinger@queued.net> <1297808729-21110-4-git-send-email-dilinger@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1297808729-21110-4-git-send-email-dilinger@queued.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 15, 2011 at 02:25:23PM -0800, Andres Salomon wrote:
> Use mfd_data for passing information from mfd drivers to soc
> clients.  The mfd_cell's driver_data field is being phased out.
> 
> Clients that were using driver_data now access .mfd_data
> via mfd_get_data().
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
