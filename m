From: Ken McMillan <mcmillan@cadence.com>
Subject: audio data clipboard convention?
Date: Sat, 28 Sep 2002 19:18:27 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209281901380.30404-100000@mcmillan.cadence.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


[sorry if this is a bit off-topic]

Does anyone know if there is a convention for exchanging audio data
between X apps via cut-and-paste? I notice that Qt has a MIME-based
clipboard, so in principle you could use, e.g., type audio/x-wav to
exchange audio data, but this mechanism seems to assume that the
entire clipboard contents can be stored in memory -- not necessarily a
good assumption for audio apps. I was thinking it would be possible to
just store a URL on the clipboard, but apps would have to agree on
this convention. Do any existing audio apps actually share data
via the clipboard? If so, how is it done?

	Thanks for any enlightenment.

	Ken




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
