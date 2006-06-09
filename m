From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Bug in hdsp.c
Date: Fri, 9 Jun 2006 18:49:02 +0200
Message-ID: <20060609164902.GA26734@trinnov.com>
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

Hi,

There is a bug in the begining of function snd_hdsp_proc_read() of file
alsa-kernel/pci/rme9652/hdsp.c: a pair of "{}" is missing after the first "if"

if (hdsp_check_for_iobox (hdsp))
        {
		snd_iprintf(buffer, "No I/O box connected.\nPlease connect one and upload firmware.\n");
		return;
        }

The consequence was the "return" statement to be done systematically and so the
file "hdsp" always seemed to be empty.

Regards,

Remy BRUNO
