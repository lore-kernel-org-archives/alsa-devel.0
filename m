From: William <walsac3@liam2.demon.co.uk>
Subject: [PATCH] Audigy LS driver ready for inclusion into alsa-driver.
Date: Tue, 1 Jun 2004 14:23:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406011323.OAA04070@liam2.demon.co.uk>
References: <40BC74BE.2090502@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from liam2.demon.co.uk (liam2.demon.co.uk [158.152.170.203])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA00945
	for <alsa-devel@alsa-project.org>; Tue, 1 Jun 2004 15:20:08 +0200
In-Reply-To: <40BC74BE.2090502@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
>
> Audigy LS driver is now ready for inclusion into alsa-driver.
> Get it from http://www.superbug.demon.co.uk/alsa

Are you going to work on any other Audigy-series drivers, e.g. Audigy 2 ZS?
I'm finding the emu10k1 driver in alsa-driver-1.0.5a has serious problems
with random intermittent distortion of the soundfont samples while they are
being played on the soundcard's MIDI synthesiser, e.g. using aplaymidi -p 65:0.
"Random intermittent distortion" means, e.g. the sound during MIDI playback
becomes "muffled" for a minute or two and then returns to normal sound quality,
or the sound wrongly becomes mono for a few seconds, and then
returns to stereo.
Also, it seems emu10k1 does not load soundfonts correctly,
especially if you ever use any really large 25MB soundfonts.

William



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
