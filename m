From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: Detection of ALC650 rev.E
Date: Tue, 26 Aug 2003 21:56:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4BC986.7080705@superbug.demon.co.uk>
References: <200305210604.IAA04383@www1.pobox.sk>	<s5hllx0vdh6.wl@alsa2.suse.de>	<3F4BA046.6060904@superbug.demon.co.uk> <s5hptisfghz.wl@alsa2.suse.de> <3F4BBC48.7030800@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F4BBC48.7030800@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, p z oooo <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Takashi Iwai wrote:
> 
>> At Tue, 26 Aug 2003 19:00:38 +0100,
>> James Courtier-Dutton wrote:
>>
>>> Takashi Iwai wrote:
>>>
>>>> At Wed, 21 May 2003 08:04:44 +0200,
>>>> p z oooo wrote:
>>>>
>>>>
>>>>> Hi,
>>>>>
>>>>> I tested code and it doesn't work :-(.
>>>>> When I deleted code to detect ALC650 rev.E, it worked perfect. :-)
>>>>>
>>>>> May be:
>>>>> 1) MSI uses ALC650 rev.E and stil uses gpio0 to switch mic power 
>>>>> on/off
>>>>> 2) detection code for ALC650 rev.E is wrong
>>>>
>>>>
>>>>
>>>> most likely the latter...
>>>> perhaps chaging GPIO0 won't affect the behavior of rev.E.
>>>> i'll remove it.
>>>>
>>>>
>>>> thanks,
>>>>
>>>> Takashi
>>>>
>>>>
>>>
>>> How is the ALC650 rev.E detected? I could not see anything in the 
>>> alc650 pdf specifications to indicate how to detect the ALC650 rev.E 
>>> or not.
>>
>>
>>
>> no, the detection code was removed (as written above), because it
>> simply didn't work as expected :)
>> please let me know if you have any idea how to detect it.
>>
>>
>> Takashi
>>
>>
> Can you point me at the code you used to detect it. I have some code 
> here that is supposed to detect it, and I just want to compare it with 
> your previous code before I bother sending it as a patch.
> Cheers
> James
> 
> 
P.S. The code I have depends on the contents of AC97 register 0x6e.
Source of this code is: -
http://www.realtek.com.tw/downloads/dlac97-2.aspx?lineid=5&famid=12&series=8&Software=True 

Then download the Linux driver. It is a version of the alsa kernel 
drivers, but with modifications.

/* reg = contents of AC97 reg 0x6e */
switch(ac97->id & 0xfffffff0) {

<snip>

case 0x414c4720:        // ALC650
   if (((reg & 0x3f) > 0) && ((reg & 0x3f) < 3))
     ac97->id = 0x414c4720;	// Early version.
   else if (((reg & 0x3f) > 2) && ((reg & 0x3f) < 0x10))
     ac97->id = 0x414c4721;          // D version
   else if ((reg&0x30) == 0x10)
     ac97->id = 0x414c4722;          // E version
   else if ((reg&0x30) == 0x20)
     ac97->id = 0x414c4723;          // F version
   break;



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
