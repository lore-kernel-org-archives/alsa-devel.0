From: Marc Giger <gigerstyle@gmx.ch>
Subject: Re: Oops on resume alsa 0.9.8
Date: Mon, 15 Dec 2003 19:20:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031215192058.5e0ba06e.gigerstyle@gmx.ch>
References: <20031215152707.38d3cb61.gigerstyle@gmx.ch>
	<Pine.LNX.4.58.0312151619050.11865@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312151619050.11865@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

I've tracked this down to the following line (if we can trust the
snd_prink() order):

wake_up(&card->power_sleep);

This function is called from 

static inline void snd_power_change_state(snd_card_t *card, unsigned int
state) 

in core.c and itself is called from

snd_ymfpci_resume(ymfpci_t *chip)

A question remains:

wake_up invokes the scheduler, right? why?

All other devices seem to properly resume from standby.
Oh, this oops seems to happen only on the first resume. If I unload the
module and load again, I can resume properly in most cases.

If you still have no idea what's going on here I will spend
more time to go deeper.

greets

Marc

On Mon, 15 Dec 2003 16:20:43 +0100 (CET)
Jaroslav Kysela <perex@suse.cz> wrote:

> On Mon, 15 Dec 2003, Marc Giger wrote:
> 
> > Hi All,
> > 
> > Since upgrading to 0.9.8 im not able to resume from apm. 
> > 
> > I'm willing to try out patches
> 
> No idea. The problem appears to be in the snd_ac97_resume() function.
> Could you try to put some printk() calls to snd_ac97_resume() and 
> snd_ymfpci_resume() functions to determine the stop point?
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
