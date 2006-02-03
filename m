From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem with USB headset
Date: Fri, 03 Feb 2006 13:14:26 -0500
Message-ID: <1138990466.15691.279.camel@mindpipe>
References: <43E3939A.7060002@gmx.de> <1138988883.15691.261.camel@mindpipe>
	 <43E39C8C.8000409@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43E39C8C.8000409@gmx.de>
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

On Fri, 2006-02-03 at 19:10 +0100, Daniel Frey wrote:
> Lee Revell wrote:
> > On Fri, 2006-02-03 at 18:32 +0100, Daniel Frey wrote:
> > 
> > If you are getting "cannot submit datapipe for urb 0, err = -28" then it
> > means you MUST have enabled USB bandwidth checking.  Please make sure
> > it's really disabled.
> > 
> > Try:
> > 
> > $ grep CONFIG_USB_BANDWIDTH /boot/config-`uname -r`
> > 
> > Lee
> 
> daniel@nemesis:~$ grep CONFIG_USB_BANDWIDTH /boot/config-`uname -r`
> # CONFIG_USB_BANDWIDTH is not set
> daniel@nemesis:~$
> 
> OK?
> 

OK, that's completely bizarre, and I've never seen another case like it.
Also, plughw should handle all sample rate conversion, it's very strange
that alsa-lib resampling fails...

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
