From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: Oops still present in lastest CVS/nm256
Date: Wed, 3 Dec 2003 11:13:38 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16334.2994.627204.332429@ronispc.chem.mcgill.ca>
References: <16323.37811.445520.249624@ronispc.chem.mcgill.ca>
	<s5hhe0sz5zm.wl@alsa2.suse.de>
	<16323.64838.222381.292418@ronispc.chem.mcgill.ca>
Reply-To: david.ronis@mcgill.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <16323.64838.222381.292418@ronispc.chem.mcgill.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I've been complaining about oops on a Sony Viao Z505S laptop, in the
end most likely due to problems with shared IRQ's.  With some helpful
suggestons of Takashi on orders of loading things (USB->ALSA->X) I
avoided a crash most of the time.

Yesterday, I upgraded to the new 2.4.23 kernel.  It seems they've
modified the IRQ sharing code.  I've been unable to get alsa to crash
the system or Oops since (including with a CVS update of an hour ago).
The order of loading the modules doesn't matter either.

Thanks for all your help.


David



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
