From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rc4 lib - build failing
Date: Wed, 23 Oct 2002 11:22:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210231118160.5772-100000@pnote.perex-int.cz>
References: <1035362233.3179.10.camel@hamish.iriXx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1035362233.3179.10.camel@hamish.iriXx.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: m <m@iriXx.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 23 Oct 2002, m wrote:

> sure, its GNU ld version 2.11.92.0.12 20011121

What is your distribution?

> should we upgrade our ld? it would explain a *lot* of problems i've had
> with compiles if there is a faulty ld out there...

Hmm. The situation seems to be more difficult.

ld 2.9.1.0.25	- does not work (SuSE 6.3)
ld 2.10.0.33    - works (SuSE 7.1)

Perhaps, we have a specific patch for binutils..

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
