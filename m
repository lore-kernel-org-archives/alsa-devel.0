From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds 24bit, 96khz support for multichannel
 playback on the Audigy 2 sound cards.
Date: Sun, 13 Mar 2005 21:43:26 +0000
Message-ID: <4234B3FE.10007@superbug.co.uk>
References: <423349A5.8020001@superbug.co.uk> <20050313211301.GA19942@school.ioffe.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050313211301.GA19942@school.ioffe.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dmitry Baryshkov <mitya@school.ioffe.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dmitry Baryshkov wrote:
> Hello,
> On Sat, Mar 12, 2005 at 07:57:25PM +0000, James Courtier-Dutton wrote:
> 
>>Please see readme.txt at 
>>http://www.alsa-project.org/~james/alsa-driver/p16v/
>>http://www.alsa-project.org/~james/alsa-driver/p16v/readme.txt
>>
> 
> 
> Thank you for your work.
> 
> I have plain Audigy2 6.1 (SB0240) and I tried using alsa-driver-1.0.9rc1.
> speaker-test command from your readme worked more or less. When it worked,
> channels were swapped. speaker-test tried to shout from Rear Left, but I
> got sound from Center, Rear Right - LFE, Unk Left - Rear Left,
> Unk Right - Rear Right (I had to patch speaker-test a bit, so it doesn't
> segfault). I can't verify what channel sends sound to the "Back",
> because I have no 4-pin minijack.
> 
> BTW1: this incorrect "naming" maybe a more generic problem, because if I
> try to use multichannel device (plughw:0,3), i get same mis"naming".
> 
> BTW2: I wander when will ALSA support 6.1 configurations/cards correctly?
> 
> Also at some point p16v hanged, every program trying to use plughw:0,4
> hangs at first poll(). modprobe -r snd-emu10k1 ; modprobe snd-emu10k1
> cycle doesn't help. Later I'll try rebooting to see if it's permanent
> damage or not.
> 

Please upgrade your speaker-test version to the latest in alsa-utils.
Failing that, there is a newer version at 
http://www.alsa-project.org/~james/speaker-test/

The p16v does not support hardware mixing, so only one application can 
open it at a time.

James



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
