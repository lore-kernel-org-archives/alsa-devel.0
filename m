From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 05/10] ASoC: twl6040: One workqueue should
	be enough
Date: Tue, 27 Sep 2011 09:33:06 +0300
Message-ID: <2417914.e6qfaNBTQp@barack>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<CAPo=G1yaVVosP=KxH07akYzCuLF6hxP3YGqF0AfH4kHC0bNetw@mail.gmail.com>
	<20110926212914.GE2872@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69]) by alsa0.perex.cz (Postfix) with ESMTP id 6643E2437C
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 08:33:00 +0200 (CEST)
Received: by mail-bw0-f54.google.com with SMTP id zs8so7933716bkb.41
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 23:32:57 -0700 (PDT)
In-Reply-To: <20110926212914.GE2872@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 26 September 2011 22:29:15 Mark Brown wrote:
> On Mon, Sep 26, 2011 at 08:20:11PM +0300, Ujfalusi, Peter wrote:
> > For the ramp code execution we should avoid any delay at all costs,
> > since it can have audible side effects.
> =

> If you're that sensitive to latency does a workqueue offer sufficient
> guarantees?

It seams to be pretty good based on my tests.

> > In my past experience the system wq can cause latency, since we usually
> > have slow devices on it (GPS, proximity sensor, magnetometer, etc).
> > Reading from those usually takes considerable amount of time, and
> > we can end up with delayed execution of our ramp code.
> =

> How long are these work items taking?  I'm wondering if the other work
> items are taking sufficiently long to be actively disruptive if they
> should be isolated from other things rather than the other way around.
> Of course it could also be a large buildup of work...

It could be any random driver (we can have random components on a device).
This is just precaution to protect the audio from nasty things.

--
P=E9ter
