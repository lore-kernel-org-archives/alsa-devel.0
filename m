From: Harald Becker <ralda@gmx.de>
Subject: Re: HDA Beep Device for Asus EeeBox EB1501P
Date: Sat, 23 Feb 2013 21:01:54 +0100
Message-ID: <20130223210154.09d77f2a@ralda.gmx.de>
References: <20130220225153.603edc5e@ralda.gmx.de>
 <s5hwqu0crjm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 0995E264F45
 for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2013 21:05:39 +0100 (CET)
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LkDzQ-1Uh2UA3jnG-00c6DG for
 <alsa-devel@alsa-project.org>; Sat, 23 Feb 2013 21:01:56 +0100
In-Reply-To: <s5hwqu0crjm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi !

> 22-02-2013 16:11 Takashi Iwai <tiwai@suse.de>:

> > I own an Asus EeeBox EB1501P with an ALC662 codec and had no HDA
> > mixer channel for the speaker beep device. After digging somewhat
> > in the kernel source I found that I only need to add a single line
> > in the beep_white_list in patch_realtek.c. May be this entry can be
> > included in the mainstream drivers:
> > 
> > SND_PCI_QUIRK(0x1043, 0x8376, "EeePC", 1),

> Could you submit a proper patch for it?

Sorry, no. Do not have the right source base for creating patches. It
is just a single line to add the system ID for my EeeBox to the
beep_white_list table in patch_realtek.c. Are you able to create a
patch for this? 
 
> > If I use echo -e "\a" in a shell or run the beep command utility the
> > sound appears only on second and following invocations. Whenever the
> > frequency changes with the beep command the first invocation stays
> > silent or just produce some click due to ALSA driver power saving.
> > On all further invocations with same frequency the requested tone is
> > generated on external speakers. There is no difference in behavior
> > if the commands are called in a terminal emulator or directly on a
> > virtual text console.
> > 
> > Does this happen only on my machine or is this a known problem? Is
> > there anything I can do to fix this behavior?
> 
> So, the behavior above disappears if you disable the power save?

Can't do further testing on this (see below), but it did not look to
depend on the power saving feature. Power saving produces a noticeable
speaker click (sic!). That click was there even on first invocation. So
the speakers got turned on but no sound was produced.

> Does the patch like below have any influence on the behavior?

I recreated my kernel changing several configuration parameters
centering about the problem to get the IT87 hwmon module to load
instead of ATK0110. Finally I managed to get this working using the
kernel option acpi_enforce_resources=lax. Now *ALL* hardware
devices/functions of my EeeBox 1501P seam to work correct, including fan
speed control. 

In addition this changed behavior of HDA Beep device. It now works
correct on all invocations of beep utility. So I can't reproduce
behavior. I do not know if my configuration modifications changed
something or I did something wrong on my first tests. So please drop
this issue request for now and just add the system ID to the
beep_white_list. With this my EeeBox 1501P works fine, now!

If any trouble reappear, I will drop a new request on this. Sorry for
the noise.

Thx for your assistance
Harald
