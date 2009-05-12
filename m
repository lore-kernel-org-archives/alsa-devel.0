From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Tue, 12 May 2009 16:16:08 +0300
Message-ID: <200905121616.08596.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905121516.40246.peter.ujfalusi@nokia.com>
	<20090512152155.7c82fd2d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 93BDC103860
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 15:16:12 +0200 (CEST)
In-Reply-To: <20090512152155.7c82fd2d.jhnikula@gmail.com>
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

On Tuesday 12 May 2009 15:21:55 ext Jarkko Nikula wrote:
> On Tue, 12 May 2009 15:16:40 +0300
>
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > > Looks like the beep is caused by the ramp operation since beep is
> > > gone in power-down when reverting both of your patches but it's
> > > still present in power-up.
> >
> > But the 'tuck' still there after you have reverted the patches?
>
> Yep it was there even it sounds bit more silent when going to longer
> ramp times. Beep was present only with '109/81/55 ms'.

Now I'm even more confused...
Without the patches that you have reverted, the ramp delay does not matter =

after the playback. It just cuts the VMID and that's it.
On startup the ramp is initiated. If you set the ramp delay longer, than it=
 is =

possible that the beginning of the audio is played already when the VMID is =

ramping up.

So with the ramp (down) delay - the patches that you have reverted - the =

'tuck' was worst after playback, than without the proper ramp (down) delay =

handling?

I can see on the scope, that the ramp up also has kind of 'tuck' problem, b=
ut =

it comes when the VMID is quite low, so it is harder to hear it. By making =
the =

ramp delay longer, this 'tuck' happens when the VMID is close to 0, so it =

makes it less audible.

-- =

P=E9ter
