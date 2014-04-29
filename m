From: Ronald <ronald645@gmail.com>
Subject: Re: v3.15-rc1: CORB reset timeout#1, CORBRP = 0
Date: Tue, 29 Apr 2014 17:08:25 +0200
Message-ID: <CAF1_xX3jYgCp-prVrcfABz=kjH7xhpE+kUikCPJKSBYQrcOu9g@mail.gmail.com>
References: <CAF1_xX2uRcHHeRd1Zpxa30KveP94Ot7WQk5ut0kopARZVBRVjg@mail.gmail.com>
 <s5hioptbh7i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 214962651A0
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 17:08:27 +0200 (CEST)
Received: by mail-qg0-f42.google.com with SMTP id i50so385160qgf.1
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 08:08:26 -0700 (PDT)
In-Reply-To: <s5hioptbh7i.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I take it you want the vendor:device id, but since you have requested
additional info I have provided some more data. Please let me know if
I missed anything you require. Thank you.

Below you will find lspci. I have used the alsa-info.sh script for the
rest (how convenient!):

http://www.alsa-project.org/db/?f=daf13e17122d2db2851591b4d79d3ac34fabf864

00:10.1 Audio device [0403]: NVIDIA Corporation MCP51 High Definition
Audio [10de:026c] (rev a2)
    Subsystem: Hewlett-Packard Company Presario V6133CL [103c:30b7]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (500ns min, 1250ns max)
    Interrupt: pin B routed to IRQ 21
    Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Address: 0000000000000000  Data: 0000
        Masking: 00000000  Pending: 00000000
    Capabilities: [6c] HyperTransport: MSI Mapping Enable- Fixed+
    Kernel driver in use: snd_hda_intel


2014-04-28 17:34 GMT+02:00 Takashi Iwai <tiwai@suse.de>:
> At Wed, 16 Apr 2014 10:30:13 +0200,
> Ronald wrote:
>>
>> Just rebuild v3.15. The message in the subject appears to be at the
>> error level. Sound plays fine. Everything seems to work as intended.
>>
>> [    6.779741] snd_hda_intel 0000:00:10.1: Disabling MSI
>> [    6.781978] ALSA device list:
>> [    6.781980]   No soundcards found.
>> [    6.785907] snd_hda_intel 0000:00:10.1: CORB reset timeout#1, CORBRP = 0
>> [    7.670040] sound hdaudioC0D0: autoconfig: line_outs=1
>> (0x10/0x0/0x0/0x0/0x0) type:speaker
>> [    7.670046] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> [    7.670049] sound hdaudioC0D0:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
>> [    7.670052] sound hdaudioC0D0:    mono: mono_out=0x0
>> [    7.670055] sound hdaudioC0D0:    dig-out=0x13/0x0
>> [    7.670057] sound hdaudioC0D0:    inputs:
>> [    7.670060] sound hdaudioC0D0:      Mic=0x14
>> [    8.730734] input: HDA Digital PCBeep as
>> /devices/pci0000:00/0000:00:10.1/sound/card0/hdaudioC0D0/input10
>> [    8.731256] input: HDA NVidia Front Headphone as
>> /devices/pci0000:00/0000:00:10.1/sound/card0/input11
>>
>> Is this reason for concern?
>
> This comes from the commit ca460f86521ed515d17dd1314f7b95183866f681
>     ALSA: hda - Fix CORB reset to follow specification
>
> I guess it's a non-standard behavior of Nvidia controller.  The write
> to these bits are likely ignored, so it's mostly harmless.
>
> For avoiding the confusion, we may need to paper over the changed
> reset procedure for such chips.  Could you give the specific of your
> hardware, especially about this HD-audio controller chip?
>
>
> thanks,
>
> Takashi
