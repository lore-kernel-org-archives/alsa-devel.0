From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Realtek ALC286 SONY Vaio Pro 13 Ubuntu 13.10
Date: Mon, 30 Sep 2013 09:50:32 +0200
Message-ID: <52492D48.102@canonical.com>
References: <524652C0.5040207@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C65526167E
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 09:50:47 +0200 (CEST)
In-Reply-To: <524652C0.5040207@uwo.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yuval Levy <ylevy@uwo.ca>, Kailang <kailang@realtek.com>, David Chen <david.chen@canonical.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(Adding alsa-devel to CC)

On 09/28/2013 05:53 AM, Yuval Levy wrote:
> Sirs:
> 
> I have been pointed to your patch to implement headset jack
> functionality for some Dell hw [1] after reporting and investigating
> soud support issues [2] with a SONY Vaio Pro 13 (Realtek ALC286).

This different headset mode support is likely unrelated to your problem.
And they don't cover your codec (ALC286), so you would need another set
of verbs too, things that only Realtek knows.

> Output to internal loudspeakers and HDMI works as expected, but neither
> internal microphone nor the headset work (and they do work in Windows,
> so it is not a hardware issue).

An important distinction is here: to they work in Windows without
specific Realtek drivers installed, or do you require Realtek's Windows
drivers for this support?

Second, to do some actual triaging. I see you have been running
hda-jack-sense-test. Could you run it all three scenarios:
 1) nothing connected
 2) headphone (without mic) connected
 3) headset (heaphone + mic combo) connected

...and submit the result? In ideal circumstances, 0x21 should report
"Yes" in scenario 2 and 3, and 0x18 should only report yes in scenario
3. If this is not the result you get, try using hda-jack-retask to turn
off the jack detection: in Ubuntu 13.10 just install the alsa-tools-gui
package (no need to use my ppa). Click "advanced override", find pins
0x18 or 0x21, change "jack detection" from "yes" to "no" and click
apply. Now you should be able to manually choose between internal and
external microphone, as well as between headphones as speakers. See if
this helps.

> As you can see in the bug thread, I have been helped in the diagnosis by
> a very friendly expert, but it seems that we have reached the limit and
> without support from Realtek or Sony the issue will go unresolved.

I'm afraid Sony is not a company that actively supports Linux for the
desktop machines, sorry. Canonical, which seems to have the most
contracts for preloading Linux these days, has a list of certified
hardware here: http://www.ubuntu.com/certification/

> Would you kindly help me find out what need to be done for the Realtek
> ALC286 in the SONY Vaio Pro 13 to be supported in Ubuntu Linux?
> 
> Many thanks,
> Yuv
> 
> [1]
> <https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=73bdd597823e2231dc882577dbbaf8df92fe1775>
> [2] <https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/1228689>
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
