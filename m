From: Dmitry Astapov <adept@umc.com.ua>
Subject: Re: intel8x0 driver motorboots (gets caught in loop)
 in Quake 3
Date: Fri, 14 Feb 2003 16:43:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <877kc2j521.fsf@dimail.umc.com.ua>
References: <3E4A8A39.9000608@uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E4A8A39.9000608@uni-bonn.de> (Josh Buhl's message of "Wed, 12
 Feb 2003 18:54:01 +0100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Evening, Josh. 

Josh Buhl <uzs33d@uni-bonn.de> 18:54 12/2/2003 wrote:

 JB> When running Quake 3 Arena the sound initializes
 JB> properly and plays correctly during the game until the
 JB> end of a match. At this point, the game abruptly enters
 JB> a different mode (this is where the models of the
 JB> players for the first, second, and third placements are
 JB> shown on pedestals and a voice says "Grunt Wins!" or
 JB> whatever) and the game locks up with a small segment of
 JB> sound being repeated in a loop.

I'd like to second that, but for me looping occurs at the beginning of
level.

 JB> This does not occur when sound is disabled in quake.
True.

 JB> This does not occur on the same machine while running
 JB> quake 3 under Windows 2000 with sound.
True.

 JB> This also occurs using the linux kernel 2.4.18 oss
 JB> kernel sound driver for intel8x0.
Ture.

 JB> I set up the quake mmap stuff for alsa like this:
 JB> echo "quake3.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss
Same thing here.

 JB> I'm using alsa-0.9rc7 on Debian 3.0r1 running kernel 2.4.20 on an AMD
 JB> 1800+ Elitegroup K7S5A with SIS 7012 sound on board (intel8x0 driver.)
alsa-0.9rc7, Debian unstable, kernel 2.4.20 on Toshiba Satellite 5105-S907
with Yamaha sound on board
(00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02))

JB> This has happened on all the ALSA 0.9rcx drivers I have
 JB> tried, including 0.9rc7.
True.

I have made checks suggested in this thread. Results are the same:
interrupts are being generated and sttuses in /proc/asound keep changing.

I'm eager to help debug this. I know how to use debugger/compiler/whatever
it takes, I just need a push in the right direction.

-- 
Dmitry Astapov //ADEpt                               E-mail: adept@umc.com.ua
GPG KeyID/fprint: F5D7639D/CA36 E6C4 815D 434D 0498  2B08 7867 4860 F5D7 639D


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
