From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESEND][PATCH] ASoC: Update omap/ams-delta for
	TTY API change
Date: Mon, 6 Jun 2011 12:37:16 +0200
Message-ID: <201106061237.17452.jkrzyszt@tis.icnet.pl>
References: <201105121929.50301.jkrzyszt@tis.icnet.pl>
	<4DECA3AD.2000100@ti.com>
	<20110606095841.GM18731@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AF2E10385D
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 12:37:57 +0200 (CEST)
In-Reply-To: <20110606095841.GM18731@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: balbi@ti.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Liam Girdwood <lrg@ti.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon 06 Jun 2011 at 11:58:42 Felipe Balbi wrote:
> On Mon, Jun 06, 2011 at 10:53:49AM +0100, Liam Girdwood wrote:
> > On 03/06/11 22:37, Janusz Krzysztofik wrote:
> > > Dnia pi=B1tek 13 maj 2011 o 11:25:32 Liam Girdwood napisa=B3(a):
> > >> On 13/05/11 08:00, Mark Brown wrote:
> > >>> On Fri, May 13, 2011 at 12:36:07AM +0200, Janusz Krzysztofik =

wrote:
> > >>>> Following the receive_buf() change to return the number of
> > >>>> bytes received, the cx20442 CODEC driver was updated to
> > >>>> report that we accepted all the data that was offered to us.
> > >>>> Do the same with the corresponding Amstrad Delta sound card
> > >>>> level wrapper function, which is actually registered as the
> > >>>> tty line discipline callback instead of the the CODEC
> > >>>> function, which it then calls.
> > >>>> =

> > >>>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > >>> =

> > >>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > >>> =

> > >>> but as the TTY API change is in the TTY tree at the minute and
> > >>> not ASoC you should send this to Greg K-H (ideally also with
> > >>> Liam's ack) unless it's not been applied by the time the merge
> > >>> window comes round.
> > >> =

> > >> Fine by me too.
> > >> =

> > >> Acked-by: Liam Girdwood <lrg@ti.com>
> > > =

> > > Hi,
> > > I failed to send this patch to Greg before the merge window,
> > > sorry. Now that we are in the rc cycle, can it be applied to the
> > > sound tree, or should I resend it?
> > =

> > Best to resend with Ack's.
> =

> I'm not sure, the commit was reverted anyway by Linus.

Yeah, thanks, I've just found this information while examining the =

cx20442 history for reference. Forget about this patch then, it's no =

longer applicable.

Thanks,
Janusz
