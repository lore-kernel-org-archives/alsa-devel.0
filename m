From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Wed, 19 Sep 2012 23:20:26 +0800
Message-ID: <CAN8cciagRyqJ498+rnz2m8542q5BMAWS5h+j72Nzh2Nf=FuDuQ@mail.gmail.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciYZBU+LaaQFXrn9kPoFc=MdYahw0ucKNmAhrG=CT0+C5g@mail.gmail.com>
 <s5h392rhbyu.wl%tiwai@suse.de> <5056D395.4090603@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C2EF62651FE
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 17:20:27 +0200 (CEST)
Received: by qadz3 with SMTP id z3so1129708qad.17
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 08:20:26 -0700 (PDT)
In-Reply-To: <5056D395.4090603@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, 939161@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/939161

00:1b.0 Audio device [0403]: Intel Corporation N10/ICH 7 Family High
Definition Audio Controller [8086:27d8] (rev 02)
Subsystem: Uniwill Computer Corp Device [1584:9072]
>
>
> The PCI SSIDs are different, so I don't think that commit will affect the
bug I was trying to fix.

There was a model uniwill-m31

what you need is just provide a pin fixup from the patch which remove the
model

- [ALC861_UNIWILL_M31] = "uniwill-m31",

- SND_PCI_QUIRK(0x1584, 0x9072, "Uniwill m31", ALC861_UNIWILL_M31),

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=9fbbc94fe0f0a85d048b74fced3cfca404d78a3c;hp=6ebb80530b0ed6b2e93f2e6497890b4437807055
