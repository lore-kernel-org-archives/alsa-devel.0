From: Richard Bown <bownie@bownie.com>
Subject: alsa sequencer: note interface
Date: Mon, 14 Oct 2002 17:16:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210141716.17222.bownie@bownie.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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

A question - if you're sending a load of MIDI notes (as opposed to 
noteons/noteoffs) with very long duration and to curtail these notes 
you're sending notes with shorter (finite if you like) duration to same 
channel/pitch should the longer ones clear down from ALSA and get cast 
away?

At the moment I can get the notes to stop sounding correctly but after 
playing more notes for a while (and everything sounding fine) the 
sequencer just eventually stops accepting any more notes for playback 
presumably because the original long notes are still hanging around in 
a buffer somewhere.

Thoughts?

B
-- 
Rosegarden.  Music Software For Linux
http://www.all-day-breakfast.com/rosegarden


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
