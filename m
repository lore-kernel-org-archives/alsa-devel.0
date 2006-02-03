From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Problem with USB headset
Date: Fri, 03 Feb 2006 14:16:00 -0500
Message-ID: <1138994161.554.3.camel@mindpipe>
References: <43E3939A.7060002@gmx.de> <1138988883.15691.261.camel@mindpipe>
	 <43E39C8C.8000409@gmx.de> <1138990466.15691.279.camel@mindpipe>
	 <43E3A7A6.8090004@gmx.de>  <43E3AAA0.7030505@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43E3AAA0.7030505@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Frey <d.frey@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-02-03 at 20:10 +0100, Daniel Frey wrote:
> Daniel Frey wrote:
> > I guess it can only handle sample rate conversion when it knows that it
> > has to do sample rate conversion. So, maybe the hardware reports the
> > wrong sample rates?
> 
> Seconds after I wrote that, I had another idea. I plugged the headset
> out of the monitor's hub and into the PC directly. Now it does work with
> 8000. Obviously, that's just a work-around, not a solution. And I'm not
> sure what that means for you, though :)

Bug in the USB subsystem, probably.  Try the latest kernel.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
