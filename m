From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: trying out usb hotplugs
Date: Fri, 29 Nov 2002 15:05:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211291454330.532-100000@pnote.perex-int.cz>
References: <s5hof88bmmp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof88bmmp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Nov 2002, Takashi Iwai wrote:

> Hi,
> 
> the attached is my latest patch.
> could you check it?

Let's go and make things more complicated (like in my tree on disc):

1) waiting for time when all disconnected applications have closed
   all file descriptors is a bit problem, because no new/other USB devices 
   can be connected/disconnected; in my tree, I use thread to postpone 
   freeing of snd_card_t structure
2) replace file->f_op with fake operations which allows only original 
   release() callback in snd_card_disconnect(); this point makes things 
   more and more simple than your code (check all accesses), because we 
   need to count only open/release calls
3) the unfinished problem is still: how to behave, if the disconnect event
   comes in the middle of some code; you're right at this point, the 
   lowlevel driver must handle it

Please, remove from your code any checks from ioctl(), poll(), read() / 
write(). Then commit and I'll merge my tree with yours.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
