From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: multiple devices per card?
Date: Sat, 5 Oct 2002 09:16:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210050916130.504-100000@pnote.perex-int.cz>
References: <20021004213711.48471.qmail@web11503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021004213711.48471.qmail@web11503.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 4 Oct 2002, Guilhem Tardy wrote:

> This card can open / close N audio streams independently. Each audio stream can
> be matched to a different port (e.g. mike in, line in) or the same, with
> different formats if necessary.
> 
> Following your earlier message, I'd guess that a) is the solution. Then, only
> one mixer is enough to handle all the devices.
> 
> Any other idea?

I agree, a) is the right choice if all streams are independant.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
