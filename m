From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Not important oops
Date: Wed, 21 Jan 2004 19:49:39 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401211945400.2010@pnote.perex-int.cz>
References: <200401211255.i0LCtroL006857@www1.pobox.sk> <s5h65f56t7b.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65f56t7b.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: p z oooo <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Jan 2004, Takashi Iwai wrote:

> At Wed, 21 Jan 2004 13:55:53 +0100,
> p z oooo wrote:
> > 
> > Hi,
> > 
> > When I remove control through hwdep layer on emu10k1 
> > driver when in use by oss emulation I got oops. 
> > This is because oss emulation holds pointer to this control.
> > Is there any api to disable an then enable oss emulation or 
> > only proc interface ???
> 
> hmm weird, the access to ctl elements in mixer_oss.c is restricted
> with card->controls_rwsem.  since snd_emu10k1_del_controls issues
> down_write() for it, it must be safe...

I think that he meant that slot->kcontrol members are not removed. 
We need probably rebuild the OSS mixer -> ALSA control connections when
a control - which is used with the OSS mixer code - was removed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
