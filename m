From: William <walsac3@liam2.demon.co.uk>
Subject: Re: [PATCH] Audigy LS driver ready for inclusion into alsa-driver.
Date: Tue, 1 Jun 2004 18:02:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406011702.SAA05765@liam2.demon.co.uk>
References: <s5hzn7np6vi.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from liam2.demon.co.uk (liam2.demon.co.uk [158.152.170.203])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA05554
	for <alsa-devel@alsa-project.org>; Tue, 1 Jun 2004 18:58:53 +0200
In-Reply-To: <s5hzn7np6vi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> William wrote:
>> Takashi Iwai wrote:
>> > 
>> > only 4096 bytes (= 1 page) allocated.  i guess this file is for ROM
>> > soundfonts on SB AWE boards, not for SB Live/Audigy?
>> 
>> That's odd because the file is 34832 bytes long
>> (see http://christian.datzko.ch/computer/synthgm.sbk)
> 
> a soundfonts file includes not only the wave data but also the
> instrument layer meta data.  in the case of ROM fonts, it includes
> only meta data.

So, the problem is that synthgm.sbk has meta data but not wave data.
I can't see any option in asfxload to check whether a soundfont file
has meta data only or both wave data and meta data.
It would be useful.  alsa-utils / alsa-tools also don't seem to have
anything for checking this.

>> Why is asfxload not loading the file properly?
> 
> it does :)

It would be nicer if asfxload gave a warning when the soundfont only
has meta data and the soundcard does not have any ROM soundfont.

William


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
