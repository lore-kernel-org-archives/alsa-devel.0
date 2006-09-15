From: Julian Scheel <julian@jusst.de>
Subject: ice1724/Audiotrak Prodigy 7.1 HiFi
Date: Fri, 15 Sep 2006 21:11:03 +0200
Message-ID: <200609152111.03266.julian@jusst.de>
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

I just got a Audiotrak Prodigy 7.1 HiFi card, which is baed upon a Envy24HT 
chipset in combination with one WM8776 codec for front out and a WM8766 for 
channel 3-8.
I made the front out working, taking the code from pontis.c - Now I'd like to 
add support for the other channels, therefore I need to figure out the 
I2C-base-address for the WM8766 registers.
Can you provide me with some help on how to figure that out? I'm a newbie to 
alsa/soundcard driver development.
Reading the envy24ht-specs didn't help me, yet.

One more question: Should I merge my code into pontis.c, which would blow it a 
bit up, but would avoid duplicate code, or should I open a new 
prodigy_hifi.c/h?

Cheers,
Julian

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
