From: William <walsac3@liam2.demon.co.uk>
Subject: Re: [PATCH] Audigy LS driver ready for inclusion into alsa-driver.
Date: Tue, 1 Jun 2004 16:33:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406011533.QAA04999@liam2.demon.co.uk>
References: <40BC9644.1040703@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from liam2.demon.co.uk (liam2.demon.co.uk [158.152.170.203])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA03840
	for <alsa-devel@alsa-project.org>; Tue, 1 Jun 2004 17:30:19 +0200
In-Reply-To: <40BC9644.1040703@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I have played some .mid files now, but I have not noticed any problems 
> with my Audigy 2.
> 
> When I downloaded the fonts file, mine had a different name to yours.
> Yours: WST25FStein_00Aug14.SF2
> Mine: WST25FStein_00Sep22.SF2

It makes no difference which of these two soundfonts is used.

> Can you provide me with a .mid file that shows the problems and is easy 
> to reproduce the problems?

As I said in my original email, the sound distortion problem is intermittent.
I haven't found a way to reproduce it.  However, if I use emu10k1 for MIDI
I usually encounter the sound distortion problem at least once every hour or so.
It seems to be a driver problem; it's not dependent on a particular MIDI file.

Steve Conrad was the first to mention an emu10k1 problem with soundfonts:
https://sourceforge.net/mailarchive/message.php?msg_id=7897993
The soundfont problem seems to occur whenever I first load the 25MB piano
soundfont and then later load the manufacturer's synthgm.sbk
soundfont (http://christian.datzko.ch/computer/synthgm.sbk).
Many but not all instruments are silent (piano usually works).

William


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
