From: Miha Tomsic <miha.tomsic@guest.arnes.si>
Subject: Problem with alsamixer, amixer
Date: 10 Oct 2002 17:08:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034262491.1337.230.camel@josef>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

	Hello!

This is an old problem I reported a year or so ago. 

I have SBPCI 128 with ak4531 codec. The problem is that I can't set
capture to certain channels (the channels that are using capture route
CD, Line, PCM 1) if they are muted. Or if capture is already set, muting
those channels will switch capture off.

This is happening if I am using alsamixer or amixer with sset. If I am
using amixer with cset I can set anything I want. 

I guess the problem lies in the ak4531 and the way simple controls are
handled. I don't know enough about alsa internals so poking around the
sources of alsamixer, amixer and ak4531 didn't help me understand what
should I do to make it working.

What is the relation of sset to cset ? 

Can this be addressed generally or should there be a workaround for
ak4531?

Thanks and take care,

	Miha...







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
