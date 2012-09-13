From: Timur Tabi <timur@freescale.com>
Subject: Re: Need help with WM8960
Date: Thu, 13 Sep 2012 09:43:00 -0500
Message-ID: <5051F0F4.5090205@freescale.com>
References: <5051160C.2010802@freescale.com>
 <20120913024245.GA4467@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id AC5BF2625E2
 for <Alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 16:43:10 +0200 (CEST)
In-Reply-To: <20120913024245.GA4467@opensource.wolfsonmicro.com>
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> So, it should be fairly clear from the code that its looking for a
> struct wm8960_data.  You can actually leave this totally blank but it's
> important that the capless setting is correct one way or another - you
> need to look at the schematic and check to see if there are capacitors
> on the output not.

There are 120uF capacitors connected to HP_L and HP_R.  Unfortunately, I
can't quite figure out whether I need platform data or not.

Also, how do I get the platform data to the codec driver?  Do I need to
create some arch code that reads the device tree properties and parses
them into a wm8960_data object, and then (somehow) injects that into the
wm8960 driver?

-- 
Timur Tabi
Linux kernel developer at Freescale
