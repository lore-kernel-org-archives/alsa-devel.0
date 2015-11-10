From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC Sound Driver I2S over LPE,
 Intel Baytrail SoC. MinnowBoard Max
Date: Tue, 10 Nov 2015 12:53:56 -0600
Message-ID: <56423D44.60505@linux.intel.com>
References: <CAGOuWmvw39beNdaLgdBGXk9rNWw9vwbFfQNSBw50KLYpGa_AHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EB76226549F
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 19:54:24 +0100 (CET)
In-Reply-To: <CAGOuWmvw39beNdaLgdBGXk9rNWw9vwbFfQNSBw50KLYpGa_AHA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Pogrebinsky <michael.pogrebinsky@daqri.com>, alsa-devel@alsa-project.org
Cc: John Hawley <john.hawley@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Michael,

> I have the MinnowBoard Max with Baytrail Atom (ValleyView) SoC.
> I'm attempting to write an Alsa (ASoC) driver for my sound card to
> work with this board.
> PCM should work through I2S for this sound card I have.

Good to hear. There are several folks in Intel trying to enable I2S over 
the low-speed connector for 3rd party enablement or help 'makers'. This 
is still work-in-progress but we can already share some elements of 
information based on our own experience:
1. the default 0.82 firmware doesn't enable the I2S pins, we are 
currently using a DSDT override to configure them.
2. the audio codec needs to be registered as a child of I2C6 (it's 
typically I2C2 on regular baytrail platforms). this is also part of the 
DSDT override.
3. since we need to support multiple audio codecs, we'd like to add a 
mechanism to add information in the SSDT table to be able to boot the 
same kernel and select the right drivers. Alternatively you will have to 
use the DSDT override method until this mechanism is ready.
4. there is no MCLK on existing MinnowBoards, so your codec will have to 
drive its PLL from the BLCK. newer versions of the MinnowBoard Turbot 
will support an MCLK but they are in pre-production stage and to the 
best of my knowledge not available commercially yet.
5. to get the best long-term support you really want to use the newer 
DPCM-based driver/firmware for e.g 24-bit, TDM and deep-buffer support. 
We have a set of patches that have not been published upstream yet but 
if you are interested you can look at my github 
https://github.com/plbossart/sound/tree/minnow-v4.3-24bit. In theory if 
you take this code and change the DSDT to support your _HID just like it 
was done for the rt5651 the drivers should load and register a sound card.
Disclaimer: there is no official support on this branch and 
rebases/fixes may happen at any time. the code will be submitted 
upstream when ready.

If you provide more information on which codec you are trying to link to 
we can help further.
-Pierre
