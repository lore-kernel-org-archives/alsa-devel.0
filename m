From: Carolyn and Eric Hathaway <hathaway@uplink.net>
Subject: 1.0.0pre1: au88x0 driver locks up kernel
Date: Thu, 20 Nov 2003 00:42:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBC5449.3050304@uplink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

I'm running RedHat 7.3 (RH kernel 2.4.20-20.7, gcc 2.96-113), and have a
generic Aureal Vortex 1 card (au8820 chipset).  Compiling and installing
the 1.0.0pre1 ALSA driver works fine, but if I do a 'modprobe
snd-au8820', the computer locks up instantly (can't even ssh in from
another computer).

Going back through recent CVS commits, I found that the problem is
caused by the changes described in the following alsa-cvslog message:

http://sourceforge.net/mailarchive/message.php?msg_id=6552838

Specifically, the problem is caused by the changes Takashi made to
au88x0.h and au88x0.c to eliminate calls to pci_request_regions() and
pci_release_regions().  If I revert those two files to their previous
versions, the driver compiles and works fine.  I'm not an ALSA driver
guru, but I didn't see anything immediately wrong with the changes
introduced by the above CVS commit that would cause such a drastic
kernel error.  Perhaps someone more familiar with the code in question 
could take another look at those changes?

Regards,
-Eric Hathaway




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
