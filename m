From: John Covici <covici@ccs.covici.com>
Subject: Re: removing sndtimer causes unable to handle kernel
 paging ...
Date: Fri, 26 Apr 2002 14:30:41 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.40.0204261416040.9256-100000@ccs.covici.com>
References: <s5hwuuujr8w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwuuujr8w.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I don't have another sound card, but during the configuration step,
it said rtc callback support in kernel yes which it never does in the
2.4 kernels.  I also have this option on in the 2.5 configuration,
could this contribute to the problem?


On Fri, 26 Apr 2002, Takashi Iwai wrote:

> Hi John,
>
> At Thu, 25 Apr 2002 13:03:30 -0400,
> John Covici wrote:
> >
> > Hi.  I was trying to usekernel 2.5.x (7-9) and alsa either the one in
> > the kernel tree or beta12, and whenever snd-timer module is to be
> > removed, I get unable to handle kernel paging exception ... and the
> > system crashes.
> >
> > I am using a via8233 sound card.
> >
> > Any assistance would be appreciated.
>
> via8233 driver itself has no special timer, i.e. the only timer is
> system timer.  so i'm wondering why..
>
> could you check another soundcard if you have one?
> it'd be nice whether you can find out whether the problem lies on
> via8233 specific or not.
>
>
> Takashi
>

-- 
         John Covici
         covici@ccs.covici.com
