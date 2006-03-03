From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Re: Umaintained drivers
Date: Fri, 03 Mar 2006 22:45:30 +0100
Message-ID: <4408B8FA.7050109@keyaccess.nl>
References: <1141124736.44042e805a63f@mail.e4a.it> <s5h64mvo0z3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64mvo0z3.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Dino <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Dino wrote:

>>>>     i'm having a lot of problems with my cs46xx card because no replay
>>>> to my questions/bugs from the manteiner. So is this driver dead? Is
>>>> there a manteiner for it? How many drivers are actually unmanteined?

>>> The problem is, as usual, no developers have this card.
>>> So, debugging a model-specific problem is pretty difficult in general
>>> although the driver itself is maintained in a certain level,
>>> i.e. adapting the mainstream and following API changes.

Well, I don't count as a developer, but I do have two cs46xx cards, and 
am quite pleased with them. I recently temporarily exchanged the one in 
my main machine, a TerraTec SiXPack 5.1+ (CS4630 + CS4297A + CS4294), 
for a TerrTec DMX while playing around with some stuff, but it worked 
fine. Fairly nice sounding card as well...

The other cs46xx card, a TerraTec DMX XFire 1024 (CS4624 + CS4294) is 
still installed in a different machine, and I just tested it with 
2.6.15; it's working great.

I haven't followed this thread I'm afraid -- what seems to be the 
problem with the driver? (I do compile with the "new DSP support". 
without that, you'll not have hardware mixing at least)

>> Ok but i'm a developer and i have that card, so i can do something by myself.
>> But i need documentation, a lot of documentation (please don't tell me that
>> there is only the source code) and a feedback from any author of the driver
>> should be very appreciated.
> 
> Your afraid is almost right - there are no better documents available
> currently in public than what you can find in alsa's ftp site.

I found this one additionally for the CS4630, which isn't on the 
alsa-project ftp:

http://members.home.nl/rene.herman/cs4630.pdf

Not close to useful for writing a driver though...

> I had a document which was released from cirrus' ftp in a very short 
> moment (possibly acceidentally).  I'll take a look at my disk 
> archives and send you I can find it...

If you do find it, please CC me. Lack of docs has actually been the only 
thing about these cards I regretted. Here, they've been working well for 
a long time and, as said, actually sound fairly nice (so note that this 
driver at least has a fairly active tester).

Rene.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
