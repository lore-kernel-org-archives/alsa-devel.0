From: <fmoraes74@netzero.net>
Subject: Cracks during capture
Date: Thu, 10 Jun 2004 00:17:05 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040609.171735.24877.22607@webmail11.nyc.untd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from outbound20-2.nyc.untd.com (outbound20-2.nyc.untd.com [64.136.20.160])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id F1A451EC
	for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2004 02:18:29 +0200 (MEST)
Received: from outbound21-sr.nyc.untd.com (webmail11.nyc.untd.com [10.140.30.153])
	by smtpout03.nyc.untd.com with SMTP id AABANRLGCATJK8PA
	for <alsa-devel@alsa-project.org> (sender <fmoraes74@netzero.net>);
	Wed,  9 Jun 2004 17:18:10 -0700 (PDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James@superbug.demon.co.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I am trying to add capture to the emu10k1x driver based on the Audigy LS driver. It seems to be working, but when I use arecord to capture at the defaults (8Khz mono), I get some cracking sound in the capture. 

If I capture at 48Khz, the sound seems better. Any ideas/suggestions?

I am going to clean up the code a bit so that I can submit the patch with the current support.

Francisco

________________________________________________________________
The best thing to hit the Internet in years - NetZero HiSpeed!
Surf the Web up to FIVE TIMES FASTER!
Only $14.95/ month -visit www.netzero.com to sign up today!


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
