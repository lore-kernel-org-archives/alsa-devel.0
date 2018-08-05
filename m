From: David Ulricht <david.ulricht434@gmail.com>
Subject: Re: CS8409 Macbook Pro 2016 2017
Date: Sun, 5 Aug 2018 21:58:59 +0300
Message-ID: <CALbf9MzMsogqx8+hco7p9rRqxBy8iLD4emr==6DO6PLxP3iBEw@mail.gmail.com>
References: <CALbf9MzcxBqkBP4mbUKht72Ga6VnTubeiHcTr2joEf7i-enxFQ@mail.gmail.com>
 <s5h7el6vd91.wl-tiwai@suse.de>
 <CALbf9Mw=Y5ddFZDZQ4_mfYCHxKb9XFHN3v5ge0JaTca7NLMM7A@mail.gmail.com>
 <s5hzhy2t7ww.wl-tiwai@suse.de>
 <CALbf9MwN4pEk26R9c2-UMxzvLXQ3OOBTcqgdSvXeFb-dw7-Wnw@mail.gmail.com>
 <s5hwot6t5qz.wl-tiwai@suse.de>
 <CALbf9MzYvcz+d0HKmvc60WhTHVpiuTK8O66qNH3Xcuo5j3uU9Q@mail.gmail.com>
 <s5h1sbcu1t1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B16D2673A0
 for <alsa-devel@alsa-project.org>; Sun,  5 Aug 2018 20:59:01 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id 13-v6so18496549ois.1
 for <alsa-devel@alsa-project.org>; Sun, 05 Aug 2018 11:59:01 -0700 (PDT)
In-Reply-To: <s5h1sbcu1t1.wl-tiwai@suse.de>
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

>
>
> OK, then it's not about GPIO, something else.
> It's hard to know without the datasheet...


Can't we get a little help from Cirrus Logic, unofficially not breaking NDA
someone from them to pretend to be a noob that tried few things and
actually give us some hints?
Doubt they will drop us the datasheet.


> Yes, NID 0x01 is usually the right value, which means AFG.
>
> At least I understood correctly and learned something.
Then what comes to mind is that my [pincfg] might be wrong or actually not
applying correctly in the driver if I cannot verify it from the codec#0
file as you said, you sure the C code of that generic Cirrus Logic won't
interfere somehow ?
What comes to my mind is some type of simple test C code that sends to the
device some continuous sound from C code using the [pincfg] I got from
Windows, do you happen to have that ?
Do those codecs have this Beep sound that is present in the codec#0 as an
output device, can't we try to make the sound card beep ? Anything to prove
we can interact with it somehow.



> BTW, I noticed that there is some downstream patch.  Is it the repo
> you mentioned earlier?
>   https://github.com/joelkraehemann/hda-tool/blob/
> master/patch_cirrus.c.patch
>
> Did you try that?
>

Not really, I have checked his posts in the bugzilla and he says that this
is the fixups for iMac27 and the card there is slightly different, and he
mentioned December 2017 that none of he tried works, and the code age is
earlier.
Plus I don't see a single place where he uses my [pincfg] e.g. 0x24 and
0x25 for speakers, he mentioned he tried 0x2b 0x2c if not mistaken, and
think that are the speakers.
https://bugzilla.kernel.org/show_bug.cgi?id=195671
He mentions that he thinks its integrated circuit MAX98357BEWL.Which I
can't confirm but well it might be.

I tried to get to debug Windows kernel driver but happens that the Macbook
pro 2017 13 nontb has only 2 Thunderbolt3 ports, and to debug the kernel
drive you need a supported Ethernet device officially by microsoft, and
mine usb-c ethernet is a new Realtek that is not supported, I'll need to
find a usb2,3 ethernet that has a supported chip which might be difficult,
no guarantee I will understand anything from the windows kernel debugging.

Note that when you insert Thunderbolt3 adapter, that has HDMI adapter, the
Audio over HDMI is working, multiple sources confirmed this.
I suspect that the kernel enables HDMI audio and apple might have
integrated hardware automatic switch when you enable HDMI internal sound
card turns off, is there any way that I can prohibit HDMI audio codec#2 not
even to load during kernel boot?
Is that even possible to disable the HDMI audio if it comes from the i915
video card ? Does the above make sense at all ?
