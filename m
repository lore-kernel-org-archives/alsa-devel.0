From: arromdee@rahul.net (Ken Arromdee)
Subject: My Continuing AD1816a problems
Date: Tue, 19 Feb 2002 00:58:32 -0500 (EST)
Message-ID: <20020219055832.A51DE636A1@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just downloaded and tried pmidi (Alsa midi player).  pmidi works.
playmidi -e still usually fails (it's worked intermittently a couple of
times), and even fails right after running pmidi.

So my problem is probably in the OSS emulation.

Oddly, this is the reverse of the problem I've had with regular sound, where
play (OSS) works, but aplay (Alsa) doesn't (it adds a split second of repeated
sound at the end).

I hope someone out there can help fix my problems, because I know nothing
about Alsa development myself.  (Incidentally, does everyone else out there
have working playmidi -e and aplay?)

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
