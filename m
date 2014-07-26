From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Sat, 26 Jul 2014 12:01:41 +0800
Message-ID: <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com
 [209.85.192.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A9F4F261B0D
 for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2014 06:01:42 +0200 (CEST)
Received: by mail-qg0-f43.google.com with SMTP id a108so6066712qge.16
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 21:01:41 -0700 (PDT)
In-Reply-To: <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> What is the best way to test/debug the alc668 driver these days?
>
> I am running kernel 3.14.1 (debian testing/sid).
>
> The laptop is an ASUS N750JK.
>
> Sound works for front left/right speakers but the back speakers and
> external lfe channel is not working on this laptop.

You have to post output of alsa-info.sh

Do the BIOS setup all the pin default ?

How many audio jacks ?

Do it support headset or headphone ?

Do you mean there are four internal speakers ?

Do it support surround40 in windows ?

The external sonic master and headphone need two volume controls but alc668
only have three

The best way to test is using latest git version and hda jack retask to

1) four internal speaker and headphone
2) two internal speaker, headphone and external subwoofer

Once you confirm the nodes of the speakers, subwooder
You need to decide whether headphone share the volume controls with the
speaker/subwoofer
>
> - I have found a couple of kernel bug reports  for other ASUS models with
> this chipset but they are both marked resolved. Should I open a new ticket
> ?
>
> https://bugzilla.kernel.org/show_bug.cgi?id=65091
> https://bugzilla.kernel.org/show_bug.cgi?id=66271
>
> - I can hear static through the front speakers (with pulseaudio test)  if
> I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
> (Center/LFE) or vice versa with hdajackretask.
>
> Pin 0x16 does not appear to work at all.
>
> I see this output when I apply the config in hdajackretask.
>
> 0x12 0x90a60140
> 0x14 0x99130110
> 0x15 0x04211020
> 0x16 0x99134111
> 0x18 0x01a19840
> 0x19 0x01014011
> 0x1a 0x411111f0
> 0x1b 0x411111f0
> 0x1d 0x40c6852d
> 0x1e 0x014b1180
> 0x1f 0x411111f0
> 1
>
>
>
>
>
>
> --
> Patrick Shirkey
> Boost Hardware Ltd
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
