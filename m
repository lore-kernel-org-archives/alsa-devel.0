From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: playback in multiple period_size?
Date: Thu, 12 Dec 2002 12:50:53 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021212205053.3929.qmail@web11507.mail.yahoo.com>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I have come to realize that, whenever I drain() on a playback_handle to which a
number of sample non-multiple of the period_size has been written, my
application waits for several seconds to finally recover with an error EIO.

Is the driver supposed to play audio if less than period_size is present in the
buffer?

Is the application supposed to always add silence at the end to ensure that a
multiple of period_size has been written?

Thanks,
Guilhem.


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
