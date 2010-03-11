From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33 fixes
Date: Thu, 11 Mar 2010 16:55:12 +0200
Message-ID: <201003111655.12504.peter.ujfalusi@nokia.com>
References: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100311164628.f6c08a0b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D382F10394C
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 15:55:26 +0100 (CET)
In-Reply-To: <20100311164628.f6c08a0b.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 11 March 2010 16:46:28 ext Jarkko Nikula wrote:
> On Thu, 11 Mar 2010 16:26:20 +0200
> =

> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > It has been found that OMAP3 McBSP needs the BCLK continuously running
> > on the serial interface when it is configured to be slave.
> =

> Just curious: what would happen if the BCLK is cut while the McBSP is
> operating?

The symptom is that we can not access to McBSP register address space causi=
ng =

kernel panic, which can only be fixed by rebooting the device.
The burst driven BCLK causes some internal state machine to stuck, leaving =
the =

given McBSP port dead from the outside. Other ports operate after this even=
t.
Obviously this only bites in McBSP slave mode, and with codec like DAC33 wh=
ich =

have burst mode, in other cases the BCLK is always running (or McBSP is mas=
ter).

> I'm thinking are there also other similar problems, e.g. if
> the rate is not correct.

Hmmm, could be possible, but I did not experienced with such a problem.

-- =

P=E9ter
