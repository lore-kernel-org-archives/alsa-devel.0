From: Martin Langer <martin-langer@gmx.de>
Subject: highest sample rate on rme32
Date: Tue, 17 Sep 2002 11:24:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020917092404.GE13567@tuba.home>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id LAA29724
	for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2002 11:17:21 +0200
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

my rme32 hardware can capture signals with 32/44.1/48 kHz and it's working
fine for 32 and 44.1 signals on input. The funny thing happened with 48kHz
on input. 

Having 48kHz at spdif-input I can record that signal with higher rates like
64/88.2/96 kHz. These commands were possible without getting error messages;
keep in mind that the hardware isn't be able to do it:

arecord -fS16_LE -c2 -r64000 /tmp/test.wav
arecord -fS16_LE -c2 -r88200 /tmp/test.wav
arecord -fS16_LE -c2 -r96000 /tmp/test.wav

And 32 and 44.1 signals doesn't allow higher sample rates for capturing. No
error occured there.

Because I haven't defined such high sample rates for capturing in rme32.c 
I think that bug is somewhere else. What about other cards? Do they have a 
similar problem or is it just rme32 specific.


thanks,
martin


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
