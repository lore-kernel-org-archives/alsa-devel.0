From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: add per-voice PTR register
	dump	to /proc entry
Date: Fri, 19 Nov 2004 17:38:39 -0500
Message-ID: <1100903920.13712.20.camel@krustophenia.net>
References: <1100394086.2458.18.camel@krustophenia.net>
	 <s5hlld0smj2.wl@alsa2.suse.de> <1100709062.6930.5.camel@krustophenia.net>
	 <s5hmzxfqok5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzxfqok5.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-11-18 at 14:22 +0100, Takashi Iwai wrote:
> > > I feel it'd be better to create another proc file.  Not necessarily
> > > per voice, though.  The dump seems not matching with the current
> > > emu10k1 proc file contents.
> > > 
> > 
> > Sure, will do.  One file per voice for the PTR registers (and one file
> > for FN0) might actually be most useful.  This way you can diff them.
> 
> Yes, that makes sense.

How do I create a new directory under /proc/asound/my_card?  Cresting a
file is easy, but I cannot find an example of a driver that creates a
directory and populates it.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
