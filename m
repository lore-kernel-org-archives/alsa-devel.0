From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Fri, 28 Mar 2014 12:46:49 +0800
Message-ID: <CAN8ccibOwd24r-qCrcnrZXaPy5We6dB=GccDyTR_qS-rPns1uw@mail.gmail.com>
References: <loom.20140326T163743-253@post.gmane.org>
 <CAN8ccib45znh-JbH57EhfbPNQg_fginmX9Tbr=yKMmd4D=iygQ@mail.gmail.com>
 <CAN8cciZkGx5XBO+u0b7V9YN8VU_rz8ckL8B=6oBFJr+-Yg8cxw@mail.gmail.com>
 <CAN8cciYy4V4StjqRfPpgZ8JMEYZrvpJYCBjfZtNhcn_2enRx6g@mail.gmail.com>
 <loom.20140327T213645-260@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 by alsa0.perex.cz (Postfix) with ESMTP id EF99E261A22
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 05:46:50 +0100 (CET)
Received: by mail-qc0-f182.google.com with SMTP id e16so5336419qcx.41
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 21:46:49 -0700 (PDT)
In-Reply-To: <loom.20140327T213645-260@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andoru <andoru.blah@gmail.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, cladisch@googlemail.com
List-Id: alsa-devel@alsa-project.org

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/cmipci.c?id=1c583063a5c769fe2ec604752e383972c69e6d9b

you have to dump the value of the register and increase the number of
trials to find out whether you can get a valid value


>
> >
> > state.CMI8738 {
> > control.1 {
> >
> > [...]
> >
> > Seem bug in adding channel map to iec958 instead of analog
>
> What does that mean? What should I do with those patches?
> Should I apply them and try to compile the latest ALSA version?

the patch did not channel map to the analog device

control.1 {
iface PCM
device 2
name 'Playback Channel Map'
value.0 0
value.1 0
value.2 0
value.3 0
value.4 0
value.5 0
comment {
access read
type INTEGER
count 6
range '0 - 36'
}
}

!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: CMI8738 [C-Media CMI8738], device 0: CMI8738-MC6 [C-Media PCI
DAC/ADC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CMI8738 [C-Media CMI8738], device 1: CMI8738-MC6 [C-Media PCI 2nd
DAC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CMI8738 [C-Media CMI8738], device 2: CMI8738-MC6 [C-Media PCI
IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/cmipci.c?id=1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/CMI8738-MC6.conf;hb=HEAD

CMI8738-MC6.pcm.rear.0 {

         @args [ CARD ]
         @args.CARD {
                type string
         }
         type hw
         card $CARD
         device 1
}

device 0 seem emulate sb16 , you need to ask the author how this driver
support multi-channels

seem device 1 is used for multi-channels playback and device 2 is used for
iec958
>
>
> >
> > pcm.!default {
> >     type plug
> >     slave.pcm "dmixer"
> > }
> >
> > You need asym plugin for playback and capture when overwrite pcm.default
> >
>
> Should I change my /etc/asound.conf like in the examples here?
> http://alsa.opensrc.org/Asym
>

yes, you need define both playback and capture if you overwrite pcm.default
 since dmix does not support capture
