From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: What exactly is module snd-hdsnd-hda-intel
Date: Wed, 24 Dec 2008 18:16:12 +0100
Message-ID: <200812241816.12765.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 96673243BE
	for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2008 18:16:39 +0100 (CET)
Received: from [192.168.0.230] (213.36.148.109) by mail.libertysurf.net
	(7.3.118.8) id 493FA978003877F7 for alsa-devel@alsa-project.org;
	Wed, 24 Dec 2008 19:26:41 +0100
Content-Disposition: inline
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

I see someone that had sounds working on a Thinkpad T61, but sounds have 
recently stopped working. The module snd-hdsnd-hda-intel is listed on his 
lsmod output as below. I've never seen such a module before. Any info on what 
this module is?

lsmod | grep snd_hda_intel returns:

snd_hdsnd_hda_intel         324248  2
snd_pcm                62596  2 snd_pcm_oss,snd_hda_intel
snd                    45604  12
snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_pcm,snd_seq_oss,snd_seq,snd_timer,snd_seq_device
snd_page_alloc          7816  2 snd_hda_intel,snd_pcm
a_intel         324248  2
snd_pcm                62596  2 snd_pcm_oss,snd_hda_intel
snd                    45604  12
snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_pcm,snd_seq_oss,snd_seq,snd_timer,snd_seq_device
snd_page_alloc          7816  2 snd_hda_intel,snd_pcm


This is on a Debian Lenny install, using kernel 2.6.26-1-686, and alsa driver 
version 1.0.16. Codec is AD1984.

His soundcard is detected ok, as below.

$ cat /proc/asound/cards
0 [Intel          ]: HDA-Intel - HDA Intel
                     HDA Intel at 0xfe020000 irq 17

This is only out of academic interest, but as modinfo shows no such module, 
I'm really puzzled how a non existing module can be loaded.

Nigel.
