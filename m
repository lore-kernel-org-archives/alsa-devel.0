From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb-audio Quattro
Date: Thu, 01 Jul 2004 02:44:51 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E2FC13.7010009@boosthardware.com>
References: <Pine.HPX.4.33n.0406280917270.22724-100000@studcom.urz.uni-halle.de>	<40E2C977.40401@boosthardware.com> <s5h1xjxau4a.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 30 Jun 2004 23:08:55 +0900,
> Patrick Shirkey wrote:
> 
>>Clemens Ladisch wrote:
>>
>>>Patrick Shirkey wrote:
>>> 
>>>... and are there any differences to the streamX files on that
>>>machine?
>>>
>>
>>They are all the same. There is a bug that has been introduced in the 
>>last two weeks. I installed the cvs from June 15 and patched the files 
>>by hand and the driver works fine.
> 
> 
> Hmm, might there be any difference between quattro models?
> 

Not that I know of. It's certainly possible. My quattro is about two 
years old now.

> 
>>Except for a small problem with the plughw interface on the route 
>>interface so we can use all four channels at once... More about that later.
>>
>>BTW. arecord cannot do big endian format on my PC. Is that something 
>>that can be easily fixed?
> 
> 
> Doesn't "arecord -c2 -fS16_BE -traw foo.raw" work?
> Note that WAV supports only LE formats.
> 

Aha.
It would be helpful to add this info to the error report.

aplay.c : 831
		error("Sample format non available");
		error("Note that WAV supports only LE formats");
		error("try: arecord -c2 -fS16_BE -traw foo.raw");



-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
Http://www.nana7.net - Bar Nana - Itaewon, Seoul, Sth Corea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
