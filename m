From: John Talbut <john@dpets.demon.co.uk>
Subject: Re: Setup when compiled in 2.6 kernel
Date: Sun, 19 Feb 2006 21:47:45 +0000
Message-ID: <43F8E781.4030802@dpets.demon.co.uk>
References: <43F8A917.8010008@dpets.demon.co.uk>	 <1140375659.2733.338.camel@mindpipe>  <43F8CB22.4060202@dpets.demon.co.uk> <1140378836.2733.357.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1140378836.2733.357.camel@mindpipe>
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

>>
>>>This is not how ALSA works, you can't just cat things to the device
>>>file.  The interface to ALSA is through alsa-lib.
>>
>>Can you or anyone explain this, or point to an explanation?
> 
> 
> What's to explain?

Well, some other devices can be checked to see if they are working by 
cat-ing to them.  It seems as if these are different.

>  Userspace apps don't access the device files
> directly.  They should use the alsa-lib API.  Here is the documentation:
> 
> http://www.alsa-project.org/alsa-doc/alsa-lib/

Thanks for that, I guess the answer is there, I will study it more when 
I get a moment.
> 
>>>What happens if you start SIMPLE:
>>>
>>>aplay file.wav
>>
>># aplay /dos/Workspace/Music/originaldedodedo.wav
>>ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default
>>aplay: main:544: audio open error: No such file or directory
>>
> 
> 
> 
> Because it defaults to device 0 which is usually a real soundcard, but
> not on your system:
> 
> /proc/asound/cards:
> 
> 0 [Dummy          ]: Dummy - Dummy
>                       Dummy 1
> 1 [VirMIDI        ]: VirMIDI - VirMIDI
>                       Virtual MIDI Card 1
> 2 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
>                       Ensoniq AudioPCI ENS1371 at 0xdf00, irq 10
> 
> Try unloading the snd-dummy and snd-virmidi modules, or don't enable
> them when compiling the kernel.

Is there any way of testing whether this is the/a problem before I 
recompile the kernel?  I will have to upgrade it when I recompile (2.6.8 
does not compile with gcc-4.0, which is what I have now.)
> 
> Did you try this first with your distro's default kernel before building your own?

No, I have been using custom compiled kernels for a long time.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
