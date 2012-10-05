From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH 0/2] Convert davinci ASoC to genalloc SRAM
Date: Fri, 5 Oct 2012 17:34:54 -0400
Message-ID: <20121005213454.GO11149@beef>
References: <1349345745-10584-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CBBDF2650D8
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 23:34:20 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c10so4789493ieb.38
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2012 14:34:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349345745-10584-1-git-send-email-mporter@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, gururaja.hebbar@ti.com, Sekhar Nori <nsekhar@ti.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Ben Gardiner <bengardiner@nanometrics.ca>, Alsa Devel List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 04, 2012 at 06:15:43AM -0400, Matt Porter wrote:
> This series converts davinci ASoC to use genalloc and enables
> that support on DA850. It applies on top of the uio_pruss/genalloc
> series [1] which allows DaVinci to provide a gen_pool via pdata
> for driver use.
> 
> I've tested this on the AM180x EVM. Note that prior to this,
> the SRAM paths in the driver were completely unused. I've only
> enabled ping-pong buffering on the platform I can test as it's
> best to allow those with DM644x and similar platforms to set the
> playback/capture sram size to something that's known to work
> for them.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg198854.html

Tested again on top of v4 of the uio_pruss/genalloc series
http://www.spinics.net/lists/arm-kernel/msg199255.html
on next-20121005 since there's some conflicts falling out of
of arm-soc and asoc/sound header move patches on mainline 
atm.

-Matt
