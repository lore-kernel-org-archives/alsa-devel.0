From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Asus N751JK - push/merge patches on mailinglist
Date: Fri, 18 Sep 2015 16:18:09 +0800
Message-ID: <CAN8cciYsOrDukw3nGHcX1bfFhENX7Un-tMshO9=FQfWys4PSqQ@mail.gmail.com>
References: <CALUcmU=PksErKgSpf5Rn-ZkbfSPS5Y_jW+E=phy4VUsKicWG7Q@mail.gmail.com>
 <s5hfv2izqi5.wl-tiwai@suse.de>
 <CAN8cciZbNnBFnWrOhALJ4W6h9pb4i-2voj7Rj1K-_M-w+XR31g@mail.gmail.com>
 <CALUcmU=6mdyxzWtk=-XN3QchJS-23dm9fV-C6DumJUwXwrDvCQ@mail.gmail.com>
 <CAN8cciYxtYRgi+Pau+i6z4YuhVs1y17S-dWNkFNbCnWbCj0u3A@mail.gmail.com>
 <CALUcmU=6rjsKxXE3ohpFtkPX7v5SH5NcMAobM_y370FQS-HkiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DCFF260499
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 10:18:10 +0200 (CEST)
Received: by oixx17 with SMTP id x17so22969127oix.0
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 01:18:09 -0700 (PDT)
In-Reply-To: <CALUcmU=6rjsKxXE3ohpFtkPX7v5SH5NcMAobM_y370FQS-HkiA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arthur Borsboom <arthurborsboom@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> As you suspected the internal speaker silences whenever I plug in any
jack.
>
> I have specified the alt_config option to test different possibilities,
however it does not get accepted the way I specify it, which is in
/etc/modprobe/alsa-base.conf
>
> options snd_hda_intel alt_config=3
> options snd_hda_codec_realtek alt_config=3

alt_config is hint not any module parameter

module paramter is related to hda controller

You have to use early patching

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio.txt
