From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: Detection of ALC650 rev.E
Date: Wed, 27 Aug 2003 17:31:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4CDCEF.1010301@superbug.demon.co.uk>
References: <200305210604.IAA04383@www1.pobox.sk>	<s5hllx0vdh6.wl@alsa2.suse.de>	<3F4BA046.6060904@superbug.demon.co.uk>	<s5hptisfghz.wl@alsa2.suse.de>	<3F4BBC48.7030800@superbug.demon.co.uk>	<3F4BC986.7080705@superbug.demon.co.uk>	<s5hy8xfw7ya.wl@alsa2.suse.de>	<3F4CC963.40309@superbug.demon.co.uk> <s5hr837w30o.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr837w30o.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: p z oooo <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 27 Aug 2003 16:08:19 +0100,
> James Courtier-Dutton wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Tue, 26 Aug 2003 21:56:38 +0100,
>>>James Courtier-Dutton wrote:
>>>
>>>
>>>>>Can you point me at the code you used to detect it. I have some code 
>>>>>here that is supposed to detect it, and I just want to compare it with 
>>>>>your previous code before I bother sending it as a patch.
>>>>>Cheers
>>>>>James
>>>>>
>>>>>
>>>>
>>>>P.S. The code I have depends on the contents of AC97 register 0x6e.
>>>>Source of this code is: -
>>>>http://www.realtek.com.tw/downloads/dlac97-2.aspx?lineid=5&famid=12&series=8&Software=True 
>>>>
>>>>Then download the Linux driver. It is a version of the alsa kernel 
>>>>drivers, but with modifications.
>>>>
>>>>/* reg = contents of AC97 reg 0x6e */
>>>>switch(ac97->id & 0xfffffff0) {
>>>>
>>>><snip>
>>>>
>>>>case 0x414c4720:        // ALC650
>>>>  if (((reg & 0x3f) > 0) && ((reg & 0x3f) < 3))
>>>>    ac97->id = 0x414c4720;	// Early version.
>>>>  else if (((reg & 0x3f) > 2) && ((reg & 0x3f) < 0x10))
>>>>    ac97->id = 0x414c4721;          // D version
>>>>  else if ((reg&0x30) == 0x10)
>>>>    ac97->id = 0x414c4722;          // E version
>>>>  else if ((reg&0x30) == 0x20)
>>>>    ac97->id = 0x414c4723;          // F version
>>>>  break;
>>>
>>>
>>>oh, then it's apparently different.
>>>i checked MULTICH register bits but it didn't work anyway.
>>>
>>>the above looks better (hey where is such a thing described!).
>>>could you send me a patch?
>>>
>>>
>>>Takashi
>>>
>>>
>>
>>If you go to the realtek site (url above) and download the linux 
>>drivers. They are source code, and look like a modified version of 
>>alsa-driver.
>>I just extracted the info from the realtek source code.
> 
> 
> yep, that i know.  i did want to say "where is documetation!" ;)
> 
> for the time being, i have no time at all, so it'd be helpful if
> anyone can send us a patch...
> 
> 
> Takashi
> 
> 
I don't have time to create a patch from that code at the moment. I am 
working on getting audigy2 passthru working.
Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
