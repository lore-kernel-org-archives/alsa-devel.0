From: Ondrej Zary <linux@rainbow-software.org>
Subject: ESS ES1869 integrated in notebook - PnP not working
Date: Sun, 23 Jul 2006 14:21:12 +0200
Message-ID: <200607231421.12286.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailhub3.nextra.sk (smtp3.nextra.sk [195.168.1.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5BD616A
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 14:21:19 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I have DTK notebook with integrated ESS ES1869 sound. The problem is that PnP 
does not work with ALSA driver and I have to use isaspnp=0 parameter.
The card probably does not have its own EEPROM and its 3 IDs are inserted into 
system BIOS (as it's not found by ISA PNP but found by PNP BIOS). lspnp 
shows:
[...]
00:18 ESS0006 (unknown)
00:19 ESS001 (unknown)
00:1a ESS1869 (unknown)

I think that the problem is caused by es18xx.c which uses 
pnp_register_card_driver() and other pnp_card things which probably do not 
work when the PnP device does not look like ISA card but like 3 PnP devices.

-- 
Ondrej Zary

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
