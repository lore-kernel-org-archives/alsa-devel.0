From: "Nambiar, Anil" <NambiarA@sharpsec.com>
Subject: RE: Alsa-lib problem
Date: Tue, 9 Aug 2005 18:47:10 -0400
Message-ID: <6A09F73E2878E447BF6B87C43162C827021545A5@excwa1b2.sharpsec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'James Courtier-Dutton' <James@superbug.demon.co.uk>, "Nambiar, Anil" <NambiarA@sharpsec.com>
Cc: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
 Thanks for the reply. I tried running speaker-test with those parameters
and it gave this dump.
speaker-test 0.0.8
Playback device is plughw:0,0
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM plughw:0,0
Playback open error: -2,No such file or directory
speaker-test: conf.c: 3095: snd_config_update_free: Assertion `update->count
> 0
 && update->finfo' failed.
Aborted

I'll create a config file, but not sure if that would work. I tried using
strace, but it gives some syscall err!!

Thanks,
AniL


-----Original Message-----
From: James Courtier-Dutton [mailto:James@superbug.demon.co.uk] 
Sent: Tuesday, August 09, 2005 3:19 PM
To: Nambiar, Anil
Cc: 'alsa-devel@lists.sourceforge.net'
Subject: Re: [Alsa-devel] Alsa-lib problem

Nambiar, Anil wrote:
> Hi,
> 
>             I am developing ALSA based sound driver for our arm based soc.
> The driver is built as part of the kernel rather than as a loadable
module.
> If I run a simple wave player which has OSS based interface, it works
fine.
> Even mplayer works fine in OSS emulation mode. But if I run any native
alsa
> based player it gives error opening the device. For eg: running 'aplay -D
> default demo.wav" give the following error: 
> 
> ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM default
> 
> aplay: main:533: audio open error: No such file or directory
> 

You probably do not have a "default" device defined for your card due to 
the lack of a config file.
But, in order to test it, even though you don't have a config file, try
speaker-test -c2 -Dplughw:0,0

if that works, all you then need is a config file for your card.
cat /proc/asound/cards  and note down whatever is in the [....    ] bit.
Here I get:
0 [Audigy2        ]: Audigy2 - Audigy 4 PRO [SB0380]
                      Audigy 4 PRO [SB0380] (rev.4, serial:0x20071102) 
at 0x9800, irq 20


So I have an "Audigy2" file in /usr/share/alsa/cards
You will need to create one for your card.




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
