From: Kristof vansant <de_lupus@pandora.be>
Subject: Re: I think MSI KT6 Delta-SR also needs
	VIA_DXS_NO_VRA in whitelist
Date: Wed, 11 Feb 2004 16:02:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076511720.10073.2.camel@D5E03F95.kabel.telenet.be>
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

This: ?


0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/
A/8235 AC97 Audio Controller (rev 60)

0000:00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 1462:5901
        Flags: medium devsel, IRQ 11
        I/O ports at d800
        Capabilities: [c0] Power Management version 2


At Wed, 11 Feb 2004 13:48:05 +0100,
Kristof vansant wrote:
> 
> I noticed that the ASUS A7600 is in the whitelist.
> I have the same chipset but on a msi motherboard.
> But ASUS has the ADI AD1980 SoundMAX 6-channel CODEC S/PDIF out
> interface and I have C-Media Electronics CMI9739.
> 
> If the codec chip doesn't mater should the MSI motherboard also be
> added?
> If yes where can I find the .vendor and .device ID?
> 
> cat /proc/something? 

lspci -nv and check subsytem ids.


Takashi





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
