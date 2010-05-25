From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Tue, 25 May 2010 12:26:50 +1000
Message-ID: <20100525022646.GA18030@www.longlandclan.yi.org>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25])
	by alsa0.perex.cz (Postfix) with ESMTP id DD78A103880
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 04:26:54 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OGjr1-0000Wv-SK
	for alsa-devel@alsa-project.org; Tue, 25 May 2010 12:26:52 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OGjr1-0000Wg-0n
	for alsa-devel@alsa-project.org; Tue, 25 May 2010 12:26:51 +1000
Content-Disposition: inline
In-Reply-To: <20100525004126.GA10968@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Well, an update on the progress.
On Tue, May 25, 2010 at 10:41:33AM +1000, Stuart Longland wrote:
> On Mon, May 24, 2010 at 11:49:16AM +0100, Liam Girdwood wrote:
> > On Mon, 2010-05-24 at 17:49 +1000, Stuart Longland wrote:
> > > Now this compiles... but when I go to load it; one of two things
> > > happens... either practically nothing (at this stage; no modules are
> > > loaded prior to calling modprobe):
> > > 
> > 
> > It does sound like you have some memory corruption somewhere. Can you
> > rule out your new CODEC driver by replacing it with another CODEC driver
> > (ads117x.c is a very simple example).
> > 
> > Liam
> 
> Well, the plot thickens... I tried two things.
> 
> (1) I swapped my 'AIC3204 driver for the 'AIC3X driver that my driver
> was originally based upon, and retried loading the driver.  No blowups,
> but now devices appearing in /proc/asound/cards or /proc/asound/devices.

I've pulled down the ASoC tree (via HTTP; git protocol seems blocked at
my workplace) from the Wolfson Micro site and merged that into a new
branch.  In it there was another implementation of a machine driver for
i.MX, so I tried playing with that instead.  I noticed there was liberal
use of pr_debug... googling told me how to enable it, and so I did it
for each file in the ASoC tree.

I then noticed the following message:

Registered platform 'imx-audio'
soc-audio soc-audio: DAI (null) not registered

Ah ha!  Progress... but which DAI??  I made the following changes to
soc-core:

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 998569d..95e5894 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1147,8 +1147,10 @@ static void snd_soc_instantiate_card(struct
snd_soc_card *card)
                                break;
                        }
                if (!found) {
-                       dev_dbg(card->dev, "DAI %s not registered\n",
-                               card->dai_link[i].cpu_dai->name);
+                       dev_dbg(card->dev, "CPU DAI %s not registered "
+                               "(card %p dai_link %d cpu_dai=%p)\n",
+                               card->dai_link[i].cpu_dai->name,
+                               card, i, card->dai_link[i].cpu_dai );
                        return;
                }
 
@@ -1176,8 +1178,10 @@ static void snd_soc_instantiate_card(struct
snd_soc_card *card)
                                        break;
                                }
                        if (!found) {
-                               dev_dbg(card->dev, "DAI %s not
                                registered\n",
-                                       card->dai_link[i].codec_dai->name);
+                               dev_dbg(card->dev, "CODEC DAI %s not
registered "
+                                       "(card %p dai_link %d
codec_dai=%p)\n",
+
card->dai_link[i].codec_dai->name,
+                                       card, i,
card->dai_link[i].codec_dai);
                                return;
                        }
                }

If there's any interest, I can format that as a patch and submit it...
but it did help in telling me what DAI was not registered.  I now get:

Registered platform 'imx-audio'
soc-audio soc-audio: CPU DAI (null) not registered (card bf07d568
dai_link 0 cpu_dai=bf075f78)
soc-audio soc-audio: Registered card 'JEM3'

Oookay then, it's the i.MX driver.  I notice in the i.MX driver they do
their registration inside the imx_ssi_probe (line 674)... so evidently
that is not getting called.  How does one trigger the kernel to probe
i.MX SSI?  Is there some special function call or initialisation thing
that I've missed?
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
