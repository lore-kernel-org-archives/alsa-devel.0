From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 15:51:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F74525B.4050805@superbug.demon.co.uk>
References: <200309251628.48034.Safari.Doktor@addcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309251628.48034.Safari.Doktor@addcom.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?=22Dr=2E_med=2E_G=FCnther_Montag=22?= <Safari.Doktor@addcom.de>
Cc: alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dr. med. Günther Montag wrote:
> Hello
> I work at "hfkernel" by Tom Sailer, a program for pactor/rtty (soundcard ham 
> radio digimodes). It seems complicated, because it uses realtime scheduling, 
> select(), mmap(), and runs in 3 threads. 
> It was made in 1996 for OSS; I am trying to get it running with ALSA. 
> 
> It is unique thing because it can do 
> Pactor without the expensive PTC (something like a radio modem), 
> may be of interest for many hams outside Europe /USA.
> 
> I and friends see messages like
> " 512 fragments passed since last wakeup", in endless loop, leading to 
> crashes, seems to be xruns, not able to ctrl-alt-del, have to switch off 
> machine.
> .
> What do You think, how can ALSA support it, or Do I have to rewrite it for 
> ALSA.
> I tried already with no success to say "Direct" and "non-block" in all 
> combinations to /proc/asound/card0/pcm0p etc... 
> If to rewrite, what function / ioctl matches
> SNDCTL_DSP_GETISPACE...SNDCTL_DSP_GETOSPACE...
> " ioctl(fd_audio, SNDCTL_DSP_GETIPTR, &cinfo) "
> and 
> " ioctl(fd_audio, SNDCTL_DSP_GETOPTR, &cinfo) " ?
> 
> The prog is at https//projects.sourceforge.net/hfterm.
> Here is one of the important functions out of l1/user/oss.c my prog:
> Thanks for Your ideas!
> 
I thought all ham radio was half duplex. i.e. You listen and decode, and 
then transmit if needed. i did not think the listen and transmit worked 
at the same time.
So, in theory, one could have 2 threads.
One receiving audio data, one decoding it, and if the decoder needs to 
transmit anything it stops the receiving thread, and starts a transmit 
thread. There is enough time to close and then open the sound device 
between receive and transmit, so the sound card should never have to 
work in full duplex mode.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
