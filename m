From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Microphone does not longer work on Lenovo N581
Date: Wed, 2 Oct 2013 15:25:06 +0800
Message-ID: <CAN8ccibJY+qgGWQEy9t0CCfzSPSju4jDLxtRnb6EvLNDy8nDSA@mail.gmail.com>
References: <l28nen$jns$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 06731264FEE
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 09:25:07 +0200 (CEST)
Received: by mail-ie0-f174.google.com with SMTP id u16so926752iet.5
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2013 00:25:06 -0700 (PDT)
In-Reply-To: <l28nen$jns$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Felix Kaechele <felix@fetzig.org>
List-Id: alsa-devel@alsa-project.org

I'm using Archlinux and so usually run always on the latest kernel.
>
> But unfortunately somewhere with Kernel 3.9 my Intel sound got broken.
> Playback works, but no microphone is found.
>
> So I keep downgrading to 3.8.8 for some months, now.
>
> Can someone please help me with finding a solution for this? Is it really
> possible that the alsa driver "snd_had_intel" was broken between 3.8 and
> 3.9 and noone found this bug, so far



seem N581 and U310 have same codec cx20590 and PCI SSID but different codec
SSID


https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1080893

00:1b.0 Audio device [0403]: Intel Corporation Panther Point High
Definition Audio Controller [8086:1e20] (rev 04) Subsystem: Lenovo Device
[17aa:3977]

Codec: Conexant CX20590
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x14f1506e
Subsystem Id: 0x17aa4009
Revision Id: 0x100003


https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1161239

00:1b.0 Audio device [0403]: Intel Corporation Panther Point High
Definition Audio Controller [8086:1e20] (rev 04) Subsystem: Lenovo Device
[17aa:3977]

Codec: Conexant CX20590
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x14f1506e
Subsystem Id: 0x17aac033
Revision Id: 0x100003

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_conexant.c?id=e4db0952e542090c605fd41d31d761f1b4624f4a
