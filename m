From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] envy24control.[ch] update for hoontech   
 cards.
Date: Mon, 16 Dec 2002 15:25:26 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212161517540.503-100000@pnote.perex-int.cz>
References: <20021216001517.2A6C93A9D@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021216001517.2A6C93A9D@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Henry Walpool <apkennedy@firstlinux.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 15 Dec 2002, Henry Walpool wrote:

> The Hoontech Media 7.1 card has a consumer/professional option at least
> under windows. I would assume that with the correct information from
> hoontech one could program this under alsa. Of course I don't have a
> clue, I'm just guessing here.

It's possible that newer cards can drive this control via GPIO, but I have 
no information about the Media 7.1 version.

						Jaroslav

> --- Jaroslav Kysela <perex@suse.cz> wrote:
> >On Sat, 14 Dec 2002, Henry Walpool wrote:
> >
> >> Added some code to block out the error messages for the hoontech cards
> >> when someone tries to access the professional/consumer option. I tried
> >> to get the information from hoontech but no luck. I don't think it would
> >> be that hard to add the correct code to enable these functions but
> >> hoontech is not talking unfortunately. Hoontech even stopped responding
> >> to my e-mails. The last response I got was "e-mail the alsa-developers".
> >> "They have all the information about hoontech cards already."
> >
> >The original hoontech cards have hardwired support (in hardware) for 
> >consumer mode only.

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
