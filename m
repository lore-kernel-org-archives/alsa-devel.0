From: Shane Walton <dsrelist@yahoo.com>
Subject: Hamerfall Light Digi9636 and Simple Capture Program
Date: Mon, 23 Sep 2002 09:47:42 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020923164742.88829.qmail@web20810.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

In the past I developed an application with release
0.9.0beta6 on a dual 1Ghz Pentium 3 with the
Hammerfall Light.  Tha application would read 2
channels from a DAT player @48Khz.  I now must upgrade
the hardware to a dual Pentium 4 and a newer kernel.

The beta6 doesn't seem to work with the newer kernel,
which is fine, if I can use a later release like rc3. 
With this release I am unable to get any data when
configured to read 2 channels.  The data is zeroed
out.

The application is basically the "Simple Capture"
program found here,
http://www.op.net/~pbd/alsa-audio.html#captureex with
much added signal processing.  

Can anyone elaborate why the "Simple Capture" program
fails to read real data instead of zeroes?  It is the
same regardless of interleaved or planar aqcuisition.

Thank you kindly for you help.


=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
