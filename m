From: Anders Johansson <ajh@watri.org.au>
Subject: vxpocket 440
Date: Fri, 27 Oct 2006 17:37:47 +0800
Message-ID: <20061027093747.GA29589@watri.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to configure a VX-Pocket 440 on a DELL laptop, Debian
etch, Kernel version 2.6.17.

I have the same card running on a SONY laptop with Debian sarge and a
2.6.8 kernel, no problem.


Syslog says:
Oct 28 01:19:29 asil kernel: pccard: PCMCIA card inserted into slot 0
Oct 28 01:19:29 asil kernel: pcmcia: registering new device pcmcia0.0
Oct 28 01:19:29 asil kernel: vxpocket: too many cards found
Oct 28 01:19:29 asil kernel: snd-vxpocket: probe of 0.0 failed with error -22
Oct 28 01:19:29 asil kernel: vxpocket: too many cards found
Oct 28 01:19:29 asil kernel: snd-vxpocket: probe of 0.0 failed with error -22


vxloader says:
vxloader: no VX-compatible cards found


cardctl info:
PRODID_1="Digigram"
PRODID_2="VX-POCKET440"
PRODID_3="V1.0"
PRODID_4="R1.0"
MANFID=01f1,0100
FUNCID=254


cardctl ident:
Socket 0:
  product info: "Digigram", "VX-POCKET440", "V1.0", "R1.0"
  manfid: 0x01f1, 0x0100
  function: 254 ((null))


Which looks fine to me.

 
I understand that hotplug is supposed to be able to load firmware
nowdays, but where can I find the firmware? is it the same as in the
alsa-frmware package? and in that case which files, and where do I put
them?


Cheers,
//Anders

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
