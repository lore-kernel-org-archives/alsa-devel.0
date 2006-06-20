From: Remy Bruno <remy.bruno@trinnov.com>
Subject: RME HDSP
Date: Tue, 20 Jun 2006 12:18:04 +0200
Message-ID: <20060620101804.GA617@trinnov.com>
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

Hello,

I noticed that the driver hdsp.c now uses by default the "precise_ptr" mode of
the RME HDSP cards. However, at least with the last release of the RME HDSP
9652, this makes the sound scratchy (probably sound repeatedly interrupted by
short silence). It took me some time to find that this precise_ptr was the
cause of the trouble (sound is OK if I switch this off). So maybe it would be
advisable to switch back to no precise_ptr by default, letting the user the
possibility to activate it using the card controls. I imagine other people have
or will have the same problem as I have.

As I got no reply from my last message, I would just like to report again the
bug I found in hdsp.c:
there is a bug in the begining of function snd_hdsp_proc_read() of file
alsa-kernel/pci/rme9652/hdsp.c: a pair of "{}" is missing after the first "if"

if (hdsp_check_for_iobox (hdsp))
        {
                snd_iprintf(buffer, "No I/O box connected.\nPlease connect one and upload firmware.\n");
                return;
        }

The consequence was that the "return" statement was done systematically and so
the file "hdsp" always seemed to be empty.

Regards,

Remy BRUNO
