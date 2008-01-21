From: mazarick@bellsouth.net
Subject: Re: how do you people debug ALSA?
Date: Mon, 21 Jan 2008 20:25:37 +0000
Message-ID: <012120082025.22241.4794FFC1000089D6000056E122243651029B0A02D2089B9A019C04040A0DBF050C079D0E960E03@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmailhost06.isp.att.net (fmailhost06.isp.att.net
	[204.127.217.106])
	by alsa0.perex.cz (Postfix) with ESMTP id 628B82482E
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 21:25:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: wavepro-driver-developers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"Mihaela Vitalariu" <admiralwolverine@gmail.com> wrote:

> I meant what tools do you use, what Debuggers?
> In my post i wasn't complaining about ALSA, i was just curios about the
> debugging tools that you use, from a developer's standpoint...

The group that I'm working with (to develop an alsa driver for the Gadget Labs soundcard) would
be very interested in any input on this subject.   The team is made up of skilled C/C++ coders, but
there is very little to no experience with writing a linux hardware driver.

It would be fine to say "vi is the development environment, and we sprinkle the code with printk statements and take them out when the soup's done".   It would save us a lot of overhead in figuring out the best way to get on the same page with each other since it's a pretty new team.  Any other words of wisdom 
from those who've been there would be very welcomed and appreciated.  If you use KDE, Eclipse, or 
something else, that's fine too.

Some particular questions (in no particular order):
1.   Do you regularly use the "alsasound" kernel function during development so you can take the driver
in and out of the kernel?   If it's used, is is used from the beginning or in the last stages of development?
(I'm not sure if it's alsasound, sndconfig, etc).

2.  Are the process statements given in the 'How-To' (snd_printk, snd_assert, snd_BUG) the main ones
or are there others that are 'pre-built' and widely useful?
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/c1696.htm

3.   Are there tools that are almost always used when writing a sound card driver like gdb, ddd, etc?

4.   Since it's easy to do, is an interface into the proc file system useful from the start?
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/c1493.htm

5.   Is the alsa wiki on debugging the sum total of what's needed or is there more we don't know about?
(and we don't know that much!!)
http://www.alsa-project.org/main/index.php/Driver_Compilation

Of course, I could bring up the current Hot and Burning question we have (they are more important now):

http://wavepro-driver.svn.sourceforge.net/viewvc/wavepro-driver/

1.  We've having difficulty getting the Altera PLD to load. Any suggestions on how to do this, how people
without cards can help, an easy way to know when you are successful, or an incremental approach
to the problem?  

2.  The GL card is powered from an Altera PLD (FPGA) (it has similar function as the Envy ICE chip once it's loaded).   For the card to function at all, the Altera PLD has to be loaded when power is applied 
to the computer.   Should the 'load the Altera' function be part of the alsa driver, part of alsa firmware, or 
should we just load it up when the computer boots (not in alsa)?

3.   We're planning on using FC8/PlanetCCRMA as a 'beta test' environment.   I've just noticed the 
new FC8 specific instructions on how to overcome my many bad habits when fooling around with the
kernel.  I'm putting it here for reference so I don't forget it (like I just did when trying to figure out if it was
alsasound, procsound, or whatever to unload the driver).
http://fedoraproject.org/wiki/Docs/CustomKernel

If you would like to just put your two cents worth in to the very small mailing list (for the next 5 days), send a note to:
 wavepro-driver-developers@lists.sourceforge.net
(in 5 days, you'll have to be subscribed to send a note)

-Mike Mazarick
