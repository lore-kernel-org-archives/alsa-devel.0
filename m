From: Tom Watson <sdc695@yahoo.com>
Subject: M-Audio Revolution 7.1 card hangups
Date: Wed, 10 Sep 2003 10:30:25 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030910173025.76994.qmail@web21512.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I just got one of these, and after converting my audio to 32 bits
(necessary for the card) I got SOME sound out of it.

I have a couple of problems:
1) While the peak meters indicate that something IS there, try as I
might, I can't get audio out of the card from anywhere but the first 2
channels.  All the mixer controls in 'alsamixer' are up, and the two
that control the first 2 channels DO work, but NO audio from the other
channels.  The program I'm using DID work on another audio card with
more than two channels.  The problem seems to be some dumb
configuration thing.  Do I need to light this card up on a Windoze
machine to set the EEPROM or something??

2) I use 'alsamixer'.  Works fine.  One problem:  When I set the
conversion rate to the SPDIF clock (it has another name IEC...) IT
LOCKS AND STAYS THERE.  No amount of diddling in 'alsamixer' yields
anything.  To get around this I revert back to an older setting (it is
a long process) saved with 'alsactl' after a reboot.  While I have
learned my lesson (DON'T DO THAT!), the behavior is not too good.

Note:  The card is 'fresh', and hasn't been in a Windows environment
(if that means anything).  A pointer to the mentioned 'Envy24HT.pdf'
file might be useful as well.

p.s.  Even on 2 channels, the quality seems to be quite good.  The
problem is that I'd like more than that (preferably 8 channels).  Maybe
a listing of the EEPROM from a working setup would help.

Thanks.

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
