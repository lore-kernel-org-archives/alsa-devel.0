From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Tue, 29 Jul 2014 11:58:33 +0800
Message-ID: <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
 <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F86A2651F0
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 05:58:36 +0200 (CEST)
Received: by mail-qg0-f42.google.com with SMTP id j5so9689123qga.1
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 20:58:33 -0700 (PDT)
In-Reply-To: <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
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

> >>
> >> What is the best way to test/debug the alc668 driver these days?
> >>
> >> I am running kernel 3.14.1 (debian testing/sid).
> >>
> >> The laptop is an ASUS N750JK.
> >>
> >> Sound works for front left/right speakers but the back speakers and
> >> external lfe channel is not working on this laptop.
> >
> > You have to post output of alsa-info.sh
> >
>
> http://boosthardware.com/alsa-info-alc668-n750jk.txt

Seem BIOS only set up the front speakers

> >
> > How many audio jacks ?
> >
>
> Standard headphone/mic + yellow external lfe (sonic master). There is also
> hdmi but I am not testing that at the moment.

http://www.asus.com/Notebooks_Ultrabooks/N750JK/specifications/

Do you mean headset ?

>
> > Do it support headset or headphone ?
> >
> > Do you mean there are four internal speakers ?
> >
>
> There are two front speakers which produce sound through the front bottom
> of the case. There are also two back speakers which do not produce sound
> in my tests so far.
>
> > Do it support surround40 in windows ?
> >
>
> I am not running windows OS on this machine but I suspect it does.
>
> > The external sonic master and headphone need two volume controls but
> > alc668 only have three
> >
> > The best way to test is using latest git version and hda jack retask to
> >
>
> The process has changed somewhat since I last did this.
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/sound/pci/hda?qt=grep&q=alc668

>
> > 1) four internal speaker and headphone
> > 2) two internal speaker, headphone and external subwoofer
> >
> > Once you confirm the nodes of the speakers, subwooder
> > You need to decide whether headphone share the volume controls with the
> > speaker/subwoofer
> >>
>
> I have spent some time on this step already with 3.14.1

Did you retask the node of subwoofer as speaker or line out ?

For multi channel, the sequence number is ascending and the driver expect
they have same type i.e, all speakers or all line out jacks

Did you find the node of the rear speakers in  (1) ?

Did surround 4.0 work when you fix the rear speaker ?

Did you find the node of the external subwoofer  in (2) ?

Did the sonic master subwoofer detected   ?
hda jack sense test -a

Do the subwoofer only use right channel ?

Do surround 2.1 works ?

>
> Is there a specific reason this process is not already scripted other than
> no one has taken the time to do it?

Do surround 4.1 or 5.1 work when you fix both speaker and subwoofer ?

Do  you prefer driver create  headphone volume control or subwoofer volume
control ?

>
> Can we not create a test script that will run through all the logical
> combinations and provide all the relevant info?
>

The driver hardcore the name of volume control to bass when there are two
speaker nodes for those 2.1

>
> >> - I have found a couple of kernel bug reports  for other ASUS models
> >> with
> >> this chipset but they are both marked resolved. Should I open a new
> >> ticket
> >> ?
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=65091
> >> https://bugzilla.kernel.org/show_bug.cgi?id=66271
> >>
> >> - I can hear static through the front speakers (with pulseaudio test)
> >> if
> >> I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
> >> (Center/LFE) or vice versa with hdajackretask.
> >>
> >> Pin 0x16 does not appear to work at all.
> >>
> >> I see this output when I apply the config in hdajackretask.
> >>
> >> 0x12 0x90a60140
> >> 0x14 0x99130110
> >> 0x15 0x04211020
> >> 0x16 0x99134111
> >> 0x18 0x01a19840
> >> 0x19 0x01014011
> >> 0x1a 0x411111f0
> >> 0x1b 0x411111f0
> >> 0x1d 0x40c6852d
> >> 0x1e 0x014b1180
> >> 0x1f 0x411111f0
> >> 1
> >>
