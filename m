From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp 9652
Date: 17 Apr 2003 09:15:35 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050596136.1778.20.camel@Wizard>
References: <200304051339.h35DdJb02474@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304051339.h35DdJb02474@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   A couple of weeks ago I received the following email from Paul.
Apparently for him the new driver was working. However, for me it still
is not. The driver starts, and Jack will run, but the hardware actually
sends no audio.

   I have written Paul a couple of times asking some questions but have
not received a response. Perhaps Paul never actually listened to the
card, or perhaps he has different firmware and his works. I cannot tell
as of today.

   I'd like to find out if anyone has managed to get actually get sound
out of this with the new driver and, if so, with what version of
firmware?

   I see that Johannes wrote something on the Alsa Sound Matrix page
about downgrading firmware. Unfortunately I'd have to move the card to a
box with Windows, or install Windows on this box to try this. The note
is a bit old, and is also unclear about which DSP card he was doing this
for, so I won't do this unless someone can really tell me it works in my
case.

   Again, I know Thomas is trying to work on this, but I'm confused as
to why Paul would tell me it works? Just trying to move forward after a
long time with no audio.

   BTW - Thomas's hdspconf is a nice little tool that is very helpful
with debugging. If you're not using it, compile it!

<SNIP>
 j#|@     johannes.taelman(a)rug.ac.be
Wednesday, 12 February 2003

In order to make alsa-hdsp recognize the hdsp I had to downgrade
the firmware of the card(bus) to revision 10. There is a flash update
tool available at
http://www.rme-audio.de/english/download/drivers_archive.htm
You'll have to do that in windows...
<SNIP>	        


[mark@Wizard mark]$ cat /proc/asound/cards
0 [               ]: H-DSP - Hammerfall DSP
                     RME HDSP 9652 at 0xe8800000, irq 10
[mark@Wizard mark]$

Thanks,
Mark

On Sat, 2003-04-05 at 05:39, Paul Davis wrote:
> mark - 
> 
> just FYI, i finally got a chance to install the hdsp-9652 in my
> machine (power outage caused by a mouse!). there were some problems in
> the driver (very minor, but still real), i fixed them, and the driver
> is now working with this card:
> 
> % cat /proc/asound/cards
> 0 [4D             ]: TRID4DWAVENX - Trident TRID4DWAVENX
>                      Trident TRID4DWAVENX PCI Audio at 0xe400, irq 10
> 1 [hdsp           ]: H-DSP - Hammerfall DSP
>                      RME Hammerfall DSP + Digiface at 0xfebe0000, irq 14
> 2 [h9652          ]: H-DSP - Hammerfall DSP
>                      RME HDSP 9652 at 0xfebb0000, irq 11
> 
> i am glad that for once, opening up my chassis and replacing cards
> didn't cause any problems. its that fear that has been the main reason
> this has taken me so long to do this. thomas tells me that he still
> has a few details to fix, and then we'll get the driver back into
> ALSA.  thanks for hanging in there.
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
