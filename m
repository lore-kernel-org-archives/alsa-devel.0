From: William <walsac3@liam2.demon.co.uk>
Subject: Re: [PATCH] Audigy LS driver ready for inclusion into alsa-driver.
Date: Tue, 1 Jun 2004 17:43:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406011643.RAA05581@liam2.demon.co.uk>
References: <s5h1xkzqmfm.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from liam2.demon.co.uk (liam2.demon.co.uk [158.152.170.203])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA05213
	for <alsa-devel@alsa-project.org>; Tue, 1 Jun 2004 18:39:36 +0200
In-Reply-To: <s5h1xkzqmfm.wl@alsa2.suse.de>
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
>> 
>> Experiment 2:
>> -------------
>> 
>> Load the manufacturer's Standard GM Midi file:
>>  $ asfxload /etc/synthgm.sbk 
>>  $ cat /proc/asound/card0/wavetableD*
>> Device: Emu10k1
>> Ports: 4
>> Addresses: 65:0 65:1 65:2 65:3
>> Use Counter: 0
>> Max Voices: 64
>> Allocated Voices: 0
>> Memory Size: 134217728
>> Memory Available: 134213632
> 
> only 4096 bytes (= 1 page) allocated.  i guess this file is for ROM
> soundfonts on SB AWE boards, not for SB Live/Audigy?

That's odd because the file is 34832 bytes long
(see http://christian.datzko.ch/computer/synthgm.sbk)

Why is asfxload not loading the file properly?

William


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
