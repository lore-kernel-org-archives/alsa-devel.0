From: James Tappin <sjt@star.sr.bham.ac.uk>
Subject: Re: the last changes to trident driver
Date: Wed, 8 Jan 2003 12:52:27 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030108125227.4ee7ff0a.sjt@star.sr.bham.ac.uk>
References: <s5hn0md9c9s.wl@alsa2.suse.de>
	<20030107232051.2861d226.james@tappin.me.uk>
	<s5hbs2s9cns.wl@alsa2.suse.de>
	<20030108110650.1d579069.sjt@star.sr.bham.ac.uk>
	<s5h8yxvam1u.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yxvam1u.wl@alsa2.suse.de>
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

On Wed, 08 Jan 2003 13:00:29 +0100
Takashi Iwai <tiwai@suse.de> wrote:

TI> At Wed, 8 Jan 2003 11:06:50 +0000,
TI> James Tappin wrote:
TI> > 
TI> > On Wed, 08 Jan 2003 11:08:39 +0100
TI> > Takashi Iwai <tiwai@suse.de> wrote:
TI> > 
TI> > TI> At Tue, 7 Jan 2003 23:20:51 +0000,
TI> > TI> James Tappin wrote:
TI> > TI> > 
TI> > TI> > On Tue, 07 Jan 2003 17:04:47 +0100
TI> > TI> > Takashi Iwai <tiwai@suse.de> wrote:
TI> > TI> > 
TI> > TI> > > Hi,
TI> > TI> > > 
TI> > TI> > > if someone has a Trident 4DNX (not DX), could you test the
TI> > TI> > > latest CVS driver?  i hope my last change doesn't break,
TI> > TI> > > but i couldn't test the board atm...
TI> > TI> > > 
TI> > TI> > > 
TI> > TI> > 
TI> > TI> > Hi Takashi,
TI> > TI> > 	I've managed to resolve my unresolved references problem
TI> > TI> > 	by rebuilding
TI> > TI> > the kernel without gameport support, but now attempting to
TI> > TI> > aplay a wav file produces an immediate segfault (but it
TI> > TI> > refuses to dump core).
TI> > TI> 
TI> > TI> hmm, perhaps it caused oops in kernel.
TI> > TI> could you check the kernel message and get the trace via
TI> > TI> ksymoops if possible?
TI> > TI> 
TI> > 
TI> > I've just logged into the machine from work and looked back at the
TI> > system logs and this is what I see from "ksymoops syslog.0":
TI> > 
TI> 
TI> hmm, unfortunately the stack wasn't parsed correctly with symbols.
TI> did you build the alsa drivers with debug option
TI> (--with-debug=full)? anyway, please rebuild the drivers with the
TI> attached patch (and debug option, if not yet).  i hope a fatal oops
TI> or hang-up can be avoided now...
TI> oh, also, please update the cvs tree again.  i've done some changes
TI> since yesterday.

As far as I can tell that works, i.e. the modules load, aplay plays a
wav file and there's nothing in /var/log/syslog -- I can't tell if any
sound's coming out.

Best regards,
	James

P.S. any ideas on the incompatibility with a kernel with gameport
enabled as modules?

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
