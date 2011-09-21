From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 07/17] ASoC: twl6040: Lower the initial
	gains
Date: Wed, 21 Sep 2011 16:03:49 +0300
Message-ID: <25343507.X6coeDXaUn@barack>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
	<2240573.6cRWXtKJB6@barack>
	<20110921123931.GD4374@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id CCF2324C42
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 15:03:42 +0200 (CEST)
Received: by mail-bw0-f50.google.com with SMTP id zt19so1466376bkb.9
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2011 06:03:40 -0700 (PDT)
In-Reply-To: <20110921123931.GD4374@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Samuel Ortiz <samuel.ortiz@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 21 September 2011 13:39:31 Mark Brown wrote:
> The key problem here is that you sent a change saying "change the
> default volume" with no other context in either the changelog or the
> code.  If you've got code that's actively managing the volume register
> while presenting a nice view to the application layer so that the
> register value isn't directly seen in the way it is for standard ASoC
> controls that's a very different thing to standard code.  I'm not going
> to remember the details of everything in every CODEC driver.
> =

> > We do have other scenarios covered, but this initialization was missing.
> > This resulted that the _first_ playback has pop noise, but all
> > subsequent playbacks were fine, since we had the runtime fix for this.
> =

> So what you're doing here is really a bug fix for the ramping code.

I will update the commit message, and I'll also put a comment to the code t=
o =

explain it clearly.

--
P=E9ter
