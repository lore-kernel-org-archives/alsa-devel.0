From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: jack plugin?
Date: Tue, 28 Oct 2003 21:06:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031028210623.36867d0d.mista.tapas@gmx.net>
References: <20031027175032.1d0760f3.mista.tapas@gmx.net>
	<s5h7k2p61f1.wl@alsa2.suse.de>
	<s5hekwx44ht.wl@alsa2.suse.de>
	<s5hbrs1443p.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrs1443p.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Oct 2003 19:19:38 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> also works for me (although bunch of debug messages appear - fixed on
> cvs now).
> 
> sorry, your problem is not reproducable on my machine.
> possibly depending on JACK version?
> 


Hmm, let me ask some questions, then i can maybe give a better report
afterwards?

What formats are alsa-plugins usually? [.so, .sa]
What format is used by the jack plugin
Which paths does libalsa look at when loading a plugin?
How does the makefile of the jack plugin determine, where the plug goes?

Regards
Florian Schmidt


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
