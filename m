From: Albert Jongkit Wong <awong@cs.washington.edu>
Subject: ppc usb-audio problems
Date: Sat, 5 Oct 2002 18:05:50 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021005180442.Q4046-100000@fiji.cs.washington.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm using gentoo linux ver 1.4rc1 on a G4 cube with gcc3.2 and
alsa-0.9.0rc3 and am having some major problems getting alsa to work
properly.

When trying to use the native alsa interface, most programs either give 
out just static or if they manage to play something coherent, the output 
is noisy and sounds as if it has been clipped.

If I try to use the OSS emulation, I get error messages like:
	No supported rate found
or 
	** WARNING **: SNDCTL_DSP_SETFMT ioctl failed: Invalid argument 
(The first is from mpg123 and the second is from xmms).

After this message, mpg123 just quits.  Xmms however, continues to 
function and actually gives clear, coorect output.  So far, no other 
program works.

Any ideas on what might be happening?  I had a similar effect with 
alsa-0.9.0rc2 on gentoo linux 1.2 using gcc-2.95.3.

Thanks,
Albert





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
