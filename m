From: <fmoraes74@netzero.net>
Subject: Re: Cracks during capture
Date: Mon, 14 Jun 2004 17:59:55 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040614.110027.2698.132393@webmail20.nyc.untd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from outbound20-2.nyc.untd.com (outbound20-2.nyc.untd.com [64.136.20.160])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 1F32E311
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2004 20:01:16 +0200 (MEST)
Received: from outbound21-sr.nyc.untd.com (webmail20.nyc.untd.com [10.140.30.162])
	by smtpout01.nyc.untd.com with SMTP id AABAN5384A5JVF92
	for <alsa-devel@alsa-project.org> (sender <fmoraes74@netzero.net>);
	Mon, 14 Jun 2004 11:00:58 -0700 (PDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Anyone? It seems a problem in alsa-lib when converting from 48Khz to 8Khz but I'd like to hear some opinions/suggestions.

Francisco

-- <fmoraes74@netzero.net> wrote:

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
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


________________________________________________________________
The best thing to hit the Internet in years - NetZero HiSpeed!
Surf the Web up to FIVE TIMES FASTER!
Only $14.95/ month -visit www.netzero.com to sign up today!


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
