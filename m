From: Kris Modrak <modrak@axiom.anu.edu.au>
Subject: RME 9636 lockup
Date: Mon, 3 Nov 2003 17:18:14 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311031718.14466.modrak@axiom.anu.edu.au>
Reply-To: modrak@axiom.anu.edu.au
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I am writing an application that uses an RME9636 Hammerfall light with the 
ALSA API. Occasionally (and randomly) the card is left in a locked up state by 
my application as the next time I run the program the card is unable to 
signal to the computer when there is capture or playback data to be 
transferred and doesn't signal xruns. At this point I am unable to use the 
card with any ALSA applications, aplay etc., until after rebooting the 
computer.

Why might this be happening? Could the program be exiting when the card is 
temporarily is a state of being locked? I am using threads, could this have 
something to do with it? And is there any way of resetting the card in 
software, ie. is there any ALSA API function that does this? I would prefer 
not to reboot the computer every time that this happens.

Thanks
Kris Modrak



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
