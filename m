From: Per Fransson <fransson@cs.lth.se>
Subject: intel8x0 on 2.6.8.1
Date: Mon, 13 Sep 2004 01:05:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.33.0409130058460.8673-100000@ygg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I can't get sound to work with my intel8x0. I'm using kernel 2.6.8.1 which
I compiled myself and alsa-drivers-1.0.6a. The modules seem to be loaded,
but alsamixer can't find the device

# lsmod
Module                  Size  Used by
snd_intel8x0           33448  0
snd_ac97_codec         71120  1 snd_intel8x0
snd_pcm                91652  1 snd_intel8x0
snd_timer              26244  1 snd_pcm
snd_page_alloc         10632  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         8832  1 snd_intel8x0
snd_rawmidi            24100  1 snd_mpu401_uart
snd_seq_device          8712  1 snd_rawmidi
snd                    55652  7
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,sn
d_mpu401_uart,snd_rawmidi,snd_seq_device
8139too                22400  0
sr_mod                 14756  0

# alsamixer
alsamixer: function snd_ctl_open failed for default: No such device

Any ideas?


/Per



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
