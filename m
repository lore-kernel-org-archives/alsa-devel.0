From: Adam Tee <alsa@ajtee.uklinux.net>
Subject: Newbie Question
Date: Sat, 25 Jan 2003 10:24:40 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E3265E8.9060506@ajtee.uklinux.net>
Reply-To: adam@ajtee.uklinux.net, adam@ajtee.uklinux.net
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm new to alsa programming and am trying to add an alternative playback
option for denemo, a Gtk frontend for Lilypond.  At present we have code
   to playback a note immediately it is inserted to the score via the OSS
style of programming, this goes to /dev/sequencer0, but under the alsa
drivers this does not work for me, at least.

My question is should I use the sequencer api or the raw midi api??
and any tips on how to use it.

I am currently using a SBLive card and am not having much luck.



Adam
Maintainer GNU Denemo, a GTK+ frontend to GNU Lilypond




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
