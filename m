From: "Rich Rattanni" <rattanni@gmail.com>
Subject: ALSA driver problem after standby/resume
Date: Mon, 19 Mar 2007 12:31:16 -0400
Message-ID: <3187bd480703190931t919183ej9a54ff4fc3cba89b@mail.gmail.com>
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

All:

I have noticed a strange behaviour in the ALSA driver that seems to be
occur after initiating a power standby and resume.  I am working on an
application that uses FusionSound to playback OGG audio files.  When
the application recognizes it is idle, it tells the OS to enter
standby mode.  Upon resuming from standby, the ALSA API call made by
fusionsound no longer acts as a blocking read, instead it returns
immediately.  I have confirmed this with Denis Oliver Kropp of the
DirectFB / FusionSound project.  He suggested that the ALSA driver
should be repaired to prevent this problem from occuring.

The system specifications are...
Linux            -   Openembedded distro linux kernel 2.6.20
GCC             -    4.1.1
ALSA            -    1.0.13-r1
FusionSound - 0.9.26-r0

I guess I am looking for confirmation of this behavior with ALSA and
any possible suggestions to patch the driver to operate correctly with
power management functions under linux.

Thanks in advance,
Rich

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
