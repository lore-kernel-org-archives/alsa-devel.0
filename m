From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [patch] envy24control save state of LRGang button
 in config file
Date: Wed, 27 Jul 2005 08:56:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507270855510.8129@tm8103.perex-int.cz>
References: <42E66ECA.10407@cubic.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E66ECA.10407@cubic.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk Jagdmann <doj@cubic.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Jul 2005, Dirk Jagdmann wrote:

> Hello Developers,
> 
> this patch saves the state of the "LR Gang" buttons in a config/pref 
> file, because this button's state is not preserved throughout runs of 
> envy24control. At present it only works, when envy24control is compiled 
> with GTK2 as I have used routines which were introduced with Glib2.

Applied to CVS.

> While this works fine I think we should discuss if envy24control 
> could/should be compiled with gtk2 by default (currently gtk1 is 
> default). As I think all Linux distributions now ship with Gtk2 and most 
> other software uses gtk2 by now, I think it would be a reasonable thing 
> for the next release of Alsa. This would also mean, that this patch will 
> work with the default configuration :)

Any objections from others?

					Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
