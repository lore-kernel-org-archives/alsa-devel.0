From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem with USB headset
Date: Fri, 03 Feb 2006 12:48:03 -0500
Message-ID: <1138988883.15691.261.camel@mindpipe>
References: <43E3939A.7060002@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43E3939A.7060002@gmx.de>
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

On Fri, 2006-02-03 at 18:32 +0100, Daniel Frey wrote:
> Hello,
> 
> I have a problem with my USB headset. A short summary:
> 
> It doesn't support sample rates of 8000, but it does support 16000. Some
> applications (e.g. Ekiga) try to access it with 8000, so they fail. The
> Ekiga developer(s) think, the translation/conversion should be handled
> by ALSA.
> 
> The details can be found here:
> 
> <http://bugzilla.gnome.org/show_bug.cgi?id=329609>
> 
> Question: Is their claim valid? Should I file a bug report to ALSA?
> 

If you are getting "cannot submit datapipe for urb 0, err = -28" then it
means you MUST have enabled USB bandwidth checking.  Please make sure
it's really disabled.

Try:

$ grep CONFIG_USB_BANDWIDTH /boot/config-`uname -r`

Lee




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
