From: Ryan Pavlik <rpav@mephle.com>
Subject: ALSA sequencer changes?
Date: Sat, 13 Dec 2003 18:00:15 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031213180015.0df3994f.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hrm, I've recently updated ALSA after a few weeks of inactivity, and
suddenly I'm not getting MIDI events from simple code that previously
worked.  I don't see any alsa-devel messages about changes, but I
apparently missed the PCM API change notice.  In addition to the more
complex library, I tried my test code which you can find here:

    http://ogmo.mephle.org/test-alsa.c

The problem isn't getting 0's for time (got that one sorted awhile
back, but never integrated the fix)---the problem is I'm not getting
anything.

Anyhow, just wondering what's new or different, or if it's something
else I missed.

thanks,

-- 
Ryan Pavlik <rpav@mephle.com>

"If it were possible to combine my evil with
 spider-man's powers..." - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
