From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Acquring poll descriptors
Date: Wed, 23 Jul 2003 09:14:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307230911410.6261-100000@pnote.perex-int.cz>
References: <1058912365.3f1db86de8730@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1058912365.3f1db86de8730@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "aknuds-1@broadpark.no" <aknuds-1@broadpark.no>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Jul 2003, aknuds-1@broadpark.no wrote:

> Hi
> 
> Was just wondering if there is any particular reason to acquire a pcm's poll 
> descriptor(s) (snd_pcm_poll_descriptors) before each poll, or can I simply do it 
> after opening the pcm and be done with it? Can the associated poll fds, or even 
> the number of fds change after a pcm has been opened?

No, it's static. You can preallocate fds once.

Don't forget to call ....revents() to get proper poll events.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
