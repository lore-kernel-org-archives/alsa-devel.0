From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Setup when compiled in 2.6 kernel
Date: Mon, 20 Feb 2006 09:21:37 +0100
Message-ID: <20060220082137.GA12595@ifiu25.informatik.uni-halle.de>
References: <43F8A917.8010008@dpets.demon.co.uk>
 <1140375659.2733.338.camel@mindpipe> <43F8CB22.4060202@dpets.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43F8CB22.4060202@dpets.demon.co.uk>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Talbut <john@dpets.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

John Talbut wrote:
> # aplay /dos/Workspace/Music/originaldedodedo.wav
> ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default

It seems alsa-lib isn't installed correctly.

Please try to compile+install the latest alsa-lib and alsa-utils
packages.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
