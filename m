From: Kristof vansant <de_lupus@pandora.be>
Subject: I think MSI KT6 Delta-SR also needs VIA_DXS_NO_VRA in whitelist
Date: Wed, 11 Feb 2004 13:48:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076503685.9299.11.camel@D5E03F95.kabel.telenet.be>
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

I noticed that the ASUS A7600 is in the whitelist.
I have the same chipset but on a msi motherboard.
But ASUS has the ADI AD1980 SoundMAX 6-channel CODEC S/PDIF out
interface and I have C-Media Electronics CMI9739.

If the codec chip doesn't mater should the MSI motherboard also be
added?
If yes where can I find the .vendor and .device ID?

cat /proc/something? 

this is from the alsa-kernel/pci/via82xx.c:
{ .vendor = 0x1043, .device = 0x80b0, .action = VIA_DXS_NO_VRA }, /*
ASUS A7V600 & K8V*/ 


See for your self:

http://www.msi.com.tw/program/products/mainboard/mbd/pro_mbd_detail.php?
UID=474

http://www.asus.com/prog/spec.asp?m=A7V600&langs=01





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
