From: Tom Watson <sdc695@yahoo.com>
Subject: Re: M-Audio Revolution 7.1 card hangups
Date: Wed, 10 Sep 2003 14:37:16 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030910213716.35773.qmail@web21512.mail.yahoo.com>
References: <E19xB9b-00044R-00@sc8-sf-list2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19xB9b-00044R-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

I got the patch, and I WILL apply it.  Thanks for the prompt response.
I haven't tried the card on Windows (may happen today), but I was
wondering if there is some reference to what is in the EEPROM that is
on the board.  Maybe I can solve the problem.  I've got a note to the
M-Audio people as well.

Thanks again,
....tom


Takashi Iwai Wrote:


At Wed, 10 Sep 2003 10:30:25 -0700 (PDT),
Tom Watson wrote:
> 
> I just got one of these, and after converting my audio to 32 bits
> (necessary for the card) I got SOME sound out of it.
> 
> I have a couple of problems:
> 1) While the peak meters indicate that something IS there, try as I
> might, I can't get audio out of the card from anywhere but the first 
2
> channels.  All the mixer controls in 'alsamixer' are up, and the two
> that control the first 2 channels DO work, but NO audio from the 
other
> channels.  The program I'm using DID work on another audio card with
> more than two channels.  The problem seems to be some dumb
> configuration thing.  Do I need to light this card up on a Windoze
> machine to set the EEPROM or something??

most likely a bug in the accessing to ak4355 codec.

> 2) I use 'alsamixer'.  Works fine.  One problem:  When I set the
> conversion rate to the SPDIF clock (it has another name IEC...) IT
> LOCKS AND STAYS THERE.  No amount of diddling in 'alsamixer' yields
> anything.  To get around this I revert back to an older setting (it 
is
> a long process) saved with 'alsactl' after a reboot.  While I have
> learned my lesson (DON'T DO THAT!), the behavior is not too good.

ok, that's easy.  please apply the patch attached.


> Note:  The card is 'fresh', and hasn't been in a Windows environment
> (if that means anything).

could you check whether the surround works on windows?


Takashi



=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
