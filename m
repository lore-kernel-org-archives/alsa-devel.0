From: Sergey 'Jin' Bostandzhyan <jin@deadlock.dhs.org>
Subject: Re: Acer Aspire 8920g / snd-hda-intel / ALC889 /
	surround sound
Date: Mon, 5 Jan 2009 21:17:22 +0100
Message-ID: <20090105201722.GA23503@deadlock.dhs.org>
References: <20081225192456.GA16788@deadlock.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from belief.htu.tuwien.ac.at (belief.htu.tuwien.ac.at
	[128.131.95.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 9878410380B
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 21:17:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081225192456.GA16788@deadlock.dhs.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

While waiting for an answer I continued my attempts to get this to work, 
unfortunately without success.

I tried all models from patch_realtek.c (alsa version 1.0.18a), umuting the
channels with alsa mixer and running speaker test on each model selection - 
but no luck with surround there.

I also tried hda_analyzer from 
http://git.alsa-project.org/?p=alsa.git;a=tree;f=hda-analyzer;hb=HEAD

run.py downloaded hda_analyzer.py and hda_codec.py which bailed out with
an error:
Downloaded all files, executing hda_analyzer.py
Traceback (most recent call last):
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 906, in <module>
    main()
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 893, in main
    if read_nodes() == 0:
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 46, in read_nodes
    read_nodes2(c.card, i)
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 36, in read_nodes2
    c.analyze()
  File "/dev/shm/hda-analyzer/hda_codec.py", line 821, in analyze
    pcm = self.param_read(self.afg, PARAMS['PCM'])
  File "/dev/shm/hda-analyzer/hda_codec.py", line 745, in param_read
    return self.rw(nid, VERBS['PARAMETERS'], param)
  File "/dev/shm/hda-analyzer/hda_codec.py", line 730, in rw
    verb = (nid << 24) | (verb << 8) | param
TypeError: unsupported operand type(s) for <<: 'NoneType' and 'int'

I am not sure if this is OK, but I patched hda_codec.py and was able to
proceed.

--- hda-analyzer/hda_codec.py   2009-01-05 21:11:33.672001401 +0100
+++ /tmp/hda-analyzer/hda_codec.py 2009-01-05 21:13:13.000000000 +0100
@@ -727,6 +727,8 @@
 
   def rw(self, nid, verb, param):
     """do elementary read/write operation"""
+    if not nid:
+        nid = 0
     verb = (nid << 24) | (verb << 8) | param
     res = ioctl(self.fd, IOCTL_VERB_WRITE, struct.pack('II', verb, 0))
     return struct.unpack('II', res)[1]

I spent quite some time with hda_analyzer but was not able to produce any
useful results.

So at this point I am really stuck. Can anyone suggest what I could try
next? How to proceed?

Kind regards,
Jin


On Thu, Dec 25, 2008 at 08:24:56PM +0100, Sergey 'Jin' Bostandzhyan wrote:
> Hi,
> 
> there's been a thread about a similar issue around 2008-04, it ended with a
> working front left/right setup, which is of course better than no sound, but
> it would be really nice to be able to use all available speakers.
> 
> The notebook has 5.1 surround, but all speakers except front left and front
> right stay silent.
> 
> I'm running Fedora 10, 2.6.27.9-159.fc10.x86_64,
> 
> # cat /proc/asound/version 
> Advanced Linux Sound Architecture Driver Version 1.0.18a.
> 
> # cat /proc/asound/cards 
>  0 [Intel          ]: HDA-Intel - HDA Intel
>                       HDA Intel at 0xfc300000 irq 22
>  1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
>                       HDA ATI HDMI at 0xc7eec000 irq 17
> 
> When I select model "auto", then I get a working front left and front right
> speaker. When I select model "acer-aspire", everything is mute and I have
> to use the hda-verb utility to get some sound out of the front speakers, so 
> right now I am using the "auto" option.
> 
> I see a segfault in alsactl when I look at dmesg, not sure if this is
> related to the problem:
> 
> HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> HDA Intel 0000:00:1b.0: setting latency timer to 64
> ALSA sound/pci/hda/hda_codec.c:2587: hda_codec: model 'auto' is selected
> ALSA sound/pci/hda/hda_codec.c:3303: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
> ALSA sound/pci/hda/hda_codec.c:3307:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> ALSA sound/pci/hda/hda_codec.c:3311:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> ALSA sound/pci/hda/hda_codec.c:3312:    mono: mono_out=0x0
> ALSA sound/pci/hda/hda_codec.c:3320:    inputs: mic=0x12, fmic=0x18, line=0x1a, fline=0x0, cd=0x0, aux=0x0
> HDA Intel 0000:01:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
> HDA Intel 0000:01:00.1: setting latency timer to 64
> alsactl[1631]: segfault at 0 ip 00000000004106e7 sp 00007fffb7682fa0 error 4 in alsactl[400000+14000]
> alsactl[1624]: segfault at 0 ip 00000000004106e7 sp 00007fff4ba9e3c0 error 4 in alsactl[400000+14000]
> 
> The full output of the alsa-info script is here:
> http://www.alsa-project.org/db/?f=405364959a8f52c85f045f35fa1f3bf4536b13bc
> 
> I have a working setup to compile the alsa-driver, so I'm ready to test
> whatever is needed :) Any ideas?
> 
> Kind regards,
> Jin
> 
