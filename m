From: peter plessas <plessas@mur.at>
Subject: hdsploader on ppc
Date: Sun, 20 Mar 2005 01:29:20 +0100
Message-ID: <423CC3E0.2020408@mur.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
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

Dear list,

this is a bit complicated, due to big/little endian issues, perhaps.
I am trying to load the firmware into my hdsp pcmcia card.

I am getting the fifo timeout:

peter:~# hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : PowerMac Screamer Rev 0
Card 1 : RME Hammerfall DSP at 0xf3000000, irq 58
Upload firmware for card hw:1
Hwdep ioctl error on card hw:1 : Input/output error.

I am using debian testing, running a 2.6.8 kernel with manually compiled 
1.0.8 alsa drivers on a G3 powerpc laptop.

cardbus version is 11 (rev 0b)

the card is loadable out of osx.

i am stuck here, and don't know what to do now, i also hope this topic 
suits to the alsa-devel list.

any suggestions are very welcome!

thanks,
Peter


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
