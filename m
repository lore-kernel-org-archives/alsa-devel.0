From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Oops on resume alsa 0.9.8
Date: Mon, 15 Dec 2003 16:20:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312151619050.11865@pnote.perex-int.cz>
References: <20031215152707.38d3cb61.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031215152707.38d3cb61.gigerstyle@gmx.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Dec 2003, Marc Giger wrote:

> Hi All,
> 
> Since upgrading to 0.9.8 im not able to resume from apm. 
> 
> I'm willing to try out patches

No idea. The problem appears to be in the snd_ac97_resume() function.
Could you try to put some printk() calls to snd_ac97_resume() and 
snd_ymfpci_resume() functions to determine the stop point?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
