From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Alsa-OSS - Pop at start of song update (rc2)
Date: Mon, 08 Dec 2003 03:28:58 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FD3716A.9010009@boosthardware.com>
References: <1070820195.3841.42.camel@Wizard.knechthome.com>
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
To: Mark Knecht <markknecht@comcast.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> Hi,
> 
>    The only practical idea I can offer is that someone in the Alsa camp
> should take up the task of developing a set of instructions for
> configuring Mozilla. et. all, in such away as to make OSS not be used. I
> think Alsa should support, but not depend on, OSS at all. Today it
> depends on OSS by not providing clear info on how to use Alsa inside of
> browsers.
> 

This is probably useful but the main problem I see is you are using a 
few apps that could be running alsa native but you are using the oss 
drivers instead.

mplayer will use whatever driver you specify in the config file. I 
assume xine is the same. Thats pretty much the best fix AFAICT. Then you 
only have to find a way to make sure you're java plugins don't make 
noise and stop using xmms until they fix the alsa driver.

Anything that xmms can stream mplayer can do too. Anything that doesn't 
require streaming alsaplayer can do.

Have you had major problems with java plugins? In this case you should 
look into ways to get around that. (Some people have been known to 
invest in a second $10 card just for browsing).





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
