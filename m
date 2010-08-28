From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: explicit commandline control of speakers vs
 headphone output
Date: Sat, 28 Aug 2010 16:02:19 +0800
Message-ID: <AANLkTinBmkR5+rROEJJPuioMhBNjJ+61qZ2JV3+HcQUJ@mail.gmail.com>
References: <210284.64008.qm@web50707.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CE7F245DD
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 10:02:19 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2497746eyd.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 01:02:19 -0700 (PDT)
In-Reply-To: <210284.64008.qm@web50707.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/28 Eric Holstege <eric_holstege@yahoo.com>

> Thanks, Clemens;
>
> How were you able to determine that from the "amixer scontents" output.
>
> Although I can't disable *automatic* speaker mute on headphone
> insertion, can I explicitly unmute them again (e.g. with amixer sset or
> cset)?
>
> If not....
> "cat /proc/asound/card*/codec*" says it is the Realtek ALC888.
> Does this mean I have to somehow patch the kernel sound module file
> .../linux-source-2.6.*/sound/pci/hda/patch_realtek.c
> to fix this somehow?
>

Post output of alsa-info.sh after a cold boot to allow BIOS setup the pins

ALC888 has 5 DAC and 2 ADC , if you want to implement a new model which
allow internal mic and  internal  speaker , mic jack and headphone jack to
be used independently by two applications  , you will need to disable the
automute function
