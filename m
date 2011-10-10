From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ams-delta: Let the core to register
	DAPM widgets/routes and controls
Date: Mon, 10 Oct 2011 09:27:51 +0300
Message-ID: <38775722.a3iD5J98oW@barack>
References: <1317978199-14932-1-git-send-email-peter.ujfalusi@ti.com>
	<201110081347.57569.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 06C6D24373
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 08:27:55 +0200 (CEST)
Received: by eyg7 with SMTP id 7so986070eyg.15
	for <alsa-devel@alsa-project.org>; Sun, 09 Oct 2011 23:27:52 -0700 (PDT)
In-Reply-To: <201110081347.57569.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Janusz,

On Saturday 08 October 2011 13:47:57 Janusz Krzysztofik wrote:
> On Fri, 7 Oct 2011 at 11:03:19 Peter Ujfalusi wrote:
> > Pass the DAPM widgets/routes and static controls via the
> > snd_soc_card struct to core. In this way the machine driver
> > does not need to handle the DAPM widgets/routes.
> =

> Hi Peter,
> This change really simplifies things by making better use of platform
> provided functionality instead of reimplementing parts of it, but it
> breaks the intentional logic of conditionally enabling card widgets,
> controls and routes. OTOH, the negative condition here is
> tty_register_ldisc() failure, which seems hardly possible in a stable,
> correctly configured kernel. So, if you really think such conditional
> logic is no longer required in a driver which has proven its stability,
> please go on, I've tested your changes, they work for me.

I was a bit hesitant to do this change in the first place.
We can keep the current flow in the ams-delta to be on the safe side.
I'm going to send out another series for the omap platforms soon which will =

keep the error handling logic of ams-delta intact.
 =

> Otherwise, I can try to re-factor the driver code, keeping that
> conditional logic, but using it for conditional runtime assignment of
> card->{widgets,routes,controls} instead of conditionally calling
> snd_soc_dapm_{new_controls,add_controls,add_routes}(). What do you
> think?

I don't think it worth the trouble to do this.

--
P=E9ter
