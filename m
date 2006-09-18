From: pyaggi@alsurdelsur.com
Subject: C-Media driver/device bug ?
Date: Mon, 18 Sep 2006 17:38:07 -0300 (ART)
Message-ID: <38125.24.232.131.180.1158611887.squirrel@mail.alsurdelsur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
 I'm working in a multi-capture application with alsa and i discovered
if i attach two "c-media usb headphone set" adapters to an usb hub which
is attached to my computer when i try to read from the two devices the
first one read (also open) errors with (-77) bad file descriptor status
and the other one keep working. When i attach the two devices directly to
the usb connectors (without hub) all works fine, the two devices can be
read at the same time. I proved Hubs version 1.0 and 2.0 .

Regards
Pablo


 This is the /proc/asound/cards when i attach them to the hub:
(yes i also have an intel device)

0 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with AD1980 at 0xd0201000, irq 20
 1 [default        ]: USB-Audio - C-Media USB Headphone Set
                      C-Media USB Headphone Set   at usb-0000:00:1d.1-1.3,
full speed
 2 [default_1      ]: USB-Audio - C-Media USB Headphone Set
                      C-Media USB Headphone Set   at usb-0000:00:1d.1-1.2,
full speed

and this is when i attach them directly to the computer:
0 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with AD1980 at 0xd0201000, irq 20
 1 [default        ]: USB-Audio - C-Media USB Headphone Set
                      C-Media USB Headphone Set   at usb-0000:00:1d.0-1,
full speed
 2 [default_1      ]: USB-Audio - C-Media USB Headphone Set
                      C-Media USB Headphone Set   at usb-0000:00:1d.3-2,
full speed






-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
