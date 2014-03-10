From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 5.1 sound system works as 2.0 on all kernels newer
 than 3.2.21
Date: Mon, 10 Mar 2014 16:11:55 +0800
Message-ID: <CAN8cciZBYC5gBQ0D-pr-xZofRQj+DL4VhbkWuJ6EPiW9rB+A6Q@mail.gmail.com>
References: <1512458b03b8afc7302aca9a8c92db61e06371a6@mail.qip.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f41.google.com (mail-qa0-f41.google.com
 [209.85.216.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DC6A264F40
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 09:11:58 +0100 (CET)
Received: by mail-qa0-f41.google.com with SMTP id j5so6650696qaq.14
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 01:11:55 -0700 (PDT)
In-Reply-To: <1512458b03b8afc7302aca9a8c92db61e06371a6@mail.qip.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: giperon@land.ru
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2014-03-09 21:44 GMT+08:00 <giperon@land.ru>:

> Hi, my 5.1 sound system works as 2.0 on all kernels newer than 3.2.21.
> Control "Channel Mode" is missing in "Alsamixer".
> I use the option "3stack-6ch" (module snd-hda-intel, Realtetsk codec
> ALC882) for kernel 3.2.21.
>
> "Alsa-info" for kernels 3.2.21 and 3.13.6 attached.
>

what is the model of your computer 's motherboard ?

how many audio jacks at rear panel ?

if it only have three jacks (green , pink and blue) at rear panel , you
need to fixup the following pin default to [N/A]


Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01016412: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01011411: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01012414: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
