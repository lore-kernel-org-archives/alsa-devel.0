From: John Talbut <john@dpets.demon.co.uk>
Subject: Re: Setup when compiled in 2.6 kernel
Date: Mon, 20 Feb 2006 07:13:53 +0000
Message-ID: <43F96C31.9050901@dpets.demon.co.uk>
References: <43F8A917.8010008@dpets.demon.co.uk>	 <1140375659.2733.338.camel@mindpipe>  <43F8CB22.4060202@dpets.demon.co.uk>	 <1140378836.2733.357.camel@mindpipe>  <43F8E781.4030802@dpets.demon.co.uk> <1140385958.2733.397.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1140385958.2733.397.camel@mindpipe>
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
> aplay -D default:2 file.wav should work.
> 
# aplay -D default:2 /dos/Workspace/Music/originaldedodedo.wav
ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default:2
aplay: main:544: audio open error: No such file or directory

also

# aplay -L
  aplay: conf.c:3109: snd_config_update_free: Assertion `update->count > 
0 && update->finfo' failed.
  Aborted

What next?

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
