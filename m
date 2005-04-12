From: "Jared D. McNeill" <jared.mcneill@gmail.com>
Subject: Re: intel8x0m and conexant ac97 modem codecs
Date: Tue, 12 Apr 2005 15:14:53 -0300
Message-ID: <41d6f0b905041211143edfd71e@mail.gmail.com>
References: <41d6f0b90504120905d469db0@mail.gmail.com>
	 <1113329101.31159.23.camel@mindpipe>
Reply-To: "Jared D. McNeill" <jared.mcneill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1113329101.31159.23.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net, jmcneill@netbsd.org
List-Id: alsa-devel@alsa-project.org

On Apr 12, 2005 3:05 PM, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-04-12 at 13:05 -0300, Jared D. McNeill wrote:
> > Hi folks, not sure if this is the right place to ask but I might as
> > well give it a shot anyway --
> >
> > I'm working on adding AC97 modem support to NetBSD, and I have run
> > into a stumbling block. From what I've read, it looks like Conexant
> > AC97 modem codecs aren't supported by the ALSA intel8x0m / slmodem
> > solution. What are the technical reasons for this?
> 
> Do you know if any open source driver ever existed for these?  "Lack of
> documentation" is the obvious suspect...

I was under the impression that all AC97 modem codecs were supposed to
work the same (as in, use them as the AC97 spec says to). The NetBSD
driver appears to be working for non-Conexant codecs, but I can't get
a Conexant chip to power up through the same initialization routine.
ac97_read(as, AC97_REG_EXT_MODEM_CTRL, &reg) always returns 0xff00
("everything powered down" in the AC97 modem world) on the few
variations of Conexant codecs we've tried.

"Lack of documentation" is most likely the reason; I guess I was just
looking for confirmation from another group that either "Yes, these
chips are broken, we don't support them because we don't have any
documentation", or "Yes, these chips are broken, we had to work around
the problem by doing foo".

Meanwhile, I'm still working on getting some useful documentation from
Conexant..

Cheers,
Jared


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
