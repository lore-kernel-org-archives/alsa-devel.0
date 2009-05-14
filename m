From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Thu, 14 May 2009 12:48:49 +0300
Message-ID: <200905141248.49418.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905141109.09084.peter.ujfalusi@nokia.com>
	<20090514092455.GB4917@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 18109243F4
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 11:49:00 +0200 (CEST)
In-Reply-To: <20090514092455.GB4917@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 14 May 2009 12:24:55 ext Mark Brown wrote:
> On Thu, May 14, 2009 at 11:09:08AM +0300, Peter Ujfalusi wrote:
> > If the order of the startup can be somehow altered to be:
> > dac -> PGA -> HS ramp up (HS enable, fake PGA)
>
> Looking at that (without any reference to the TWL4030 itself) I would do
> this by having the headset ramp up be handled by an POST_PMU event on
> the PGA.

This is not really possible with the twl4030 codec.
For simplicity, let's take the Audio left2 route:
DACL2 -> PGAL2 ---> PreDriveL
                |-> PreDriveR
                |-> HeadsetL
                |-> CarkitL
                |-> HandsFreeL
                |-> HandsFreeR
                \-> Earpiece

At least the Headset and HandsFree needs special mantra for the pop removal.
If the Headset is not connected/used than there is no need to do the HS pop =

attenuation.

-- =

P=E9ter
