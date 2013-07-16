From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Tue, 16 Jul 2013 10:00:21 +0200
Message-ID: <51E4FD95.2080500@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
 <s5hvc4luem4.wl%tiwai@suse.de>
 <46b0590bfa4ffc836dde180f8ffe3c97@www.happyassassin.net>
 <s5hwqoycu0y.wl%tiwai@suse.de> <51DDD53A.8040502@gmail.com>
 <s5hbo69vf4z.wl%tiwai@suse.de> <51DE7B63.7060708@gmail.com>
 <s5hfvvlcs4o.wl%tiwai@suse.de> <51DE9D18.6010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EEE0260896
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 10:00:28 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id jc3so120111bkc.14
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 01:00:28 -0700 (PDT)
In-Reply-To: <51DE9D18.6010304@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Adam Williamson <awilliam@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 11/07/13 13:55, Tormen wrote:
> Now it applied like charme on the debian 3.9.6 kernel source :
>
> /mnt/tmp/src/linux-3.9.6 % cat 
> /tmp/0001-ALSA-hda-Add-no_multi_io-hda_gen_spec-flag.patch|patch -p1
> patching file Documentation/sound/alsa/HD-Audio.txt
> patching file sound/pci/hda/hda_generic.c
> Hunk #1 succeeded at 138 (offset -4 lines).
> Hunk #2 succeeded at 1501 (offset -43 lines).
> Hunk #3 succeeded at 1515 with fuzz 2 (offset -43 lines).
> Hunk #4 succeeded at 1543 (offset -43 lines).
> Hunk #5 succeeded at 1562 (offset -43 lines).
> patching file sound/pci/hda/hda_generic.h
> Hunk #1 succeeded at 202 with fuzz 2 (offset -18 lines).
> patching file sound/pci/hda/patch_realtek.c
> Hunk #1 succeeded at 1816 (offset -27 lines).
>
> I am compiling now and I'll let you know!
This time I did apply your patch building the debian binary packages
(because I wanted the original debian config and also the same kernel
I was testing on before, just with your patch applied)
... which took too long and then I was leaving to Paris until today.

Unfortunately I was not being able to make the sound come through the 
speakers yet.
I probably must have missed something :/

How can I make sure that the version I am using contains your patch ?
How can I make sure that your patch is active / being used ?
     I tried the hints file (see below) or can I pass this also as 
module parameter ?

So here is what I got:

=================================================
KERNEL: SMP Debian 3.9.6-1~bpo70+1 x86_64 GNU/Linux with your patch

Tested in single user mode.

# STARTING POINT: no snd* modules loaded

modprobe snd
modprobe snd_hda_intel

--> "dmesg" got this:
[ 1962.392102] snd_hda_intel 0000:00:1b.0: irq 45 for MSI/MSI-X
[ 1962.404217] hda_codec: ALC889: SKU not ready 0x411111f0
[ 1962.404460] ALSA hda_auto_parser.c:393 autoconfig: line_outs=1 
(0x14/0x0/0x0/0x0/0x0) type:speaker
[ 1962.404462] ALSA hda_auto_parser.c:397    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[ 1962.404464] ALSA hda_auto_parser.c:401    hp_outs=1 
(0x15/0x0/0x0/0x0/0x0)
[ 1962.404465] ALSA hda_auto_parser.c:402    mono: mono_out=0x0
[ 1962.404467] ALSA hda_auto_parser.c:406    inputs:
[ 1962.404468] ALSA hda_auto_parser.c:410      Mic=0x18
[ 1962.404470] ALSA hda_auto_parser.c:410      Mic=0x19
[ 1962.404471] ALSA hda_auto_parser.c:410      Internal Mic=0x12
[ 1962.404473] ALSA patch_realtek.c:486 realtek: No valid SSID, checking 
pincfg 0x411111f0 for NID 0x1d
[ 1962.404475] ALSA patch_realtek.c:569 realtek: Enable default setup 
for auto mode as fallback
[ 1962.407492] input: HDA Digital PCBeep as 
/devices/pci0000:00/0000:00:1b.0/input/input13
[ 1962.414631] input: HDA Intel MID Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[ 1962.414797] input: HDA Intel MID Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[ 1962.414893] input: HDA Intel MID Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input16

aplay bla.wav
# NO SOUND OUTPUT THROUGH SPEAKERS (but through headphone, when plugged)

root@seven /sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0 # cat 
hints
root@seven /sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0 # 
echo "multi_io = yes" > hints
root@seven /sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0 # cat 
hints
multi_io = yes
root@seven /sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0 # 
echo "1" >reconfig
root@seven /sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0 # cat 
hints
multi_io = yes

--> "dmesg" got this:
[ 2109.028690] ALSA hda_hwdep.c:221 hda-codec: reconfiguring
[ 2109.039537] hda_codec: ALC889: SKU not ready 0x411111f0
[ 2109.039975] ALSA hda_auto_parser.c:393 autoconfig: line_outs=1 
(0x14/0x0/0x0/0x0/0x0) type:speaker
[ 2109.039981] ALSA hda_auto_parser.c:397    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[ 2109.039985] ALSA hda_auto_parser.c:401    hp_outs=1 
(0x15/0x0/0x0/0x0/0x0)
[ 2109.039989] ALSA hda_auto_parser.c:402    mono: mono_out=0x0
[ 2109.039992] ALSA hda_auto_parser.c:406    inputs:
[ 2109.039996] ALSA hda_auto_parser.c:410      Mic=0x18
[ 2109.040000] ALSA hda_auto_parser.c:410      Mic=0x19
[ 2109.040004] ALSA hda_auto_parser.c:410      Internal Mic=0x12
[ 2109.040009] ALSA patch_realtek.c:486 realtek: No valid SSID, checking 
pincfg 0x411111f0 for NID 0x1d
[ 2109.040012] ALSA patch_realtek.c:569 realtek: Enable default setup 
for auto mode as fallback
[ 2109.041275] input: HDA Digital PCBeep as 
/devices/pci0000:00/0000:00:1b.0/input/input17
[ 2109.047928] input: HDA Intel MID Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[ 2109.048065] input: HDA Intel MID Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input19
[ 2109.048200] input: HDA Intel MID Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input20

aplay bla.wav
# STILL, NO SOUND OUTPUT THROUGH SPEAKERS (but through headphone, when 
plugged)
=================================================


Tormen.
