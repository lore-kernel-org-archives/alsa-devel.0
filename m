From: Ryan Pavlik <rpav@mephle.com>
Subject: poll() and select()
Date: Mon, 13 Oct 2003 10:53:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031013105324.637917b0.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hey, I'm currently pondering an ALSA interface for Ruby
(http://ruby-lang.org).  Unfortunately, to do what I want, I need to
be able to have a file descriptor for select().  I've tried using the
fds returned by snd_seq_poll_descriptors(), but (not suprisingly) they
didn't work: select blocks indefinitely.

The interface would be for writing a MIDI sequencer.  Any thoughts on
the issue?

-- 
Ryan Pavlik <rpav@mephle.com>

"They don't *appear* to be in league with some
 nameless *horror* from the nether-dimensions I
 inadvertendtly pissed off by trying to enslave." - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
