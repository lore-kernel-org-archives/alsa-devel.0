From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: current cvs: problems with ice1712?
Date: Tue, 15 Oct 2002 12:20:44 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210151146480.24489-100000@cmn37.stanford.edu>
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
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
List-Id: alsa-devel@alsa-project.org

Current cvs, just compiled, the sound driver seems to start fine but I get
no sound. Alsamixer cannot move the volume in the DAC sliders up from 0
(it gets to at most "2"). Same in envy24control. Envy24control reports the
following when started:

> envy24control
Unable to write volume change rate: No such file or directory
Unable to write Delta S/PDIF Output Defaults: No such file or directory
Unable to read peaks: No such file or directory
Unable to read peaks: No such file or directory
Unable to read peaks: No such file or directory
Unable to read peaks: No such file or directory
Unable to read peaks: No such file or directory

[and keeps printing the same thing over and over....]

Looks like ice1712 is currently broken :-(
-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
