From: James Tappin <sjt@star.sr.bham.ac.uk>
Subject: Re: the last changes to trident driver
Date: Wed, 8 Jan 2003 13:13:04 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030108131304.6147b392.sjt@star.sr.bham.ac.uk>
References: <s5hn0md9c9s.wl@alsa2.suse.de>
	<20030107232051.2861d226.james@tappin.me.uk>
	<s5hbs2s9cns.wl@alsa2.suse.de>
	<20030108110650.1d579069.sjt@star.sr.bham.ac.uk>
	<s5h8yxvam1u.wl@alsa2.suse.de>
	<20030108125227.4ee7ff0a.sjt@star.sr.bham.ac.uk>
	<s5h4r8jaj1c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r8jaj1c.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: james@tappin.me.uk, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 08 Jan 2003 14:05:35 +0100
Takashi Iwai <tiwai@suse.de> wrote:

TI> > P.S. any ideas on the incompatibility with a kernel with gameport
TI> > enabled as modules?
TI> 
TI> ehm, i thought you had compiled the driver with a different kernel
TI> tree?  you build the modules with versions, so it must be
TI> incompatible...

No, even after I fixed that problem, it still gave unresolved symbols
until I disabled the gameport stuff in the kernel and rebuilt that,
rebooted with the new kernel and did a clean rebuild of ALSA.

James

-- 
+------------------------+-------------------------------+---------+
| James Tappin           | School of Physics & Astronomy |  O__    |
| sjt@star.sr.bham.ac.uk | University of Birmingham      | --  \/` |
| Ph: 0121-414-6462. Fax: 0121-414-3722                  |         |
+--------------------------------------------------------+---------+


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
