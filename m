From: Jaroslav Soltys <jaroslavsoltys@yahoo.com>
Subject: a bug ? sis7012 & snd-intel8x0 & xmms & mmap switched on
Date: Fri, 2 Jan 2004 10:08:00 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040102180800.29716.qmail@web12307.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello,

i'm using alsa on my onboard sis7012 (snd-intel8x0
module). it supports only 48khz. while playing sounds
in xmms (alsa 1.2.8 output plugin) i've noticed
ticking sounds repeating in constant time intervals. i
switched off mmap and everything is fine. could that
be a bug while resampling 44khz output to 48khz when
using mmap ? maybe the bug is in xmms, but i've
heard the sound ticking also in other apps.

i compile alsa-* (driver/lib/...) from source,
everything is 1.0.0rc2. kernel is 2.4.23-1-k7 (debian
sid precompiled)

jard

ps: i'm new to mailing list, could anybody answer
this ? i'm thinking about buying pci soundcard,
possibly live! or hercules muse, are there any
possible problems with any of these ? however i'd
prefer live ;)
 

__________________________________
Do you Yahoo!?
Find out what made the Top Yahoo! Searches of 2003
http://search.yahoo.com/top2003


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
