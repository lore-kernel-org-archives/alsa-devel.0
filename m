From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: I have found a reason why dmix does not work well
 with xine.
Date: Wed, 4 Feb 2004 19:33:46 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402041927280.1863@pnote.perex-int.cz>
References: <40203EE8.3060107@superbug.demon.co.uk>
 <Pine.LNX.4.58.0402040847590.1863@pnote.perex-int.cz> <4020ED67.2020405@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4020ED67.2020405@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 4 Feb 2004, James Courtier-Dutton wrote:

> > 
> > 
> > Did you some tests with xine and 1.0.2 libraries? I tried to fix all 
> > problems related to xine there (including the last reported problem from 
> > you).
> > 
> > The delay values might be affected by this issue: The dmix plugin can
> > start in the middle of period of the "master" (hw:x device). In this case,
> > the pointers of the master pcm are updated at different point - from the
> > dmix look - than the exclusive device does. You can avoid this problem
> > using the new "slowptr" option - in this case are pointers synced at each
> > r/w/status operation, but it adds an extra overhead. Anyway, my tests
> > shows that xine works well also without this option (and I used USB device
> > for tests which does also additional buffering in the kernel driver so it
> > more problematic than standard soundcards).
> > 
> > 						Jaroslav
> > 
> 
> I upgraded to latest alsa-lib cvs. Mixed results. :-(
> I have found a new problem.
> It seems to be fairly random as to which applications work, and which do 
> not.

I had also mixed debugging ;-(

You had a bug in your code (phase was not preserved during write_loop()  
calls) - it took me some time to find this bug. And I had a serious bug in
recoded rate plugin which was available in CVS for a few hours. It should
be ok now (in CVS).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
