From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Tue, 12 May 2009 15:16:40 +0300
Message-ID: <200905121516.40246.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090512145229.bf93fb01.jhnikula@gmail.com>
	<20090512150246.2dac1488.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id F0B5B103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 14:16:44 +0200 (CEST)
In-Reply-To: <20090512150246.2dac1488.jhnikula@gmail.com>
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
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 12 May 2009 15:02:46 ext Jarkko Nikula wrote:
> On Tue, 12 May 2009 14:52:29 +0300
>
> Jarkko Nikula <jhnikula@gmail.com> wrote:
> > > amixer sset 'HS ramp delay' '109/81/55 ms'
> >
> > Again a bit lower than with '55/40/27 ms' but now I hear silent beep
> > (!) when starting the aplay and about 5 s after stopping it followed
> > by the 'tuck'. Length of beep was less than half of second.
> >
> > Probably this this is the issue reported by Anuj?
>
> Looks like the beep is caused by the ramp operation since beep is gone
> in power-down when reverting both of your patches but it's still present
> in power-up.

But the 'tuck' still there after you have reverted the patches?

-- =

P=E9ter
