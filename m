From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: current cvs: problems with ice1712?
Date: Tue, 15 Oct 2002 22:20:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210152220170.703-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0210151146480.24489-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0210151146480.24489-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 15 Oct 2002, Fernando Pablo Lopez-Lezcano wrote:

> Current cvs, just compiled, the sound driver seems to start fine but I get
> no sound. Alsamixer cannot move the volume in the DAC sliders up from 0
> (it gets to at most "2"). Same in envy24control. Envy24control reports the
> following when started:
> 
> > envy24control
> Unable to write volume change rate: No such file or directory
> Unable to write Delta S/PDIF Output Defaults: No such file or directory
> Unable to read peaks: No such file or directory
> Unable to read peaks: No such file or directory
> Unable to read peaks: No such file or directory
> Unable to read peaks: No such file or directory
> Unable to read peaks: No such file or directory
> 
> [and keeps printing the same thing over and over....]
> 
> Looks like ice1712 is currently broken :-(

Everything seems broken ;-( Try CVS again. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
