From: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Subject: Q: RTP streaming via dummy sound driver?
Date: Fri, 25 Oct 2002 13:10:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210251310020.15314-100000@musette.kom.e-technik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
List-Id: alsa-devel@alsa-project.org

Hello,

though i've been looking through the archives and tried using google i
have not found hints on the following problem / approach.

  - Is there a way to extend the alsa dummy soundcard module (or a
    comparable) mechanism to
     - stream audio data (both reading and writing) to another
       host using RTP ?
     - doing the same for a Bluetooth link towards a bluetooth
       headset ?

i'm currently busy doing the later (trying to make BT audio available to
standard applications just using the /dev/dsp interface) and have a couple
of scenarios where using the generic
	application <=> /dev/dsp <= RTP => other host
would be very helpful (and potential drawbacks like increased delay etc.
can be accepted / neglected).

Any further hints/links on this topic are appreciated!

best regards
 ralf

--
Best regards,
 Ralf Ackermann

---------------------------------------------------------------
 Hosting the IP Telephony Field Trial for the Darmstadt Region
---------------------------------------------------------------
Ralf Ackermann                _         rac@KOM.tu-darmstadt.de
Multimedia Communications |/ | | |\/|           Merckstrasse 25
                          |\ |_| |  |  64283 Darmstadt, Germany
Tel.: (+49) 6151 16-6138                Fax: (+49) 6151 16-6152
---------------------------------------------------------------
          http://www.kom.e-technik.tu-darmstadt.de/~rac
---------------------------------------------------------------




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
