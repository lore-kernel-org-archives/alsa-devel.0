From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: Auto detection of sound cards.
Date: Mon, 11 Feb 2002 11:09:27 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFAEEDCAAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello
Most sound cards now are Plug-n-Play either ISA or PCI.
So at boot up, one should be able to determine which devices are installed
and automatically load the correct driver based on the PnP info.

I think this would be very useful to have, because then people would not
have to know which sound card module they should be loading is.
E.g. That the "nVidia nForce sound" should use the intel8x0 driver.
The linux kernel with alsa should have already known this and selected the
correct driver automatically in much the same way windows 98 does.

As I see linux now, it will autoload modules based on the alias lines in
modules.conf.
e.g.
alias sound-slot-0 snd-card-emu10k1

Is there any tool in linux which will automatically create these alias lines
in modules.conf based on the PnP info. ?

Cheers
James



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
