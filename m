From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: intel8x0 driver motorboots (gets caught in loop)
 in Quake 3
Date: Mon, 17 Feb 2003 12:27:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E50C719.1000306@uni-bonn.de>
References: <3E4A8A39.9000608@uni-bonn.de> <877kc2j521.fsf@dimail.umc.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <877kc2j521.fsf@dimail.umc.com.ua>
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

Doesn't look like we're getting very far in this thread...

I, like Dmitry, am eager to help debug this problem and can 
patch/compile/use gdb, but don't know much about alsa internals. Anybody 
have any hints about what to try next?

--josh

Dmitry Astapov wrote:
> Evening, Josh. 
> 
> Josh Buhl <uzs33d@uni-bonn.de> 18:54 12/2/2003 wrote:
> 
>  JB> When running Quake 3 Arena the sound initializes
>  JB> properly and plays correctly during the game until the
>  JB> end of a match. At this point, the game abruptly enters
>  JB> a different mode (this is where the models of the
>  JB> players for the first, second, and third placements are
>  JB> shown on pedestals and a voice says "Grunt Wins!" or
>  JB> whatever) and the game locks up with a small segment of
>  JB> sound being repeated in a loop.
> 
> I'd like to second that, but for me looping occurs at the beginning of
> level.
> 
>  JB> This does not occur when sound is disabled in quake.
> True.
> 
>  JB> This does not occur on the same machine while running
>  JB> quake 3 under Windows 2000 with sound.
> True.
> 
>  JB> This also occurs using the linux kernel 2.4.18 oss
>  JB> kernel sound driver for intel8x0.
> Ture.
> 
>  JB> I set up the quake mmap stuff for alsa like this:
>  JB> echo "quake3.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss
> Same thing here.
> 
>  JB> I'm using alsa-0.9rc7 on Debian 3.0r1 running kernel 2.4.20 on an AMD
>  JB> 1800+ Elitegroup K7S5A with SIS 7012 sound on board (intel8x0 driver.)
> alsa-0.9rc7, Debian unstable, kernel 2.4.20 on Toshiba Satellite 5105-S907
> with Yamaha sound on board
> (00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02))
> 
> JB> This has happened on all the ALSA 0.9rcx drivers I have
>  JB> tried, including 0.9rc7.
> True.
> 
> I have made checks suggested in this thread. Results are the same:
> interrupts are being generated and sttuses in /proc/asound keep changing.
> 
> I'm eager to help debug this. I know how to use debugger/compiler/whatever
> it takes, I just need a push in the right direction.
> 

-- 
"When you wake up in the morning, Pooh," said Piglet at last,
"what's the first thing you say to yourself?"

"What's for breakfast?" said Pooh.  "What do you say, Piglet?"

"I say, 'I wonder what's going to happen exciting today?'" said Piglet.

Pooh nodded thoughtfully.  "It's the same thing," he said.

	-- A.A. Milne

-----------------------------------------------------
http://www.nyfairuse.org/

WTO + WIPO = DMCA http://www.anti-dmca.org

Innovation vs Patent Inflation http://swpat.ffii.org/

120000 voices and 400 Firms against logic patents
http://www.noepatents.org/
-----------------------------------------------------




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
