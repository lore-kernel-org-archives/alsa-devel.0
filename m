From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound from Headphone Jack over Lenovo Docking
 Station with T440p Laptop
Date: Sun, 22 Dec 2013 20:47:41 +0800
Message-ID: <CAN8cciaKv=4s2Njaag7XjqBj203EPL1BTi3XAG+ZmEpSP+20hg@mail.gmail.com>
References: <trinity-ed805987-a2af-445d-8c84-171681bd6482-1387447530146@3capp-webde-bs34>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AE732610AA
 for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2013 13:47:42 +0100 (CET)
Received: by mail-ig0-f174.google.com with SMTP id hk11so19133977igb.1
 for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2013 04:47:41 -0800 (PST)
In-Reply-To: <trinity-ed805987-a2af-445d-8c84-171681bd6482-1387447530146@3capp-webde-bs34>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Kalkhof <nkalkhof@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>    Hello, I have a Lenovo ThinkPad T440p laptop connected to an Ultra
>    Docking Station. Sound works fine over Laptop Speakers and the 3,5mm
>    Headphone Jack. However that is not the case when I connect the T440p
>    to the Docking station Type 40A10065EU and use the Headphone Jack at
>    the Dock. I've tried loading the alsa module with the "model=thinkpad"
>    or "model=lenovo-dock"  without success. My Distro is Gentoo and the
>    Kernel is 3.13-rc4.

Do your dock station has one headphone and one mic Jack or just one combo
headset Jack ?

http://support.lenovo.com/en_US/detail.page?DocID=PD029485

Connect headphones or a headset that has a 3.5-mm (0.14-inch), 4-pole plug
to the audio connector to listen to the sound from the computer.

Remove the following lines

>    options snd cards_limit=1
>    #options snd-hda-intel model=thinkpad
>    options snd-hda-intel model=thinkpad enable=1 index=0
>    options snd-hda-intel model=hdmi enable=1 index=-2
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=108cc108a3bb42fe4705df1317ff98e1e29428a6

lenovo-dock expect dock headphone Jack and dock Mic Jack ?

Post the output of alsa-info.sh when thinkpad is docked and not docked with
headphone pluggedd and unplugged
