From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: spdiff with ct5880 (ens1371)
Date: Tue, 26 Mar 2002 21:15:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203262114450.964-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.43.0203261339540.3081-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.43.0203261339540.3081-200000@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: joy ping <joy@pingfm.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Mar 2002, joy ping wrote:

> i added rev 3 of ct5880 as to have an spdiff_out in ens1370.c, cause i
> know this works with my soundcard. i did 'ensoniq->rev == CT5880REV_C
> T5880_D' cause i dont know how it works with later releases.
> maybe it could be aplied in the driver.

I've already modified driver in CVS for checks of CT5880 models. You might 
try CVS sources.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
