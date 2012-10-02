From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
Date: Tue, 02 Oct 2012 12:33:39 +0200
Message-ID: <506AC303.9080906@gmail.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com> <506A9C65.5040309@ti.com>
 <20121002093753.GU4360@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A21BB2615F2
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2012 12:33:50 +0200 (CEST)
Received: by bkue19 with SMTP id e19so4344322bku.38
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2012 03:33:47 -0700 (PDT)
In-Reply-To: <20121002093753.GU4360@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Porter, Matt" <mporter@ti.com>, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, "Nori, Sekhar" <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 02.10.2012 11:37, Mark Brown wrote:
> On Tue, Oct 02, 2012 at 10:48:53AM +0300, Peter Ujfalusi wrote:
> 
>> I also agree that ifdef is not a good solution.
>> It is better to have this information passed as device_data and via DT it can
>> be decided based on the compatible property for the device.
> 
> That's not really the problem here - the problem is that the APIs used
> to get the SRAM are DaVinci only so it's not possible to build on OMAP
> or other platforms.  The SRAM code needs to move to a standard API.

What about following Matt Porter's idea and ignore the SRAM code
entirely and port the entire PCM code to generic dmaengine code first?
The EDMA driver needs to learn support for cyclic DMA for that, and I
might give that a try in near future.

Later on, the SRAM ping-pong code can get added back using genalloc
functions, as Sekhar proposed. That needs to be done by someone who has
access to a Davinci board though, I only have a AM33xx/OMAP here.


Daniel
