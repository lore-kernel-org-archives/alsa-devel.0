From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Event Based time synchronization with ALSA
Date: Mon, 17 Jan 2005 20:46:17 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0501172044010.2201@pnote.perex-int.cz>
References: <41EB9874.4060407@hypersonic.it> <41EBEB8F.9030009@gardena.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41EBEB8F.9030009@gardena.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benno Senoner <sbenno@gardena.net>
Cc: Paolo Losi <p.losi@hypersonic.it>, alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Jan 2005, Benno Senoner wrote:

> 10msec = 441 samples, thus I'd choose 512 samples (alsa period sizes 
> must be power of 2).

It's not true. You may use any size which hardware / end plugin supports, 
but it's true that many drivers don't allow other period sizes that 
power of 2.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
