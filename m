From: Ondrej Zary <linux@rainbow-software.org>
Subject: PNP_DRIVER_RES_DISABLE breaks swsusp at least with snd_cs4236
Date: Wed, 9 Jan 2008 23:43:47 +0100
Message-ID: <200801092343.48726.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757178AbYAIWo2@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
as hibernation (swsusp) started to work with my CPU, I found that my Turtle 
Beach Malibu stops working after resume from hibernation. It's caused by fact 
that the card is not enabled on the pnp layer during resume - and thus card 
registers are inaccessible (reads return FFs, writes go nowhere).

During resume, pnp_bus_resume() in drivers/pnp/driver.c is called for each pnp 
device. This function calls pnp_start_dev() only when the 
PNP_DRIVER_RES_DO_NOT_CHANGE bit is NOT seting pnp_drv->flags. But the cs4236 
driver in sound/isa/cs423x/cs4236.c explicitly sets the .flags to 
PNP_DRIVER_RES_DISABLE - it's value is 3 and that includes 
PNP_DRIVER_RES_DO_NOT_CHANGE bit.

The same .flags value is present in many of the ALSA ISA sound drivers.

Removing that .flags line caused this to appear inlog when loading snd_cs4236 
module:
CS4236+ WSS PnP manual resources are invalid, using auto config
CS4236+ CTRL PnP manual resources are invalid, using auto config
CS4236+ MPU401 PnP manual resources are invalid, using auto config

and the sound now works after resume!

So the question is: why is this line present?

Is this a bug? What's the correct fix?

-- 
Ondrej Zary
