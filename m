From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Wed, 25 Feb 2004 12:05:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402251202580.10484@pnote.perex-int.cz>
References: <200402241659.QAA28077@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200402241659.QAA28077@liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Will <walsac2@liam2.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Feb 2004, Will wrote:

> Jaroslav Kysela <perex@suse.cz> wrote:
> >
> >changes. It would be nice, if you can test my changes and report me bugs
> >or comments (especially to the new OSS redirector code).
> >
> 
> What do you think of my bug report on ALSA OSS emulation of
> /dev/sequencer? I posted it at
> http://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=28
> but there haven't been any followup posts. The /dev/sequencer part of
> the OSS emulation is really very broken. Do you think it's something you
> can easily fix?

Well, it's question if it's worth to take care. I think that we have far 
more better applications using directly ALSA sequencer API.

But if you send me a small code which shows the bug - like in 
alsa-driver/test/seq1.c etc, then I will try to fix it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
