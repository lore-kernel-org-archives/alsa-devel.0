From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rc3?
Date: Wed, 14 Aug 2002 18:02:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208141758440.1095-100000@pnote.perex-int.cz>
References: <s5hd6slh24v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6slh24v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Aug 2002, Takashi Iwai wrote:

> At Wed, 14 Aug 2002 17:24:51 +0200,
> Clemens Ladisch wrote:
> > 
> > Are there any plans for the release date of 0.9.0rc3?
> > 
> > It would be nice if users would be able to get the USB MIDI driver
> > from an easy-to-install package instead of having to go through CVS.
>  
> agreed.
> 
> on my side, there are no big changes as pending jobs.
> only subtle fixes are missing which atm i'm still working on.
> 
> perhaps we can release rc3 soon after rewriting all the struct
> initialization in C99 styles.
> 
> Jaroslav, any other plans?

Could you move usb stuff to alsa-kernel? I spoked with Greg face to face
at Kernel Summit about the place for the ALSA USB code, and his opinion is
that we can freely use our place at sound/usb not drivers/usb/class.

I'll finish C99 struct initializers in the meantime.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
