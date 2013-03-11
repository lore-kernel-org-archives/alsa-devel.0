From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Add ALSA driver to Buildroot image or add / load
 it after booting the image
Date: Sun, 10 Mar 2013 17:20:22 -0700
Message-ID: <513D2346.9010306@gmail.com>
References: <CAMFO430h8z+gNbkjq0WHAbRQ48iLDtfvknEpnNAjuRKBgwzXSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f42.google.com (mail-da0-f42.google.com
 [209.85.210.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 005EF2651B7
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 01:20:40 +0100 (CET)
Received: by mail-da0-f42.google.com with SMTP id n15so633158dad.1
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 17:20:39 -0700 (PDT)
In-Reply-To: <CAMFO430h8z+gNbkjq0WHAbRQ48iLDtfvknEpnNAjuRKBgwzXSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Marc,

On 03/10/2013 01:19 PM, Marc Schultz wrote:
> Hey ALSA-Devel community,
>
> I'm successfully booting a Buildroot made Linux image on my board.
> This board has an Cirrus Logic CS4270 sound chip and now I want to
> activate the specific sound card driver for it. Is there a good way to
> put the CS4270 driver files into the Linux Kernel folders of Buildroot
> to get them compressed into the Linux image or do I have to go one of
> the following ways after booting the image on my target hardware?
>
> http://www.alsa-project.org/main/index.php/Matrix:Module-cs4270
>
> http://www.alsa-project.org/main/index.php/Driver_Compilation)
>
> Do you have a good workflow for me to get this thing working?

Long story short... making this work is /very/ board-specific.  If 
someone hasn't already done the work for your specific board -- doing 
the work isn't trivial.  It's not like PC's where the sound card is on 
the PCI bus and you simply have to load the driver module.  Someone 
experienced in ASoC and board bring-up would spend anywhere from 2 days 
to a week to do this board-specific integration work.

If you're starting from less, then the lower estimate is "weeks."

So, if you're up for the journey... here's some starting points...

Start here:  Documentation/sound/alsa/soc/*

One example of this kind of integration can be found for the BeagleBoard:

         arch/arm/mach-omap2/board-omap3beagle.c (board file)
         sound/soc/omap/omap-twl4030.c (ASoC machine driver)

Each component will need board-specific platform data added to the board 
file (or device tree), and a machine driver will be needed to glue 
together the audio components (CPU platform + CPU Driver + Audio Codec) 
into a "sound card".

-gabriel
