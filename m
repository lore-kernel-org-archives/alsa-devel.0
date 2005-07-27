From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Envy24control -SPDIF bug and maybe improvements?
Date: Wed, 27 Jul 2005 09:04:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507270902130.8129@tm8103.perex-int.cz>
References: <200507262109.54095.alan@horstmann.fsworld.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200507262109.54095.alan@horstmann.fsworld.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan H <alan@horstmann.fsworld.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Jul 2005, Alan H wrote:

> Hi,
> 
> Recently I reported a bug with DMX6fire and SPDIF inputs (bugtrack 
> alsa-tools 0001214), and then, as reported there, happened to find the 
> problem myself when perusing the source code.
> 
> As a user of the DMX6fire and an electronics engineer, I am newish to 
> Linux and software.  However, as I had ended up looking at the source 
> code and had ideas for improvements to the controls and usability of 
> 'e24c', I altered it in stages, and resulted in a neater, easier version 
> for me to use.
> 
> How can this alternative be considered/made available for others -for 
> example where could I put a tarball of the 3 major version stages of the 
> changed files?  These versions are all up to date with the released 
> alsa-1.0.9.
> 
> Is there a better way to approach such development, if I am considering 
> other improvements?

Please, provide us a patch against ALSA 1.0.9 or better against ALSA CVS..
Patch can be generated via this command:

diff -ru <old_dir> <new_dir>

We will review the patch and if it's ok, we'll apply it to ALSA 
mainstream.

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
