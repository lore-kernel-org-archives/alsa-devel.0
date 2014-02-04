From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange sound of IDT 82hd206xx6 at font port in
	AC97 mode
Date: Tue, 4 Feb 2014 11:48:05 +0800
Message-ID: <CAN8ccibwRRokZ0BdJgQVeQuds8oxPAs7SyxVLehaTjK21G1s+w@mail.gmail.com>
References: <BLU0-SMTP22F128862C405DED98AB89ADAB0@phx.gbl>
 <CAN8cciZ+QwNpSnBmXuvKV9Hkqhfbo6CvY0bmx7rMQic9+tgb8A@mail.gmail.com>
 <BLU0-SMTP168158F76E25FBB1A51D33EADAA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 9299226167E
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 04:48:06 +0100 (CET)
Received: by mail-qc0-f182.google.com with SMTP id c9so12607334qcz.41
 for <alsa-devel@alsa-project.org>; Mon, 03 Feb 2014 19:48:05 -0800 (PST)
In-Reply-To: <BLU0-SMTP168158F76E25FBB1A51D33EADAA0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Li <lxr1234@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>

> >>
> >> Hello My mainboard is ECS A780GM-A, the sound chip in it is IDT
> >> 82HD206XX6,
> >
> > Is this 92HD206X ?
> >
> Maybe it is, but it is 82HD206XX6 in the top side of the chip.
>

you can try hda_jack_sense_test.py to measure the impedance of the rear
panel jacks

https://bugzilla.kernel.org/attachment.cgi?id=118731

this require the python and hda codec parser of hda-analyer


>
> > Seem this codec support impedance sense
> >
> > Post the output of alsa-info.sh
> >
> http://www.alsa-project.org/db/?f=ce795f0f8e31b9eb5e35cc2fed572290d14b1cda
>


the BIOS of those motherboard which use IDT codec seem use
[Jack] Speaker at ext Rear for those line out jacks at rear panel

Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Control: name="Speaker Front Jack", index=0, device=0
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01114010: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0


is it possible for the auto parser to put them into cfg->lineout when
device is speaker but the  connection is [Jack] and location is Ext Rear ?

the driver will not create those "line in jack mode" and "mic jack mode"
controls when it is desktop instead of notebook

Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Control: name="Line Jack Mode", index=0, device=0
    ControlAmp: chs=0, dir=In, idx=0, ofs=0
  Control: name="Line Jack", index=0, device=0
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01813022: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x2, Sequence = 0x2



Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Control: name="Rear Mic Jack Mode", index=0, device=0
    ControlAmp: chs=0, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Jack", index=0, device=0
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19021: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Connection: 1
     0x03
