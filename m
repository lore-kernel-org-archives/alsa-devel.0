From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Setup when compiled in 2.6 kernel
Date: Sun, 19 Feb 2006 14:53:56 -0500
Message-ID: <1140378836.2733.357.camel@mindpipe>
References: <43F8A917.8010008@dpets.demon.co.uk>
	 <1140375659.2733.338.camel@mindpipe>  <43F8CB22.4060202@dpets.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F8CB22.4060202@dpets.demon.co.uk>
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

On Sun, 2006-02-19 at 19:46 +0000, John Talbut wrote:
> Thanks, Lee
> 
> Lee Revell wrote:
> 
> > This is not how ALSA works, you can't just cat things to the device
> > file.  The interface to ALSA is through alsa-lib.
> 
> Can you or anyone explain this, or point to an explanation?

What's to explain?  Userspace apps don't access the device files
directly.  They should use the alsa-lib API.  Here is the documentation:

http://www.alsa-project.org/alsa-doc/alsa-lib/

> > 
> > What happens if you start SIMPLE:
> > 
> > aplay file.wav
> 
> # aplay /dos/Workspace/Music/originaldedodedo.wav
> ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default
> aplay: main:544: audio open error: No such file or directory
> 


Because it defaults to device 0 which is usually a real soundcard, but
not on your system:

/proc/asound/cards:

0 [Dummy          ]: Dummy - Dummy
                      Dummy 1
1 [VirMIDI        ]: VirMIDI - VirMIDI
                      Virtual MIDI Card 1
2 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                      Ensoniq AudioPCI ENS1371 at 0xdf00, irq 10

Try unloading the snd-dummy and snd-virmidi modules, or don't enable
them when compiling the kernel.

Did you try this first with your distro's default kernel before building
your own?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
