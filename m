From: Hector Martin <hector@marcansoft.com>
Subject: Re: Acer Aspire 8920g / snd-hda-intel / ALC889
 /	surround sound
Date: Fri, 23 Jan 2009 02:36:39 +0100
Message-ID: <49791F27.3080002@marcansoft.com>
References: <20081225192456.GA16788@deadlock.dhs.org>
	<20090105201722.GA23503@deadlock.dhs.org>
	<20090114141402.GA14581@deadlock.dhs.org>
	<4977A242.3080504@marcansoft.com>
	<20090122163653.GA16659@deadlock.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E3631037E3
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 02:36:42 +0100 (CET)
In-Reply-To: <20090122163653.GA16659@deadlock.dhs.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergey 'Jin' Bostandzhyan <jin@deadlock.dhs.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sergey 'Jin' Bostandzhyan wrote:
> Hmm, I applied the patch to the latest git, selected model acer-aspire-4930g,
> upped volume in the mixers and ran:
> speaker-test -c6 -Dplug:surround51 -t wav -l1
> 
> 
> Got only front left / front right output. What am I missing?

Try speaker-test -Dhw:0 -c6 -twav

Make sure that 6ch mode is selected in the mixer (this should not be
necessary as it relates to the jacks, but that's one of the things I'd
have to fix for a "real" patch), and that the relevant volume levels are
turned up.

If it doesn't work, please attach your /proc/asound/card0/codec#0 file

> Am I supposed to adjust anything with the analyzer before testing your patch?

Not in theory, but you can try some things.

Here's what the relevant NIDs correspond to:
0x02 - (normally) Front DAC
0x03 - (normally) Rear DAC
0x04 - (normally) CLFE DA

0x0c - (normally) Front mixer
0x0d - (normally) Rear mixer
0x0e - (normally) CLFE mixer

0x14 - Front speakers pin
0x15 - Headphones pin (also EAPD for speaker amp)
0x16 - CLFE speakers pin
0x1b - Rear speakers pin

You can try selecting 0x16 and 0x1b and setting the connection to 0x0c -
this should replicate the front sound through the rear speakers and the
center/lfe speakers, so you can confirm that the outputs themselves work
and are mapped as they are on my laptop. Make sure that they're set to
OUT mode and not muted or anything too. If this doesn't work then
something weird is going on.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
