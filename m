From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: simple mixer API?
Date: Wed, 8 Oct 2003 00:01:43 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0310072352100.255766@kosh.hut.fi>
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
List-Id: alsa-devel@alsa-project.org

Hi. If I remember correct, a while ago there were some discussion about a
simple mixer API for ALSA. What is the current status of this?

With simple mixer API I mean some basic mixer commands that all audio
cards would perform, like volume up/down, mute, maybe others?

Maybe these simple commands could be 'mapped' to driver specific commands
in some config file. And it would be up to the user/administrator to
configure how these simple commands will be handled.

Eg. 'vol up' = 'amixer [command to rise volume]'


Tommi Uimonen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
