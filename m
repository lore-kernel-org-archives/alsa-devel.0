From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Workaround for headset DC
	offset caused pop noise
Date: Wed, 12 Oct 2011 11:55:15 +0300
Message-ID: <2135466.UdidpbexSR@barack>
References: <1318330813-31184-1-git-send-email-peter.ujfalusi@ti.com>
	<20111011132921.GD1098@sirena.org.uk> <1362600.vrF78ASdYQ@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 503A710382F
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 10:55:30 +0200 (CEST)
Received: by mail-ey0-f170.google.com with SMTP id 7so485652eyg.29
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2011 01:55:13 -0700 (PDT)
In-Reply-To: <1362600.vrF78ASdYQ@barack>
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

On Wednesday 12 October 2011 11:18:50 P=E9ter Ujfalusi wrote:
> > This sounds like you should be using a supply widget to do the reference
> > counting here?
> =

> Probably it is better to move the whole thing to be handled by a supply
> widget (attached to the HS DACs).
> It will not mess up the sequence, and I'm not going to need to count in t=
he
> driver.
> Will rewrite the patch.

I can not move the HS DAC power on/off to be handled by a supply widget...
Refcounting in a supply widget will not work for the power down, since the =

supply widget will be turned off after the DAC widget. At time when the DAC =

receives the PMD event the attached supply is still on.
I can update the commit message to explicitly say that we need to turn on b=
oth =

HS DAC at the same time, and we need to turn tem off at the same time.

--
P=E9ter
