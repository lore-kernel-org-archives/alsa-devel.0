From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Thu, 9 Apr 2015 22:02:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.20.1504092157190.901@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E95B26599E
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 22:02:21 +0200 (CEST)
Received: by wiax7 with SMTP id x7so2067093wia.0
 for <alsa-devel@alsa-project.org>; Thu, 09 Apr 2015 13:02:20 -0700 (PDT)
In-Reply-To: <s5hegntl2cs.wl-tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hello guys.
I am running kernel 4.0.0-rc7hc+ (the "hc" is my own versioning name).
There seems to be less problems (the card doesn't get stuck at some point): 
this device continues to be a little bit unstable (i.e.: now the internal 
speaker doesn't work):
[   20.841143] snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching to polling mode: last cmd=0x000f0000
[   21.843141] snd_hda_intel 0000:00:1b.0: Codec #0 probe error; disabling it...
[   22.848327] snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching to single_cmd mode: last cmd=0x000f0000
[  148.125849] snd_hda_intel 0000:00:1b.0: Invalid position buffer, using LPIB read method instead.

but I think this is due to the fact I restarted the system with kexec, not with 
a clean bios reboot. But I signaled this since it seems that also a sequence 
like:
sudo modprobe -r snd_hda_intel
# some time
sudo modprobe snd_hda_intel

can trigger strange behaviours.
But guys - this is probably not a problem that can be solved from the driver 
itself (as I imagine looking at the messages i got yesterday from 
pci/access.c).
So - thank you for the help, and the tireless work you all put on this driver.
