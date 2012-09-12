From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] [v2] ASoC: fsl: use
 snd_soc_register_card to register the card
Date: Wed, 12 Sep 2012 09:32:13 +0800
Message-ID: <20120912013211.GB9162@opensource.wolfsonmicro.com>
References: <1347380607-1564-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 159DE2615E3
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 03:32:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347380607-1564-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 11, 2012 at 11:23:26AM -0500, Timur Tabi wrote:
> Use snd_soc_register_card() instead of platform_device_alloc("soc-audio")
> to register the sound card from the machine drivers.
> 
> Although platform_device_alloc is officially deprecated, it is still used
> by several other drivers.  Unfortunately, something is broken somewhere
> and the Freescale drivers don't register properly when using it.  Since
> we need to transition to snd_soc_register_card() anyway, this fixes the
> problem and updates our code at the same time.

I did explain what's wrong here - it's the use of driver data.
