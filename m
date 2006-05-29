From: "John Matthews" <jm169@ohm.york.ac.uk>
Subject: Re: Via 82xx Drivers
Date: Mon, 29 May 2006 15:13:19 +0100
Message-ID: <001401c6832a$107620c0$0301a8c0@johnspc>
References: <001b01c67f2d$7d4ecd10$0601a8c0@johnspc>
	<s5hmzd5qbp2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for the reply.

dxs_support=5 doesn't help either.  Neither does using the other hardware
device.

I've discovered that the click appears as the card starts to output absolute
silence.  Adding a constant low level sinusoid which is so small it is
inaudible to the output stops the clicking.

Does the chip get put into some sort of sleep mode or are the pcm channels 
muted when
absolute silence occurs?

Cheers,

John.

----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de>
To: "John Matthews" <jm169@ohm.york.ac.uk>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Friday, May 26, 2006 12:15 PM
Subject: Re: [Alsa-devel] Via 82xx Drivers


> At Wed, 24 May 2006 13:27:50 +0100,
> John Matthews wrote:
>>
>> Greetings,
>>
>> I am writing to describe a problem I have involving the snd-via82xx audio 
>> drivers on
>> 2.6 kernels.  I have updated to the latest alsa-drivers to no avail.
>>
>> Everything works fine, apart from one small issue.  Certain programs have 
>> strange
>> clicks at certain points.  The main example is with fluidsynth 
>> http://www.nongnu.org/
>> fluid/   When a note is turned off there is a very loud click which can 
>> be louder than
>> the note was - the same type of click that happens when you turn a 
>> channel on or off.
>>
>> This doesn't happen with any other sound card that I have tried (tried a 
>> few others
>> including snd-ice1712 on an m-audio delta 410).  It also doesn't happen 
>> with the via
>> binary oss style drivers,  "viaudiocombo" which are available from via's 
>> website.
>>
>> The clicks do happen (suprisingly) in exactly the same places with 
>> fluidsynth running
>> into jack into snd-via82xx.
>>
>> I have tried this on various different boards I have around, although 
>> they are all
>> types of VIA epia mini-itx boards.
>>
>> I have also tried dxs_support=1, dxs_support=2,dxs_support=3, 
>> dxs_support=4 and this
>> doesn't help.
>
> Did you try the latest version of ALSA driver?
> Also, make sure that dxs_support=5 option, e.g. see
> /sys/module/snd_via82xx/parameters/*.
>
> If the problem still persists with the latest driver, try to play with
> the secondary PCM device (hw:0,1) instead of the default one.
> (Assumed that your device is no VIA8233"A".  8233/8235/8237/8251 have
> DXS channels while 8233A not.)
>
>
> Takashi
> 
