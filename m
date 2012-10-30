From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: macmini5,3 and imac27 ssid conflict
Date: Tue, 30 Oct 2012 20:14:25 +0800
Message-ID: <CAN8ccias7Z-fhtpAa4VKQVgTjg1kX=sTB_8Q_wC0Nk3mVcYfLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CD7E265350
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 13:14:26 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b14so97151qcs.38
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 05:14:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: hohndel@infradead.org, alsa-devel@alsa-project.org, tiwai@suse.de, j-frankish@slb.com
List-Id: alsa-devel@alsa-project.org

>>>
http://www.alsa-project.org/db/?f=5e7f45089ce82985c003fa2608bed82726ebbdf6

> > how many audio jacks do your macmini have ?
> >
> > seem only line in support jack detect, internal mic support balanced but
> > ext mic does not support jack detect
>
> There are two audio jacks:
>
> 1. An analogue headset/external speakers jack. Note that in order for the
external speakers to work, I need to use HDA Analyser to change the
settings otherwise things remain stuck on the internal speaker. I did not
try an analogue headset.

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/892697

>
> 2. An analogue line-in jack. I tried this with a powered condenser
microphone - I can hear a recording, but the level is too low for practical
use.
>
> I'm not sure there is an internal microphone connected - shouting at the
mac mini box does not produce an audible recording :P

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=6dfeb703e386369d9f1585d29482efe7b2b4401d;hp=e2301a4de22c438f5a962c7cefc3e9cba736991c

Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1c20 (rev 05)
Subsystem: 8086:7270

your macmini pci subsystem is also 8086:7270 which is same as imac27

the pin default of your macmini (init_pin_config) is replaced by the pin
config of model imac27 (driver_pin_config)

Codec: Cirrus Logic CS4206
Address: 0 AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10134206
Subsystem Id: 0x106b2100

is the subsystem id in codec unique ?

Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x09 0x400000f0
0x0a 0x002b4040
0x0b 0x90100130
0x0c 0x018b3020
0x0d 0x90a00110
0x0e 0x400000f0
0x0f 0x01cbe030
0x10 0x014be060
0x12 0x01ab9070
0x15 0x400000f0

/sys/class/sound/hwC0D0/driver_pin_configs:
0x09 0x012b4050
0x0a 0x90100140
0x0b 0x90100142
0x0c 0x018b3020
0x0d 0x90a00110
0x0e 0x400000f0
0x0f 0x01cbe030
0x10 0x014be060
0x12 0x01ab9070
0x15 0x400000f0

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:
