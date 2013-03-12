From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: In 3.8 kernel alsa only talks HDMI,
 hardware also has S/PDIF optical
Date: Tue, 12 Mar 2013 15:13:46 +0800
Message-ID: <CAN8ccibMm2VhopmSfAKTNnXwtUvAYz6w6kagg758DfzRij2jFg@mail.gmail.com>
References: <20130311191801.035a7e29@zooty>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E4852615D6
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 08:13:47 +0100 (CET)
Received: by mail-ie0-f169.google.com with SMTP id 13so5964130iea.14
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 00:13:47 -0700 (PDT)
In-Reply-To: <20130311191801.035a7e29@zooty>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tom Horsley <horsley1953@gmail.com>, espenlund@gmail.com
Cc: anssi.hannula@iki.fi, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> See https://bugzilla.redhat.com/show_bug.cgi?id=919630
> for details.
>
>
> On my Asus P8H67-V there really are two physically
> separate audio outputs. I have the optical port
> connected to my receiver for when I want to pass
> through the 5.1 audio tracks in movie files and
> DVDs and the HDMI connected to the TV for more
> ordinary audio (error beeps from the computer, etc).

There is also internal spdif connector

>
> In kernel 3.7.9 I could output to both devices
> (one at a time - never tried simultaneous).
>
> I've seen a bunch of patches in the archives that seem
> to be related to this, but if fedora 18 has those patches,
> they don't seem to be working.

Have  you install the corresponding  alsa lib patch ?

https://launchpadlibrarian.net/133258891/alsa-info.txt.riFi7hArcI

Espen Lund mention that he need to perform early patching to change pin
default of node 0x11 to spdif  out and node 0x1e from spdif  RCA  to [N/A]
for the optical spdif  in EVGA X58 SLI Classified which have both coaxial
and optical spdif

Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x18567130: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Yellow
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x10

Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Control: name="SPDIF Phantom Jack", index=0, device=0
  Pincap 0x00000010: OUT
  Pin Default 0x01441120: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
