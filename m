From: Russ Garrett <russ@garrett.co.uk>
Subject: "does not support 28bit PCI busmaster DMA" on AMD64
Date: Thu, 29 Apr 2004 19:32:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1083263559.6227.39.camel@localhost>
Reply-To: russ@garrett.co.uk
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Just upgraded my system to an Athlon 64 processor, specs are:

Athlon 64 3200+
Gigabyte GA-K8N Pro (nForce3)
M-Audio Audiophile 2496 Sound card (Ice1712)
Linux 2.6.5

Whenever I try to modprobe snd_ice1712, I get the following error in
dmesg:

architecture does not support 28bit PCI busmaster DMA
ICE1712: probe of 0000:01:0a.0 failed with error -6


Russ Garrett
russ@garrett.co.uk



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
