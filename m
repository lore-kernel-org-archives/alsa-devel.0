From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Thu, 31 Jul 2014 11:27:20 +0800
Message-ID: <CAN8ccia3mi9G2oyaYyvJx14xu6F8dLhNZ6r0dpraO1F8qeLjBg@mail.gmail.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
 <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
 <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
 <57315.86.107.254.57.1406609183.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id DF659261A01
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 05:27:21 +0200 (CEST)
Received: by mail-qg0-f45.google.com with SMTP id f51so3042150qge.18
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 20:27:20 -0700 (PDT)
In-Reply-To: <57315.86.107.254.57.1406609183.squirrel@boosthardware.com>
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

> >> >>
> >> >> What is the best way to test/debug the alc668 driver these days?
> >> >>
> >> >> I am running kernel 3.14.1 (debian testing/sid).
> >> >>
> >> >> The laptop is an ASUS N750JK.
> >> >>
> >> >> Sound works for front left/right speakers but the back speakers and
> >> >> external lfe channel is not working on this laptop.
> >> >
> >> > You have to post output of alsa-info.sh
> >> >
> >>
> >> http://boosthardware.com/alsa-info-alc668-n750jk.txt
> >
> > Seem BIOS only set up the front speakers
> >
>
> There is nothing in the bios to configure the audio device
>
>
> >> >
> >> > How many audio jacks ?
> >> >
> >>
> >> Standard headphone/mic + yellow external lfe (sonic master). There is
> >> also
> >> hdmi but I am not testing that at the moment.
> >
> > http://www.asus.com/Notebooks_Ultrabooks/N750JK/specifications/
> >
> > Do you mean headset ?
> >
>
> There are the following jacks:
>
> 1 x headphone

Do you mean no optical spdif ?

> 1 x mic(line in)

Switching Mic Jack to line in can be performed by mic Jack mode switch
using hint add_jack_modes=true

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio.txt

> 1 x sonic master (yellow)
> 1 x hdmi (intel Haswell hdmi)
>
>
> >>
> >> > Do it support headset or headphone ?
> >> >
> >> > Do you mean there are four internal speakers ?
> >> >
> >>
> >> There are two front speakers which produce sound through the front
> >> bottom
> >> of the case. There are also two back speakers which do not produce
sound
> >> in my tests so far.
> >>
> >> > Do it support surround40 in windows ?
> >> >
> >>
> >> I am not running windows OS on this machine but I suspect it does.
> >>
> >> > The external sonic master and headphone need two volume controls but
> >> > alc668 only have three
> >> >
> >> > The best way to test is using latest git version and hda jack retask
> >> to
> >> >
>
> >>
> >> > 1) four internal speaker and headphone
> >> > 2) two internal speaker, headphone and external subwoofer
> >> >
> >> > Once you confirm the nodes of the speakers, subwooder
> >> > You need to decide whether headphone share the volume controls with
> >> the
> >> > speaker/subwoofer
> >> >>
> >>
> >> I have spent some time on this step already with 3.14.1
> >
> > Did you retask the node of subwoofer as speaker or line out ?
> >
>
> I have tried both but I have not been able to identify the subwoofer.
>
> I have tried playing with: 16, 19, 1a
>

> > Did you find the node of the rear speakers in  (1) ?
> >
>
> I have not found them yet.
>
> > Did surround 4.0 work when you fix the rear speaker ?
> >
>
> Only the front speakers play audio but they don't work with 4.0 enabled
>
> > Did you find the node of the external subwoofer  in (2) ?
> >
>
> Not yet.
>
> > Did the sonic master subwoofer detected   ?
> > hda jack sense test -a
> >
>
> I have grabbed the scripts but I get this error when running hda-analyzer:
>

You can use hda-verb GET_PIN_SENSE to test all the pin complex nodes which
pincap support DETECT

>
> > Do the subwoofer only use right channel ?
> >
>
> I cannot hear the subwoofer at this point
>
> > Do surround 2.1 works ?
> >
>
> It says it is working but I do not get sound out of the sub woofer.  I can
> hear static(whitenoise) through the front speakers (with pulseaudio test)
> if  I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
> (Center/LFE) or vice versa with hdajackretask.
>

http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/README;hb=HEAD

Did you use apply button(dyanmic reconfiguartion) or installment boot
override (early patching) ?

> >>
> >> Is there a specific reason this process is not already scripted other
> >> than
> >> no one has taken the time to do it?
> >
> > Do surround 4.1 or 5.1 work when you fix both speaker and subwoofer ?
> >
>
> Surround 4.1/5/1 do not produce any sound from my tests so far (using PA
> Test)
>
> > Do  you prefer driver create  headphone volume control or subwoofer
volume
> > control ?
> >
>
> I would like the lfe to be sent through the yellow sonic master jack. I am
> not concerned with the headset jack at the moment. A cursory test shows
> just the right channel is working on the headset jack.
>
>
> >>
> >> Can we not create a test script that will run through all the logical
> >> combinations and provide all the relevant info?
> >>
> >
> > The driver hardcore the name of volume control to bass when there are
two
> > speaker nodes for those 2.1
> >
>
> I do not see any controls for the bass volume in alsamixer
>
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=f37bc7a88d374448a1f4bba9267d308606d78bf2

> >>
> >> >> - I have found a couple of kernel bug reports  for other ASUS models
> >> >> with
> >> >> this chipset but they are both marked resolved. Should I open a new
> >> >> ticket
> >> >> ?
> >> >>
> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=65091
> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=66271
> >> >>
> >> >> - I can hear static through the front speakers (with pulseaudio
test)
> >> >> if
> >> >> I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
> >> >> (Center/LFE) or vice versa with hdajackretask.
> >> >>

> > For multi channel, the sequence number is ascending and the driver
expect
> > they have same type i.e, all speakers or all line out jacks
> >

Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE

The rear speaker need  same default association but  sequence number higher
than that of the front speaker

The external subwoofer may use [jack] speaker with same default association
and higher sequence number if it can be detected

The driver won't use all of them for multi channel if you retasked it as
line out
