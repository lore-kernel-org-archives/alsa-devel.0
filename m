From: Paul Davis <pbd@op.net>
Subject: double speed (ADAT), and hw params ordering
Date: Thu, 18 Jul 2002 14:58:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207181858.g6IIw7D01719@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA12110
	for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2002 20:56:17 +0200
Received: from unknown (HELO op.net) ([209.92.61.119]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 18 Jul 2002 18:56:11 -0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

i've been wondering what to do about setting sample rates in the
hammerfall and h-dsp drivers. fernando and gary from CCRMA have made
the excellent suggestion that rather than have the driver pretend that
all rates are available all the time, as it currently does, that we
have a control switch to go between regular rates and the "double
speed" or "bitsplit" rates (64kHz-96kHz) which reduce the channel
count.  i think this is an excellent idea. you would not be able to
use the switch while the device was open. when you opened it, you
would find (for example) a device with 14 channels (12 ADAT plus 2
SPDIF) at 64-96kHz or 26 channels (24 ADAT+2 SPDIF) at 32-48kHz.

if anyone objects to this model, please let me know. right now, its
more or less impossible to get access to the higher rates.

on a related note, although the above suggestion will fix this
particular problem, it seems that it might be wise to consider adding
a parameter order information field to the driver API, so that drivers
can say "you have to set param P first, then param N, then param
O". the default would obviously be "don't care", but for devices that
lose certain capabilities when certain parameters are set, it would
make things very much easier.

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
