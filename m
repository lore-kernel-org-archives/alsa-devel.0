From: Frederik Himpe <fhimpe@telenet.be>
Subject: Missing pcmC0D0p on Intel HDA with Alsa 20090327
	snapshot
Date: Fri, 3 Apr 2009 07:20:40 +0000 (UTC)
Message-ID: <gr4dc8$aph$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D7BBA10380A
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 09:55:04 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LpeEw-0004Pw-ED
	for alsa-devel@alsa-project.org; Fri, 03 Apr 2009 07:55:02 +0000
Received: from artipc9.vub.ac.be ([134.184.26.59])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 03 Apr 2009 07:55:02 +0000
Received: from fhimpe by artipc9.vub.ac.be with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 03 Apr 2009 07:55:02 +0000
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

Hi, I'm using Mandriva kernel 2.6.29-tmb-desktop-2mdv, which according to 
the changelog contains Alsa 1.0.19+ snapshot 20090327 and Alsa 1.0.19+ 
unstable addons snapshot 20090327.

With this kernel, I have no sound working on my Intel HDA device on a 
Dell Latitude E6400 system, while sound is working fine with standard 
2.6.29 kernel.

aplay gives this output:
ALSA lib pcm_dmix.c:1008:(snd_pcm_dmix_open) unable to open slave
aplay: main:590: audio open error: No such file or directory

According to strace, this is because of a missing /dev/snd/pcmC0D0p.
# ls /dev/snd
controlC0  hwC0D0  hwC0D2  seq  timer

Some dmesg related output:
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
HDA Intel 0000:00:1b.0: setting latency timer to 64
input: HDA Digital PCBeep as /class/input/input9
hda_codec: formats == 0 (nid=0x10, val=0xe07e0, ovrd=0, streams=0xe07e0)
hda_codec: cannot attach PCM stream 0 for codec #0
hda_codec: formats == 0 (nid=0x2, val=0x1e07f0, ovrd=1, streams=0x1e07f0)
hda_codec: cannot attach PCM stream 3 for codec #2
input: HDA Intel Mic at Sep Left Jack as /class/input/input10
input: HDA Intel Mic at Ext Right Jack as /class/input/input11
input: HDA Intel Line Out at Sep Left Jack as /class/input/input12
input: HDA Intel HP Out at Ext Right Jack as /class/input/input13

lspci:
00:1b.0 Audio device [0403]: Intel Corporation 82801I (ICH9 Family) HD 
Audio Controller [8086:293e] (rev 03)

# lsmod | grep snd
snd_hda_codec_intelhdmi    13856  1 
snd_hda_codec_idt      69004  1 
snd_hda_intel          29128  0 
snd_hda_codec          68864  3 
snd_hda_codec_intelhdmi,snd_hda_codec_idt,snd_hda_intel
snd_hwdep               8488  1 snd_hda_codec
snd_seq_dummy           3140  0 
snd_seq_oss            31456  0 
snd_seq_midi_event      7296  1 snd_seq_oss
snd_seq                56704  5 
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          7156  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            43392  0 
snd_pcm                80520  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              22832  2 snd_seq,snd_pcm
snd_mixer_oss          16512  1 snd_pcm_oss
snd                    65192  12 
snd_hda_codec_intelhdmi,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               7648  1 snd
snd_page_alloc          9680  2 snd_hda_intel,snd_pcm

-- 
Frederik Himpe
