From: Daniel Frey <d.frey@gmx.de>
Subject: Re: Problem with USB headset
Date: Fri, 03 Feb 2006 19:10:20 +0100
Message-ID: <43E39C8C.8000409@gmx.de>
References: <43E3939A.7060002@gmx.de> <1138988883.15691.261.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1138988883.15691.261.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Fri, 2006-02-03 at 18:32 +0100, Daniel Frey wrote:
> 
> If you are getting "cannot submit datapipe for urb 0, err = -28" then it
> means you MUST have enabled USB bandwidth checking.  Please make sure
> it's really disabled.
> 
> Try:
> 
> $ grep CONFIG_USB_BANDWIDTH /boot/config-`uname -r`
> 
> Lee

daniel@nemesis:~$ grep CONFIG_USB_BANDWIDTH /boot/config-`uname -r`
# CONFIG_USB_BANDWIDTH is not set
daniel@nemesis:~$

OK?


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
