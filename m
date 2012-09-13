From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: wm8960: Support shared LRCLK
Date: Thu, 13 Sep 2012 17:33:16 -0500
Message-ID: <50525F2C.4080607@freescale.com>
References: <1347508108-24248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <50522A5A.10006@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 by alsa0.perex.cz (Postfix) with ESMTP id C95B0262608
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 00:33:23 +0200 (CEST)
In-Reply-To: <50522A5A.10006@freescale.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
>> > +		ret = regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2,
>> > +					 0x4, 0x4);
> This is not enough to get the codec working on my board.
> 
> What is the actual mechanism that enables the clock on the WM8960?  I
> don't have an oscilloscope, not it's hard to tell what the hardware is
> actually doing.  However, I suspect that the LRCLK is not running.

Never mind, it works now.  I understand that the DAPM controls need to be
enabled for the clocks to actually run, as described here:

http://www.alsa-project.org/main/index.php/DAPM#When_things_don.27t_work

On the #alsa-soc, I was told that I could force on the control in my
machine driver.  Specifically, I was told this:

	"in your board file you can always make an always on output in the DAPM map"

Can you tell me how to do this?  Is there an example?  I don't want to
have to rely on user-space configuration to get playback to work.

-- 
Timur Tabi
Linux kernel developer at Freescale
