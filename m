From: Jeff Ridenour <jridenou@ics.uci.edu>
Subject: Re: Dell OEM Soundblaster Live 5.1 with different PCI ID
Date: Thu, 19 Dec 2002 19:38:05 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <72DB76FA-13CC-11D7-9D7F-0050E4E6A73C@ics.uci.edu>
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: multipart/alternative; boundary=Apple-Mail-3--228740566
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Apple-Mail-3--228740566
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


Just as an update, when I try to use aplay to play a sound, I get this 
error:

[root@beall-dell-01 sounds]# aplay phone.wav
Playing WAVE 'phone.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
aplay: pcm_write:999: write error: Input/output error
[root@beall-dell-01 sounds]#


So i'm guessing there's still a problem with the emu10k1 driver and this 
dumb oem card?

jeff



On Thursday, December 19, 2002, at 11:02 AM, Jeffrey Kent Ridenour wrote:

Hi folks,

I was having the exact same problem, so I tried changing the source using
the diff file provided by Takashi, thanks a lot!  This did make progress
for me, since before, the i couldn't get the driver to modprobe.

The driver now loads and I can now give gmix/alsamixer to open (couldn't
before).  However, I'm still not getting sound.  when I turn the volume 
up
and mess with the sliders, I do hear changes in the signal level (i.e. 
the
noise floor goes up and down), but I haven't been able to get any sounds
or CD's to play.

Is this because the driver really doesn't work?  Or is there something
else that i haven't configured properly?  Any suggestions or response 
from
anyone would be much appreciated.  (I have a deadline I'm working with,
and I need to decide soon whether I should buy a different soundcard or
not)

jeff



At Thu, 19 Dec 2002 10:45:22 +0100,
elchhome@gmx.de wrote:
Hello Friends,
Dell ships since a month an OEM Soundblaster Live 5.1 (sb0200) with a
different PCI ID
for original sblive you got 1102:0002
the Dell version has 1102:0006
I got  no sound with the actual version of the sound driver.
Could anyone be so kind to incorporate this into the source code?

please try the attached patch.
this will add the entry as emu10k1 (sb live!).  it seems that the chip
is emu10k1, not audigy.
if it works, please let me know.  i'll commit it to cvs.


thanks,

Takashi




-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


--Apple-Mail-3--228740566
Content-Transfer-Encoding: 7bit
Content-Type: text/enriched;
	charset=US-ASCII


Just as an update, when I try to use aplay to play a sound, I get this
error:


<fixed>[root@beall-dell-01 sounds]# aplay phone.wav

Playing WAVE 'phone.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,

Stereo

aplay: pcm_write:999: write error: Input/output error

[root@beall-dell-01 sounds]# 



So i'm guessing there's still a problem with the emu10k1 driver and
this dumb oem card?


jeff



</fixed>

On Thursday, December 19, 2002, at 11:02 AM, Jeffrey Kent Ridenour
wrote:


<color><param>0000,0000,DEDE</param>Hi folks,


I was having the exact same problem, so I tried changing the source
using

the diff file provided by Takashi, thanks a lot!  This did make
progress

for me, since before, the i couldn't get the driver to modprobe. 


The driver now loads and I can now give gmix/alsamixer to open
(couldn't

before).  However, I'm still not getting sound.  when I turn the
volume up

and mess with the sliders, I do hear changes in the signal level (i.e.
the

noise floor goes up and down), but I haven't been able to get any
sounds

or CD's to play.


Is this because the driver really doesn't work?  Or is there something

else that i haven't configured properly?  Any suggestions or response
from

anyone would be much appreciated.  (I have a deadline I'm working with,

and I need to decide soon whether I should buy a different soundcard or

not)


jeff




</color><color><param>0000,6363,1212</param>At Thu, 19 Dec 2002
10:45:22 +0100,

elchhome@gmx.de wrote:

</color><color><param>0000,0000,DEDE</param>Hello Friends,

Dell ships since a month an OEM Soundblaster Live 5.1 (sb0200) with a 

</color><color><param>5454,0000,0000</param>different PCI ID

</color><color><param>0000,0000,DEDE</param>for original sblive you
got 1102:0002

</color><color><param>5454,0000,0000</param>the Dell version has
1102:0006

</color><color><param>0000,0000,DEDE</param>I got  no sound with the
actual version of the sound driver.

</color><color><param>5454,0000,0000</param>Could anyone be so kind to
incorporate this into the source code?

</color><color><param>0000,6363,1212</param>

please try the attached patch.

this will add the entry as emu10k1 (sb live!).  it seems that the chip

is emu10k1, not audigy.

if it works, please let me know.  i'll commit it to cvs.

</color><color><param>0000,0000,DEDE</param>


</color><color><param>0000,6363,1212</param>thanks,

</color><color><param>0000,0000,DEDE</param>

</color><color><param>0000,6363,1212</param>Takashi

</color><color><param>0000,0000,DEDE</param>




-------------------------------------------------------

This SF.NET email is sponsored by: Geek Gift Procrastinating?

Get the perfect geek gift now!  Before the Holidays pass you by.

T H I N K G E E K . C O M     
</color><underline><color><param>1A1A,1A1A,FFFF</param>http://www.thinkgeek.com/sf/</color></underline><color><param>0000,0000,DEDE</param>

_______________________________________________

Alsa-devel mailing list

Alsa-devel@lists.sourceforge.net

</color><underline><color><param>1A1A,1A1A,FFFF</param>https://lists.sourceforge.net/lists/listinfo/alsa-devel</color></underline><color><param>0000,0000,DEDE</param>


</color>
--Apple-Mail-3--228740566--



-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
