From: mitya@school.ioffe.ru (Dmitry Baryshkov)
Subject: Re: [PATCH] Adds 24bit, 96khz support for multichannel playback on the Audigy 2 sound cards.
Date: Mon, 14 Mar 2005 00:13:01 +0300
Message-ID: <20050313211301.GA19942@school.ioffe.ru>
References: <423349A5.8020001@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <423349A5.8020001@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,
On Sat, Mar 12, 2005 at 07:57:25PM +0000, James Courtier-Dutton wrote:
> Please see readme.txt at 
> http://www.alsa-project.org/~james/alsa-driver/p16v/
> http://www.alsa-project.org/~james/alsa-driver/p16v/readme.txt
> 

Thank you for your work.

I have plain Audigy2 6.1 (SB0240) and I tried using alsa-driver-1.0.9rc1.
speaker-test command from your readme worked more or less. When it worked,
channels were swapped. speaker-test tried to shout from Rear Left, but I
got sound from Center, Rear Right - LFE, Unk Left - Rear Left,
Unk Right - Rear Right (I had to patch speaker-test a bit, so it doesn't
segfault). I can't verify what channel sends sound to the "Back",
because I have no 4-pin minijack.

BTW1: this incorrect "naming" maybe a more generic problem, because if I
try to use multichannel device (plughw:0,3), i get same mis"naming".

BTW2: I wander when will ALSA support 6.1 configurations/cards correctly?

Also at some point p16v hanged, every program trying to use plughw:0,4
hangs at first poll(). modprobe -r snd-emu10k1 ; modprobe snd-emu10k1
cycle doesn't help. Later I'll try rebooting to see if it's permanent
damage or not.

-- 
With best wishes
Dmitry Baryshkov


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
