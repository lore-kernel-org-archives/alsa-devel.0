From: Wiebe Cazemier <halfgaar@gmx.net>
Subject: Inverted front speakers on sb live
Date: Thu, 06 Jul 2006 10:32:38 +0200
Message-ID: <e8ihr6$jq$1@sea.gmane.org>
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

Hi,

Most SB live soundcards have the front speaker signal inverted. With the old
OSS driver, it was possible to load a DSP patch into the signal processor to
correct this. The alsa tools package does provide the as10k1 compiler, but I
can't seem to find a way to load the program, if it is even compatible with
the Alsa driver.

Is there a way with Alsa to correct this very annoying behaviour? There is a
control called "Sigmatel Surround Phase Inversion Playback" in the mixer, but
it does nothing.

Thanks in advance


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
