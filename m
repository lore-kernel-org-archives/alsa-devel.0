From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 0/5] ASoC: Alsa Sytem on Chip layer
Date: Fri, 15 Sep 2006 14:16:09 +0100
Message-ID: <1158326169.22950.61.camel@localhost.localdomain>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm about to send a series of patches for the ALSA System on Chip layer
core code and documentation. Patches for actual platform, machine and
codec support will follow in later series.

I've broken the core patches down to into manageable chunks for easier
review.

ASoC is designed to provide audio (through ALSA) for low power handheld
devices (e.g. PDA's, phones) and to allow codec and platform driver code
reuse.

More information can be found here :-

http://www.rpsys.net/openzaurus/patches/alsa/info.html


Currently working machines include :-

 o Spitz (WM8750 + pxa2xx I2S)
 o Corgi (WM8731 + pxa2xx I2S)
 o Tosa (WM9712 + pxa2xx AC97)
 o Poodle (WM8731 + pxa2xx I2S)
 o Eti_b1 (WM8731 + AT91RM9200 I2S)
 o Mainstone (Numerous codecs pxa2xx AC97, I2S and SSP)

Patches to follow....

Liam







-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
