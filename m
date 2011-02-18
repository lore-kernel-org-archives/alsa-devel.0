From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/29] wm8400-codec: use mfd_data instead
 of driver_data (v2)
Date: Thu, 17 Feb 2011 19:51:34 -0800
Message-ID: <20110218035133.GA6069@opensource.wolfsonmicro.com>
References: <1297998456-7615-1-git-send-email-dilinger@queued.net>
	<1297998456-7615-21-git-send-email-dilinger@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1D1D243F1
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 04:51:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297998456-7615-21-git-send-email-dilinger@queued.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andres Salomon <dilinger@queued.net>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 17, 2011 at 07:07:27PM -0800, Andres Salomon wrote:
> Use mfd_data for passing information from mfd drivers to soc
> clients.  The mfd_cell's driver_data field is being phased out.
> 
> Clients that were using driver_data now access .mfd_data
> via mfd_get_data().
> 
> v2: add some missing mfd/core.h includes.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
