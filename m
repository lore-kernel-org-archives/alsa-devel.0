From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Enable SPDIF input recording on ALC650 AC97
 codecs. Works for PCM and AC3.
Date: Sat, 06 Sep 2003 03:23:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F594519.3040505@superbug.demon.co.uk>
References: <3F50D59D.2070802@superbug.demon.co.uk> <s5hbru4rg0m.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA17258
	for <alsa-devel@alsa-project.org>; Sat, 6 Sep 2003 04:21:39 +0200
In-Reply-To: <s5hbru4rg0m.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 30 Aug 2003 17:49:33 +0100,
> James Courtier-Dutton wrote:
> 
>>[1  <text/plain; us-ascii (7bit)>]
>>Patch attached.
>>This patch enables the SPDIF input of the Realtek ALC650 chip which is 
>>an AC97 compatible chip.
>>It also adds some data into the proc file system ac97 
>>/proc/asound/card0/ac97#0 file so one can see if the SPDIF is locked or not.
>>
>>I can now record AC3 non-audio data from an Optical SPDIF socket on my 
>>Motherboard.
>>
>>This only works for ALC650 Rev.E or above, so I guess I should really 
>>check for that.
> 
> 
> thanks, i applied to cvs with a little modification.
> 
> 
> Takashi
> 
> 
I have just looked at the modification. Was there a reason to remove the 
ac97_proc.c patches ?
It was useful seeing if the SPDIF input was locked or not, and which 
bits were set.

Cheers
James





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
