From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: Re: 100.0% power usage of Device Audio codec (HDA) on
	wake
Date: Sat, 17 Nov 2012 02:17:32 +0100
Message-ID: <879d5c6142e1896187172f555eaf2f57@sourcepole.ch>
References: <af012f839bb665744d02fa1031764767@sourcepole.ch>
 <s5hmwyhh6vg.wl%tiwai@suse.de>
 <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 17D60261981
 for <Alsa-devel@alsa-project.org>; Sat, 17 Nov 2012 02:17:41 +0100 (CET)
In-Reply-To: <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 17 Nov 2012 01:48:47 +0100, Tomas Pospisek wrote:

> On Fri, 16 Nov 2012, Takashi Iwai wrote:

>> Which codec and HD-audio controller chips?
[...]
> 
> Powertop says "Audio codec hwC0D0: IDT". Other People in the launchpad
> bugtracker seem to be reporting either "hwC0D0: IDT", "hwC0D0: Conexant"
or
> "hwC0D1: Conexant". 
> 
>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560
> 
> Here's the chip:
> 
> Audio:
> 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
> Family High Definition Audio Controller (rev 05)

People in this other bug thread seem to have other "codecs" and setups as
well:

1. k: Ubuntu linux-image-3.0.0-12-generic 3.0.0-12.20
   d: ?
   c: ?
   u: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560

2. k: ?
   d: ?
   c: hwC0D1: LSI, hwC0D0: Analog Devices
   u:
https://bugs.launchpad.net/ubuntu/+source/powertop/+bug/536631/comments/3

3. k: ?
   d: ?
   c: hwC0D1: LSI
   u:
https://bugs.launchpad.net/ubuntu/+source/powertop/+bug/536631/comments/4

4. k:
   d:
   c: hwC0D1: LSI
   u:
https://bugs.launchpad.net/ubuntu/+source/powertop/+bug/536631/comments/5

5. k: ?
   d: ?
   c: hwC0D3: auto (Intel)
   u:
https://bugs.launchpad.net/ubuntu/+source/powertop/+bug/536631/comments/6

6. k: ?
   d: ?
   c: hwC0D0: SigmaTel
   u:
https://bugs.launchpad.net/ubuntu/+source/powertop/+bug/536631/comments/7

7. k: linux-image-3.0.0-12-generic 3.0.0-12.20, 3.1.0-*
   d: Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]
   c: hwC0D0: Conexant
   u: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560

8. k: ?
   d: ?
   c: hwC0D0: IDT
   u:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560/comments/34

9. k: 3.2.0-26-generic #41-Ubuntu
   d: Device: 6 Series/C200 Series Chipset Family High Definition Audio
Controller [1c20]
   c: ?
   u:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560/comments/43

10. k: ?
    d: PCI Device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller,
       PCI Device: Advanced Micro Devices [AMD] nee ATI RV635 HDMI Audio
[Radeon HD 3600 Series]
    c: ?
    u:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560/comments/44

11. k: linux-image-3.2.0-4-amd64
    d: 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series
Chipset Family High Definition Audio Controller (rev 05)
    c: Audio codec hwC0D0: IDT
    u:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560/comments/45
