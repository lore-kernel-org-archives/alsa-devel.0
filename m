From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Creative Audigy 4
Date: Sat, 04 Dec 2004 21:36:08 +0000
Message-ID: <41B22DC8.2080704@superbug.co.uk>
References: <41B228F0.4080804@superbug.co.uk> <1102195213.28776.34.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1102195213.28776.34.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sat, 2004-12-04 at 21:15 +0000, James Courtier-Dutton wrote:
> 
>>Now to the problems.
>>The card seems to work quite well, except for the remote control.
>>Has anyone ever got the Audigy 2 ZS remote control to work?
> 
> 
> Yes I got mine to work a whle back.  There is a sequence of commands you
> have to echo to the midi port first.  Don't have it handy but you should
> be able to google for it.  I think it's on the ALSA wiki.
> 
> Lee
> 

I found it.
I quote:

There is an issue with the Audigy 2 Platinum Ex soundcard
(and probably some other Audigy 2 cards as well), whereas the
IR sensor, MIDI and the buttons on the LiveDrive do _not_ work
at all until the LiveDrive is initialized by sending the sequence
of '0xf0, 0x00, 0x20, 0x21, 0x61, 0x0, 0x00, 0x00, 0x7f, 0x0, 0xf7'
to the MIDI port. Before doing this, even the LED on the LiveDrive
won't blink, as it usually does when a button on the remote is pressed.

As far as I know, this behaviour is different than with most
LiveDrives manufactured by Creative.

For more information see:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg09267.html

The easiest workaround to this is to add the following line to 
/etc/modules.conf

post-install snd-emu10k1
echo -e '\360\000\040\041\141\000\000\000\177\000\367' > /dev/snd/midiC0D1

[(Ed) The above is wrapped for formatting. It should be one line.]

It works for me and it should be distribution-independent
(with exception to Debian, where you change /etc/modutils/alsa
and run update-modules afterwards, Debian users will know anyway).



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
