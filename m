From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Q2: Driver notified of MMAP commit.
Date: Thu, 01 Feb 2007 16:37:33 +1300
Message-ID: <45C1607D.3090202@audioscience.com>
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

Greetings,

I am trying to add mmap support to our driver (asihpi).

I'm looking for a way for the driver to be notified when the application
commits more data into the mmapped buffer, so I can pass that on to our
DMA engine.  Is there a driver operation that does this?

Aside: Is it true that ALSA assumes that once DMA is started, it will
run round and round the circular buffer forever (until stopped) no
matter whether there is valid data there or not?

Our DMA operates differently in that it only takes valid data, and then
stops until more data is written to the buffer.   In this case the
detection of xrun condition is difficult...

thanks

Eliot

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
