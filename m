From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Setup when compiled in 2.6 kernel
Date: Sun, 19 Feb 2006 14:00:58 -0500
Message-ID: <1140375659.2733.338.camel@mindpipe>
References: <43F8A917.8010008@dpets.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F8A917.8010008@dpets.demon.co.uk>
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

On Sun, 2006-02-19 at 17:21 +0000, John Talbut wrote:
> Am I correct in believing that the kernel will set up and communicate 
> with device files?  If so, how can I test them?  I have tried on
> various 
> devices, e.g.
> 
> >  sox -V -b -c 1 -r 448000 -t alsa /dev/snd/pcmC2D0p -t .wav test.wav
> and I get
> > ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown
> PCM /dev/snd/pcmC2D0p sox: Failed reading /dev/snd/pcmC2D0p: cannot
> open audio device
> and
>  > cat /dos/Workspace/Music/originaldedodedo.wav > /dev/snd/pcmC2D0pD
> and I get nothing. 

This is not how ALSA works, you can't just cat things to the device
file.  The interface to ALSA is through alsa-lib.

What happens if you start SIMPLE:

aplay file.wav

?



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
