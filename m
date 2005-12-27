From: Doug McLain <doug@nostar.net>
Subject: Re: [Jackit-devel] Real-world reports on two Delta 1010LTs/ice1712
 synched?
Date: Mon, 26 Dec 2005 21:34:39 -0500
Message-ID: <43B0A83F.1040907__20219.5287486122$1135650971$gmane$org@nostar.net>
References: <20051223225430.GA4995@localhost.localdomain> <43AC826C.1040405@nostar.net> <20051223233816.GA5102@localhost.localdomain> <43AC8990.7040900@nostar.net> <20051224124823.GA4183@localhost.localdomain> <20051224144548.GA4306@localhost.localdomain> <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net> <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net> <20051227000428.GA3805@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from aaa.dreamhost.com (aaa.dreamhost.com [64.111.107.16])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D400E16B
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2005 03:34:59 +0100 (MET)
In-Reply-To: <20051227000428.GA3805@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <j@sound-man.co.uk>, jackit-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes, I know about the spdif to word clock bug.  This is why I resorted 
to Windows, to get a feel for the *correct* behavior.  After knowing how 
it is supposed to work, I found that word clock i/o in Linux on the 
1010LT is inoperative.  I broke out a scope on the word clock output, 
and signals are present.  I also confirmed that my bnc cables are all 
good by using them in windows.  Finally, I connected the word clock 
output of my EZBus digital mixer to the word clock in of a 1010LT (in a 
machine with just one card), and in no way could I get any sign from the 
card that an external word clock signal was present.  Again, I repeated 
all of these tests in windows to confirm.  So again, it appears that 
envy24control is still hosed.  As I said in the last email, I remembered 
that about 2 years ago I had the exact same problem with envy24control.
I have 5 1010LT's and have had 4 of them involved in this testing over 
the past few days, just in case there is any concern about hardware 
problems.  Also, everything works correctly in windows.  I keep a 
windows machine handy for reference, very useful for times like these.

Regarding the new asoundrc, its not needed for me, all my spdif i/o 
already works, but only when I click on 'Word Clock' with an spdif 
output from another source coming in.  To make this very clear, I have 
no need for spdif, and am not interested in using it as a clock source, 
or for audio.  The reason for all of this was strictly for 
troubleshooting purposes.

So once again, the one and only setup that works for me at the moment, 
is connecting spdif outputs from my ezbus digital mixer to the inputs of 
each delta, and pressing *Word Clock* (after pressing spdif first, of 
course because of the glitch) on each card.  They now become synced, 
like they should be in 'SPDIF In' mode.  Also it works if I only connect 
the ezbus's spdif out to the spdif in of card 0, then card 0 spdif out 
-> card 1 spdif in.  This works just like if both cards were connected 
to the ezbus's 2 spdif outputs.  I also put audio signals on all the 
spdif outs and ins of both cards to see if they all worked, all worked 
well.  Again, all this only if *Word Clock* (after pressing spdif first, 
of course because of the glitch) on both cards (or 1 card if im working 
with a single card) is pressed.  I hope there is no more confusion here. 
  I am posting this to alsa-devel as well, since envy24control (or the 
relevent snd_ctl_* facilities in the ice1712 driver) is still broken.

All of the envy24control code treats the 1010 and 1010LT equally, so if 
there is a difference, its in the hardware of the devices:

if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010 ||
	    card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010LT) {
		delta specific stuff here...

I find it strange that the envy24control patch does not change anything 
for me.  What exactly was your issue with envy24control before applying 
that patch?

So any 1010 users and 1010LT users that have the ability to do a simple 
test of connecting an external bnc word clock signal to the word clock 
in connector of their card, and see if the 'Locked' label changes to 'no 
signal'?  Yes the text is backwards, no big deal, its the change thats 
important.  Perhaps conduct the test once before and once after applying 
the patch from john's website:

http://www.sound-man.co.uk/linuxaudio/envy24control-wcstatus-patch-1.0.10

Doug
--
http://nostar.net/

John Rigg wrote:
> On Mon, Dec 26, 2005 at 03:59:15PM -0500, Doug McLain wrote:
> 
>>As I said before, the reason for using SPDIF is, nothing else works.  In
>>Linux, word clock input does not work at all!
> 
> 
> When you tried the word clock input did you try clicking on the S/PDIF button
> in envy24control before clicking the word clock button? I found the word
> clock button didn't work until I did that (I've reported it to ALSA
> bugtrack).
> 
> If you did that and it still didn't work, the only reason I can think
> of is that there is enough difference between a Delta 1010 and the
> 1010LT to make it behave differently. On my system both word clock and
> S/PDIF sync now work, but I haven't read the envy24control source code in
> enough detail yet to say if yours should be the same.
> 
> John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
