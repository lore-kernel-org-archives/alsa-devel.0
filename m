From: Jeffrey Kent Ridenour <jridenou@ics.uci.edu>
Subject: Re: Dell OEM Soundblaster Live 5.1 with different PCI
 ID
Date: Thu, 19 Dec 2002 11:02:27 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.SOL.4.20.0212191055180.444-100000@amundsen-scott.ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi folks,

I was having the exact same problem, so I tried changing the source using
the diff file provided by Takashi, thanks a lot!  This did make progress
for me, since before, the i couldn't get the driver to modprobe. 

The driver now loads and I can now give gmix/alsamixer to open (couldn't
before).  However, I'm still not getting sound.  when I turn the volume up
and mess with the sliders, I do hear changes in the signal level (i.e. the
noise floor goes up and down), but I haven't been able to get any sounds
or CD's to play.

Is this because the driver really doesn't work?  Or is there something
else that i haven't configured properly?  Any suggestions or response from
anyone would be much appreciated.  (I have a deadline I'm working with,
and I need to decide soon whether I should buy a different soundcard or
not)

jeff



>At Thu, 19 Dec 2002 10:45:22 +0100,
>elchhome@gmx.de wrote:
>> > Hello Friends,
>> > Dell ships since a month an OEM Soundblaster Live 5.1 (sb0200) with a 
>> different PCI ID
>> > for original sblive you got 1102:0002
>> the Dell version has 1102:0006
>> > I got  no sound with the actual version of the sound driver.
>> Could anyone be so kind to incorporate this into the source code?
>
>please try the attached patch.
>this will add the entry as emu10k1 (sb live!).  it seems that the chip
>is emu10k1, not audigy.
>if it works, please let me know.  i'll commit it to cvs.


>thanks,

>Takashi




-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
