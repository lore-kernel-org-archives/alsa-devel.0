From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: I/O Error in mmapping ES 1969
Date: Fri, 10 Oct 2003 14:58:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310101456040.18818@pnote.perex-int.cz>
References: <200310101255.h9ACturd017106@oud>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310101255.h9ACturd017106@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "Dr. med. =?iso-8859-15?q?G=FCnther?= Montag" <Safari.Doktor@addcom.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Oct 2003, Paul Davis wrote:

> >I mentioned my ham radio realtime program with mmap
> >in a posting on 3. Oct and before.
> >It works now with ALSA 0.9.7 with AC97 and maybe some other cards, thanks!!!
> >With ESS ES1969 mmap(ibuf, isize, PROT_READ, MAP_FILE | MAP_SHARED |
> >MAP_FIXED, fd_audio, 0)
> >(and I tried also all other MAP_ options) it breaks with I / O error.
> >Do You know some help about mmap besides man,
>
> IIRC, mmap with OSS doesn't work unless you use the LD_PRELOAD
> hack. this loads a library that intercepts all standard system calls
> and routes them through alsa-lib. your app will not run without
> this. why? mmap provides direct access to the DMA buffer of the
> hardware, and thus bypasses most of what alsa-lib does. ALSA does
> support such direct access, but not in the simplistic way that OSS
> provides.
>
> or can I do something with "Scatter Gather" in ALSA API,
> >or does it help if i work myself into JACK for this problem?
> >hints welcome, tnx!!!
>
> either use ALSA natively, or use JACK, or use the LD_PRELOAD hack.

Fully agree. Just to clarify: In-kernel OSS's mmap can be used when
the soundcard's DMA buffer has exactly same parameters as
application requested. We cannot do any automatic conversions
like in the read()/write() case.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
