From: Ryan Hughes <rjhughes@iheartryan.com>
Subject: Bizarre ATI SB450 behavior
Date: Thu, 6 Sep 2007 21:43:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0709062122080.12004@refresco.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smarty.dreamhost.com (smarty.dreamhost.com [208.113.175.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F4C4103844
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 06:44:09 +0200 (CEST)
Received: from refresco.dreamhost.com (refresco.dreamhost.com [208.113.171.10])
	by smarty.dreamhost.com (Postfix) with ESMTP id F2DA5EE2B5
	for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2007 21:43:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by refresco.dreamhost.com (Postfix) with ESMTP id 046EAA45A6
	for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2007 21:43:51 -0700 (PDT)
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

Hi.  I've got a little situation over here.

Every time I poll any software, it totally believes that the sound-card is 
installed and configured correctly and working.  Nobody complains.  But 
when I try to play sound, none comes out.  People usually suggest the 
alsamixer, to make sure none of my channels are muted.  Truly, none of 
them are muted.

Here's the vital stats:


lspci | grep -i audio
00:14.2 Audio device: ATI Technologies Inc SB450 HDA Audio (rev 01)


aplay -l
card 0: SB [HDA ATI SB], device 0: STAC92xx Analog [STAC92xx Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0


lsmod | grep snd
snd_hda_intel         262424  1
snd_pcm_oss            44672  0
snd_mixer_oss          17792  1 snd_pcm_oss
snd_pcm                80900  2 snd_hda_intel,snd_pcm_oss
snd_seq_dummy           4996  0
snd_seq_oss            35072  0
snd_seq_midi            9728  0
snd_rawmidi            25984  1 snd_seq_midi
snd_seq_midi_event      8576  2 snd_seq_oss,snd_seq_midi
snd_seq                54000  6 
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              24196  2 snd_pcm,snd_seq
snd_seq_device          9612  5 
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    56324  12 
snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_dummy,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore               8672  1 snd
snd_page_alloc         11272  2 snd_hda_intel,snd_pcm


Interesting pieces of dmesg
[   22.061858] ALSA 
/usr/src/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hd
a/patch_si3054.c:244: si3054: cannot initialize. EXT MID = 0000
[   48.948578] hda-intel: Invalid position buffer, using LPIB read method 
instea
d.


Am I missing any useful info?
Kernel is 2.6.20-16

Alsa is a hand-compiled 1.0.14.

Thanks.
--Ryan
