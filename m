From: "Yon Mercury" <swirlee@stickist.com>
Subject: RE: Fw: Re: Echo Audio Indigo Generic Driver
Date: Tue, 2 Nov 2004 13:45:58 -0700
Message-ID: <20041102204558.M92165@stickist.com>
References: <20041101212127.M93673@stickist.com> <XFMail.20041102093551.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20041102093551.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>, Yon Mercury <swirlee@stickist.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Giuliano,

Oh good, I'm glad I got your attention. I'm not fluent in the CARDBUS
architecture. How does Echo handle this multiple bridge issue in Windows? Or
is it handled by a separate bridge driver? If so, perhaps we need to add
another layer to the ALSA architecture to handle different bridges. 

I think that cardbus components not specific to the Echo Audio card should be
handled by another team. I'm more an applications developer, but I'll support
you in whatever way I can. 

-Jan


On Tue, 02 Nov 2004 09:35:51 +0100 (CET), Giuliano Pochini wrote
> On 01-Nov-2004 Yon Mercury wrote:
> > Dear ALSA-listers:
> >
> > This from Echo Audio, in response to my inquiry about an Indigo IO driver:
> >
> > I hope we can get a good low-end low latency laptop solution soon-- those
> > RME boards are expensive!
> 
> I'm the one who developed the ALSA driver. Echoaudio told me
> that dev infos required for Indigo support will be released
> soon. But there is another problem: those infos are not enough.
> My driver already supports all other PCMCIA cards, but none
> of the people who tried it was able to make it work. The
> problem lies in the CARDBUS bridge and reading the archives of
> this ML I found that some people had troubles with RME cards,
> too. An Echoaudio developer confirmed that he had to tweak the
> registers of the bridge of one laptop to make it work. The
> problem is complicated by the fact that there are several tens
> of bridge chips around (read: different laptop --> different
> fix) and all I get from the DSP is "init OK" or "init failed".
> I have no idea of what the problem is. Suggestions are welcome.
> 
> --
> Giuliano.






-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
