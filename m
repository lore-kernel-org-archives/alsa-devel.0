From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: 1.0.12 breaks firmware loading
Date: Mon, 28 Aug 2006 23:01:46 +0400
Message-ID: <70a871c80608281201u7675f14fxffba5558acb0038b@mail.gmail.com>
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

Hi!

Another bug report.

After upgrading from 1.0.11 to 1.0.12 I can no longer use Echo Indigo
IO and RME Multiface. They both can get firmware loaded:

For indigo:
echoaudio.c:46: get_firmware(): Firmware not available (-2)

For hdsp, hdsploader gives Input/Output error.

Downgrading to 1.0.11 solves the problem.


Regards,
Dmitry.

P.S. please, cc me in your replies.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
