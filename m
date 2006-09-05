From: "Stanislas Elie" <alsa@stanelie.com>
Subject: mips problem
Date: Tue, 5 Sep 2006 12:54:04 -0400
Message-ID: <4a2338020609050954h2c1d55cet3ba8027ef85dbb5f@mail.gmail.com>
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

Hello.

I am trying to transform a netgear wgt634u wireless router into a
wireless midi node.

For this to work, I need alsa with sequencer option enabled.

I managed to compile the driver, library and utils on my platform.

However, when I do an aconnect, I get this error message :

root@OpenWrt:/# aconnect
WARNING: this snd_user_file implementation won't behave as expected.
         set BROKEN_USERFILE_DEBUG to see all problems, or
         set BROKEN_USERFILE_SILENT to disable all warnings.
ALSA lib seq.c:929:(snd_seq_open_noupdate) Unknown SEQ default
can't open sequencer
root@OpenWrt:/#

Any hints about resolving this issue?

Thanks!

Stanislas Elie

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
