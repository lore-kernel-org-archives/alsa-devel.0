From: "Mirabella, Mathew J" <Mathew.Mirabella@team.telstra.com>
Subject: Audigy 2 card with emu10k1
Date: Fri, 14 Mar 2003 11:15:32 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <73388857A695D31197EF00508B08F2980A00EE2C@ntmsg0131.corpmail.telstra.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel list <alsa-devel@lists.sourceforge.net>, alsa-user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

All.

I have been abel to get the audigy 2 card to work with emu10k1 but i =
have a problem.  I cannot seem to get multichannel sound and the volumes =
and levels are pretty low.

What I did was:
	get the latest emu10k1from cvs
	ensure that kernel sources are installed in the right place in =
/usr/src/
	find the right config file for the kernel modules in =
/lib/modules/(kernelname)/configs and copy this one level up and name it =
.config
	on the emu10k1 stuff do a make, then make again
	then make install
	then make tools
	then make install-tools
	edit the modules.conf file and put the lines
		alias sound emu10k1
		alias sound-slot-0 emu10k1
		alias sound-slot-1 emu10k1
	reboot and sound was there.
	i might hav had to do a emu-config -a at some stage.


I would also like to know what is sound-slot-0 and sound-slot-1.  i.e. =
what is the slot all about?  and what are the scripts for in =
/usr/local/etc/ relating to the emu10k1 and audigy?

Any help  would be appreciated.

Mat.





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
