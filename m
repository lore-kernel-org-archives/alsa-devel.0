From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Setup when compiled in 2.6 kernel
Date: Sun, 19 Feb 2006 16:52:38 -0500
Message-ID: <1140385958.2733.397.camel@mindpipe>
References: <43F8A917.8010008@dpets.demon.co.uk>
	 <1140375659.2733.338.camel@mindpipe>  <43F8CB22.4060202@dpets.demon.co.uk>
	 <1140378836.2733.357.camel@mindpipe>  <43F8E781.4030802@dpets.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F8E781.4030802@dpets.demon.co.uk>
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

On Sun, 2006-02-19 at 21:47 +0000, John Talbut wrote:
> Is there any way of testing whether this is the/a problem before I 
> recompile the kernel?  I will have to upgrade it when I recompile
> (2.6.8 
> does not compile with gcc-4.0, which is what I have now.) 

aplay -D default:2 file.wav should work.

If you won't use modules for whatever reason, you have to pass kernel
command line parameters to get your real soundcard to be device 0.

Easiest way is just use modules and load snd-ens1371 first

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
