From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx)
Date: Mon, 25 Nov 2002 00:12:55 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE0D057.7030707@superbug.demon.co.uk>
References: <200211170056.11190.puetzk@iastate.edu> <200211172241.14373.puetzk@iastate.edu> <3DDD75AC.9030408@cucumelo.org> <200211220935.55174.puetzk@iastate.edu> <3DDEC512.7030108@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Kevin Puetz <puetzk@iastate.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Just as a general point to note. We are not putting the audio card into AC3 mode.
We might be doing "passthru mode" or "spdif non-audio", but never just AC3 mode.
I help with the "xine" (a free media player http://xine.sf.net) that can play DVDs.
DVDs have AC3 audio tracks and DTS audio tracks.
xine uses "spdif non-audio" and "passthru mode" when used with alsa.
It can therefore output AC3 and DTS tracks to an external decoder.
Summary: -
AC3 is the wrong term to use. "spdif passthru" is probably a better term to use, as the current "ac3_mode" 
seems to imply that DTS audio might not work.
Cheers
James







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
