From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Wed, 18 Dec 2002 14:28:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E0077E9.9050402@gmx.de>
References: <3DF8A109.2030206@gmx.de>	<s5hel8nuvee.wl@alsa2.suse.de>	<3DF8B8FA.3040009@gmx.de>	<s5h3cp3uorz.wl@alsa2.suse.de>	<m27keexn25.fsf@vador.mandrakesoft.com>	<3DF9C1CD.3090205@gmx.de>	<s5hisxxubkx.wl@alsa2.suse.de>	<3DFA1166.2020409@gmx.de>	<s5hel8lua27.wl@alsa2.suse.de>	<3DFA25F1.2000705@gmx.de>	<s5hznr6roae.wl@alsa2.suse.de>	<3DFE3DA5.4000700@gmx.de> <s5h8yyowm5s.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yyowm5s.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi!

Thank you very much for your work!

The last patch solved the problem. No system hangs anymore. Looking 
back, I must say it was not *that* practical to reboot the system every 
time I used the audio device :-)
The sound quality is ok (I wouldn't expect it any better with this cheap 
card). Using my impulse response program, I also recognized that the 
overall D/A + A/D latency is constant (32 samples) as expected. (I could 
never see this before because using my cs46xx based xfire the latency 
changes in the range of 200 - 258 samples with every run. Bad - the 
xfire has much better sound quality. Is this a hint that pcm_link() 
doesn't work with cs46xx or is this maybe due to the DSP structure of 
the xfire?)

Using aplay, at the end of the audio file the last played samples get 
repeated once. This doesn't happen with 'play', 'cat somefile /dev/dsp' 
or 'artsplay'. But when I cause an error beep in a shell, I first hear 
the beep and then the last samples played back before by any program 
like  aplay, play, xmms,... I can reproduce this as many time as I like, 
i.e. the samples remain in the soundcard buffer all the time.
Another issue regarding aplay: playing back mono wav with a sampling 
frequency below 44k1, the sound get's crackled. This also doesn't happen 
with the other playback programs.
Now I don't know if these small problems result from playing back 
through the alsa device directly or if they are caused by aplay. Sorry 
to say I've no other native alsa app installed at the moment to do tests 
(e.g. alsa output for xmms ...).

Takashi wrote:

>perhaps do you see something out in the kernel messages on console 10
>(alt+f10) when the system hangs?  well, after hang up, you cannot
>switch the console, but you can start aplay on a certain
>console, switch with alt+f10 and wait until the playback is finished.
>  
>
I can switch with alt+f1 .. +f6 to the consoles 1 ..6, alt+f7 is X, but 
alt+f8 and alt+f10 only show a blinking cursor at the top. Does that 
mean that there are no messages or are I'm doing something wrong? (I 
don't see any messages that I can read in /var/log/messages afterwards)

>anyway, could you try the attached patch?
>  
>
of course.

>if you see something on the kernel messages such like kernel panic or
>oops, we can track the point...
>  
>
sorry, but...
... no more kernel problems to report ;-)

>
>ciao,
>
>Takashi
>  
>
cheers
fe



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
