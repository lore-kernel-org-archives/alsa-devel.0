From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Alsa driver PCMCIA question.
Date: Thu, 21 Apr 2005 22:33:09 +0100
Message-ID: <42681C15.1020709@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have a PCMCIA sound card that as soon as I insert it, it appears as a
PCI device, and lspci lists it.
It even appears if cardmgr is not running.
pci commands work on it.
e.g.
 pci_read_config_byte(pci, PCI_REVISION_ID, &revision);

and
port = pci_resource_start(pci, 0);

does return the base port io for the card, as listed by lspci.

The problem comes when I do:
value = inl(port);

The whole PC just hangs at that point, and I have to reboot it.

Is there some extra api calls I have to make in order to get the inl()
command to work?

James


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
