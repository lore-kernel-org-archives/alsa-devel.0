From: Tom Watson <sdc695@yahoo.com>
Subject: Re: Soundcard Matrix: SEKD -> Marian
Date: Wed, 26 Nov 2003 21:19:15 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031127051915.2349.qmail@web21504.mail.yahoo.com>
References: <E1AOn5n-0004Xd-00@sc8-sf-list2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1AOn5n-0004Xd-00@sc8-sf-list2.sourceforge.net>
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

> Hi
> 
> I wanted to propose a change in the alsa soundcard Matrix: The 
> Company known as SEK'D was acquired by Magix and took down its audio 
> hardware product line. The Interfaces are now sold by SEK'Ds former 
> production company called 
> MARIAN:
> 
> http://www.marian.de
> 
> this results in a name change for the SEK'D Siena, which is now 
> called "Marc 8 Midi" to fit into the marian product line. Similarly,
> all the other SEK'D cards, namely the ARC and Prodif Series are now 
> sold by Marian keeping their old name.
> 
> Also I wanted to provide additional information about the Marc 8 Midi

> (SEK'D Siena): 
> 
> the Card uses 4 AKM AK4524 Converters, there is an PLX PCI 9050 
> target chip on there,  3 memory chips (2 by EliteMT and one by 
> Winbond) and a Xilinx Spartan FPGA. These are the main components I 
> could make out. I hope that is enough information for you to replace 
> that question mark in the Siena row, and maybe even for a skilled 
> person to write a driver ;-).
> 
> Are there similar cards with existing alsa drivers?
> 
> Thank You
> 
> Andreas

Nice cards these ones (Marc-8 MIDI).  While I have most of the details
of how this card works (some info from Marion), I have yet to write the
driver.  The driver involves a bunch of memory mapped ram that is dual
ported (PIC & codec's).  The Xylinx part needs a download to make it
work.  I'd like to get them working as well, as 8 full duplex channels
for the cost is VERY attractive.  Two MIDI channels are the "bonus", as
my application doesn't need them.  In addition, the cards support clock
linking to eliminate skew, but that takes more work.  My friend who
uses them in Windoze doesn't use the clock linking seems to be happy,
maybe it makes a difference, but I don't know. He uses the cards in
groups of 2 and 3 with no problems.

Probably after the first of the year (you know in "copious free time")
I should start the task of the driver.  If someone wants to go faster,
I can forward some information (I haven't signed anything!).

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
