From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: AC97 touchscreen support
Date: Thu, 1 Feb 2007 14:32:56 +0100
Message-ID: <20070201133256.GA22155@roarinelk.homelinux.net>
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hello,

Is it possible for the ALSA AC97 layer to support
a AC97 touchscreen (such as the Wolfson 97xx series
or the ucb1400) in a generic way? I.e. can I access
certain registers in the codec from a "platform" driver
which uses the ac97 bus instead of the platform bus?
(Is there something like a "struct ac97_driver" which
works like the "struct platform_driver"? )

Thanks!

-- 
 ml.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
