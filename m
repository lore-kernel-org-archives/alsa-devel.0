From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Query devices in a non-blocking fashion
Date: Mon, 15 Dec 2003 01:17:26 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FDC8D16.6070608@boosthardware.com>
References: <oprztqwoi4q1sf88@mail.broadpark.no> <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com> <20031208161936.310df2cb.pochini@shiny.it> <oprzvc5mu3q1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312081745340.20863@pnote.perex-int.cz> <oprzvh60rmq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

If we have a DB of info how would we define the abilities of each device?

I assume this info is available in the driver layer because there is a 
point where ALSA will return false eg. if a card is not able to run at 
48000Hz

My opinion is that a simple function could be included in alsactl which 
scans for available devices, makes a list of their abilities. Everyone 
uses "post-insert alsactl restore" in the modules.conf file so it would 
be essentially a non issue from a user perspective.

Couldn't this be saved in the config settings for alsactl?




-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================


  Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
