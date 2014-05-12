From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Broken outmixer_event function in wm8400/wm8990/wm8991
Date: Mon, 12 May 2014 10:19:26 +0200
Message-ID: <5370840E.10009@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 98AF6264EFF
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 10:19:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

I was looking at the drivers that were using the SND_SOC_DAPM_PRE_REG event 
and I noticed that the outmixer_event function for the wm8400, wm8990 and 
wm8991 is broken. They do a switch statement to determine which kcontrol 
cause the event in the form of 'switch(kcontrol->private_value) { case (REG 
| (SHIFT << 8)): ...'. Long long time ago we used to store the register and 
the shift in the same integer which was stored in private_value. But this 
was changed in commit 4eaa9819 ("ALSA: ASoC: Convert bitfields in ASoC into 
full int width"). This was long before the wm8400 and wm8991 drivers were 
merged and just a month after the wm8990 driver was merged. So these 
functions have been dead code pretty much for as long as they existed. Do 
you want to fix this up? If not I'm going to send a patch that removes the 
functions. If you want to fix this up, this should be re-implemented as a 
custom put handler for the kcontrols rather than a event callback, which 
checks whether the change is valid before doing any DAPM changes. The event 
callback runs in the middle of the DAPM sequence, so half of the changes 
will already have been applied before the check is made whether the change 
should be done or not.

- Lars
