From: Joseph Wang <joequant@gmail.com>
Subject: Re: Cherry trail and Nau 88l24 codec
Date: Mon, 5 Dec 2016 14:45:54 +0800
Message-ID: <CAPoeEY8=A949-cuVwfyov2GfpQc=hAjPsDG-suXmT_TDytOKBQ@mail.gmail.com>
References: <CAPoeEY_Tve2TAgBqY+MqPEUGnbadYHg9Z90DQ=YQumWebfW++A@mail.gmail.com>
 <62e35b1dac6b4000beb73d857f780f04@NTHCML01B.nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 726E8266AE1
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 07:45:55 +0100 (CET)
Received: by mail-qt0-f179.google.com with SMTP id n6so305725591qtd.1
 for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2016 22:45:54 -0800 (PST)
In-Reply-To: <62e35b1dac6b4000beb73d857f780f04@NTHCML01B.nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KCHSU0@nuvoton.com
Cc: alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

>
> [    2.681633] snd_intel_sst: Requesting FW fw_sst_22a8.bin now...
>

Hi,

This is the firmware that I am using.  Right now the problem is that I'm
getting timeouts.  I've confirmed that the device runs fine under the
Windows WDM Audio drivers and the Windows NAUL88 codec.  So what appears to
be happening is that machine driver is doing something incorrectly.

If you can look at

https://github.com/joequant/nau8824/blob/master/linux-4.8/cht_bsw_nau8824.c

And check to see how the initialization is different than the Windows
driver, this would be very useful.  I don't know how the device is wired,
but I do know that it appears to work with the Cherry Trail windows
drivers.  That being the case, I think the issue is my misinitialization
rather than device quirk.

Also to answer your other question.  I am no longer getting kernel errors
in the codec.  I believe that at one point I was loading old versions of
the codec, but once I did a clean build with the sources that you've
provided me, I get no issues with the codec, and I've removed the
workaround code.  The problems that I'm having with the firmware appear to
arise from the machine drivers.

One other thing, I was wondering if you have a Cherry Trail dev environment
that you can test to see if you can load in my machine driver and replicate
the firmware time outs.
