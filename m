From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: ALSA CVS - pcm_oss.c:1872: BUG?
Date: Fri, 14 Apr 2006 17:48:15 -0400
Message-ID: <200604141748.15367.kernel-stuff__4473.25259815461$1145051360$gmane$org@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [216.148.227.152])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EDF17176
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 23:48:23 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I get the below BUG in dmesg once or twice a day. Running snd_hda_intel on 
2.6.16 along with yesterday's ALSA CVS. 

Parag

[17197574.124000]  [<f89d8ad3>] snd_pcm_oss_get_active_substream+0x5d/0x7e 
[snd_pcm_oss]
[17197574.124000]  [<f89d9011>] snd_pcm_oss_ioctl+0x346/0x9c9 [snd_pcm_oss]
[17197574.128000]  [<7815ca79>] do_ioctl+0x21/0x5f
[17197574.128000]  [<7815cd07>] vfs_ioctl+0x250/0x263
[17197574.128000]  [<7815cd60>] sys_ioctl+0x46/0x62
[17197574.128000]  [<78102797>] sysenter_past_esp+0x54/0x75
[17197574.128000] ALSA /root/alsa/alsa-driver/acore/oss/pcm_oss.c:1872: BUG? 
(substream != ((void *)0))
[17197574.128000]  [<f89d8376>] snd_pcm_oss_release+0x37/0xda [snd_pcm_oss]
[17197574.128000]  [<7814df15>] __fput+0x86/0x14a
[17197574.128000]  [<7814baaa>] filp_close+0x4e/0x57
[17197574.128000]  [<7814c4a7>] sys_close+0x6b/0x80
[17197574.128000]  [<78102797>] sysenter_past_esp+0x54/0x75



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
