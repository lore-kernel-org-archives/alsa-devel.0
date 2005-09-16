From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: au88x0 modem
Date: Fri, 16 Sep 2005 21:05:00 +0300
Message-ID: <20050916180500.GC17864@tecr>
References: <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <4329946B.9030407@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4329946B.9030407@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 23:34 Thu 15 Sep     , Raymond wrote:
> Sasha Khapyorsky wrote:
> >
> >
> >Great, the secondary modem codec is there. The valid codec id bits are
> >24:25 (AC97 interface supports up to four codecs):
> >
> >#define VORTEX_CODEC_ID_SHIFT 24
> >
> >I will send cleaned codec access patch separately and will look what is
> >next.
> 
> 
> It would be more easy to debug/maintain the driver if using different
> read/write routines for audio and modem codec.
> 
> Audio codec is always primary in sound card and audio/modem combo
> 
> The existing vortex_codec_read() and vortex_codec_write() can remain
> unchanged.

Don't think so. It is about chip support (ac97 controller) and not about
cards, current codec_read/write are not correct since ignore ac97.num
value. And it is not about modem, but about secondary codec(s).

Request secondary codec initialization or not is different story, this
may be card specific.

Sasha.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
