From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: OPL3-SA2/3 PCM Playback rates?
Date: Wed, 09 Oct 2002 19:09:16 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA3F23C.50207@superbug.demon.co.uk>
References: <3D9C5DFA.6010803@superbug.demon.co.uk> <s5h7kgs3lud.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Fri, 04 Oct 2002 01:10:50 +1000,
>James Courtier-Dutton wrote:
>  
>
>>Hello
>>I have searched the web to find the specs on this chip. No Luck.
>>What I have found is that it is a Yamaha OPL3-SA2 or YMF711.
>>Which playback rates does it support ?
>>    
>>
>
>the dma engine of opl3sax is actually cs4231-compatible.
>thus it supports the following sample rates:
>	5510, 6620, 8000, 9600, 11025, 16000, 18900, 22050,
>	27042, 32000, 33075, 37800, 44100, 48000
>
>  
>
>>I find that anything above 32k causes jittery playback.
>>    
>>
>
>most likely you hit a bug ;)
>
>how is the symptom exactly?  repeated (stutter) sounds?
>
>
>what i heard about this chip is that the pcm is not audible until a
>pcm mixer element is modified at each open.
>but it looks like a different problem...
>
>
>ciao,
>
>Takashi
>
>
>  
>
I think the problem is that the sound buffer is filled by the 
application, but then on a slow PC, the CPU is locked into doing 
something with the X display (XV video images), and the transfer inside 
alsa-lib from buffer to sound card does not get CPU time. So, basically 
samples are lost.

So, if I was to send 3 groups of samples to the sound card, A,B, C.
The alsa-lib buffer is then filled with A,B,C, but the sound hardware 
grabs a period, so takes A and plays it, but when the sound card comes 
to get B, it does not have the CPU time, so the sound card just plays 
silence, when the sound card gets CPU time, it then plays B, then plays 
C, but as it played B and C late, my application tries to resync and 
drops D and then sends E to the sound card.
Is there any reports in alsa to report missed interrupts to the 
application ?
I understand that an "underrun" is when the interrupt gets CPU time, but 
the application is not up to speed, but what if there is too long a 
delay between the sound card signalling an interrupt, and the interrupt 
routine actually being run ? The sound card hardware will not get the 
samples it needs, but "underrun/xrun" is not sent back to the app.

Cheers
James








-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
