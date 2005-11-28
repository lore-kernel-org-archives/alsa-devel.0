From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Cross compiling alsa-lib
Date: Mon, 28 Nov 2005 13:05:59 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0511281304480.9343@tm8103.perex-int.cz>
References: <1133116303.8952.6.camel@localhost.localdomain> <s5hpsolkoon.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0511281250100.9343@tm8103.perex-int.cz> <s5hlkz9kmvj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkz9kmvj.wl%tiwai@suse.de>
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
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Nov 2005, Takashi Iwai wrote:

> At Mon, 28 Nov 2005 12:50:32 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Mon, 28 Nov 2005, Takashi Iwai wrote:
> > 
> > > At Sun, 27 Nov 2005 18:31:43 +0000,
> > > Adrian McMenamin wrote:
> > > > 
> > > > This is failing due to (seemingly) a missing type definition in
> > > > pcm_ladspa.c.
> > > > 
> > > > I am trying to compile this against uclibc rather than glibc... does
> > > > anyone know what the issue is and how to fix it?
> > > 
> > > An easy solution is to disable the compilation of this plugin.
> > > Remove it from src/pcm/Makefile.am, and the word "ladspa" from
> > > build_in_pcms in src/pcm/pcm.c:1940.
> > > 
> > > We can add a check of workexp.h in configure, but I think it's better
> > > to detect ulibc.  Do you have an idea how to detect ulibc?
> > 
> > I think that we already solved this issue in alsa-lib/src/conf.c .
> 
> Hmm, it also incldues wordexp.h.  Can it be really compiled?

It's superfluous. Only strcspn() is used to iterate through all 
directories.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
