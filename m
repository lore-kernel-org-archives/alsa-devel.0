From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: dmix vs alsaplayer [was jackd, zynaddsubfx and
 iiwusynth]
Date: Mon, 3 Mar 2003 20:59:54 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303032050270.15451-100000@vaino.wakkanet.fi>
References: <3E639E80.3070506@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E639E80.3070506@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: linux-audio-user@music.columbia.edu, alsaplayer-devel@lists.tartarus.org, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Mar 2003, Patrick Shirkey wrote:

>> Has anyone tried the dmix plugin thats part of alsa rc8?  This looks 
> I was fscking around with it on Saturday. So far I have managed to use 
> multiple instances of aplay but other apps like alsaplayer bork at it. I 
> have yet to figure out why but I think I should probably submit a bug 
> report somewhere.

I've tried it with ecasound and seems to work just fine. One catch is that 
dmix only supports a certain set of audio format parameters at a time. You 
can change these via asoundrc (or dmix:x,y), but not at run time. Anyway, 
with default dmix installation (on top of snd-intel8x0 hw):

ecasound -i foo.wav -o alsa,dmix -b:4096 &
ecasound -i bar.wav -o alsa,dmix -b:4096

... plays the two files at the same time. -b:4096 is needed because of the 
abovementioned reasons.

> $ alsaplayer -o alsa -d plug:\'dmix:SLAVE=\"hw:2,1\",RATE=44100\' 
> track_8.wav
[...]
> PERIOD_SIZE: 5513
> PERIOD_BYTES: 22052
[...]
> error on set_period_size (1024)
> Unavailable hw params:

Try matching the alsaplayer period_size to the one used by dmix with 
the "-f 22052" alsaplayer option. 

PS Opening dmix in non-interleaved mode produces totally garbled output:
   "ecasound -i foo.wav -f:16,2,44100,n -o alsa,dmix -b:4096"

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
