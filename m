From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: USB recording - repetitive peaks
Date: Sat, 06 Jul 2002 03:37:18 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D25E75E.6010109@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de>	<s5hhejibem0.wl@alsa2.suse.de>	<3D21B878.8090902@boosthardware.com>	<s5hy9curxdr.wl@alsa2.suse.de>	<3D21C827.2060602@boosthardware.com>	<s5hwuseruac.wl@alsa2.suse.de>	<3D21D6CA.7000308@boosthardware.com>	<s5hu1nirsni.wl@alsa2.suse.de>	<3D21DDFD.6000206@boosthardware.com>	<3D21EB37.7070008@boosthardware.com>	<s5hpty5ry0y.wl@alsa2.suse.de>	<3D247676.8090309@boosthardware.com>	<s5hu1nfqx22.wl@alsa2.suse.de>	<3D2482BB.5020506@boosthardware.com> <s5h1yaiwapw.wl@alsa2.suse.de> <3D25E34B.6000100@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Takashi Iwai wrote:
> 
>>
>> i (hopefully) found the spot.
>> it happend when snd_pcm_stop() is called during complete callbacks, so
>> the working urb won't be released properly.
>> now the fixed version is on cvs.
>>
> 
> Apparently not the g-spot.
> 
> I just tried using jack+ardour and the system hung again. This time it 
> may have been triggered when I tried to switch virtual desktops. (I'm 
> running enlightenment).
> 
> Everything was working (apart from peaks in the sound quality similar to 
> the ones we were hearing natively only more pronounced). When I tried to 
> switch into another part of the desktop everything hung.
> 
> I will try again because it may have been a time issue and therefore a 
> complete coincidence.
> 
> 

It seems to be directly related to stress on xfree which causes an xrun 
in jackd.

This time when I started up I had a clear signal and could switch 
screens without dropouts but when I downloaded some messages I caused an 
xrun and then the sound got all choppy. Still no hang so I tried moving 
the ardour editor window to a different screen and that was it.

I have a usb mouse and am using the nvidia drivers for my video card 
which is a 64MB geforce2. Plus I was running jackd as normal user.

However I can get normal recording and xfree performance if I don't use 
jack. That is whether I am root user or not.

So it sounds like you have sorted the problem (unless you can think of 
anything else) and I need to do some serious fine tuning to get JACK 
working correctly.

We still need a way to access all four channels at the same time though.




-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
