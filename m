From: "Lambert, David" <dlambert@ti.com>
Subject: Re: [PATCH v3 2/4] OMAP4: hwmod: add entries for DMIC driver
Date: Wed, 26 Jan 2011 06:55:39 -0600
Message-ID: <AANLkTi=GFtasMK70zOs-m6FTXchNgxv3ryS1g11sL_2w@mail.gmail.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com>
 <1295992862-6154-3-git-send-email-dlambert@ti.com> <alpine.DEB.2.00.1101251654290.16671@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1101251654290.16671@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 25, 2011 at 5:54 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> On Tue, 25 Jan 2011, David Lambert wrote:
>
> > From: Benoit Cousson <b-cousson@ti.com>
> >
> > Adds HWMOD entries for the OMAP DMIC driver and creates
> > a platform device. =A0The HWMOD entires define the system
> > resource requirements for the drvier such as DMA addresses, channel=
s,
> > and IRQ's. =A0Placing this information in the HWMOD database allows
> > for more generic drivers to be written and having the specific
> > implementation details defined in HWMOD.
> >
> > Signed-off-by: David Lambert <dlambert@ti.com>
>
> This should have Benoit's Signed-off-by: also.
>

OK... Benoit has already agreed to it... will it be sufficient if I
just have him ACK the
change here on e-mail?

--
David Lambert
OMAP=99 Multimedia
214-567-5692
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
