From: Daniel Mack <zonque@gmail.com>
Subject: Re: Sharing PXA SSP ports
Date: Wed, 22 Jun 2011 15:09:06 +0200
Message-ID: <BANLkTikKiXtzHPbn1JqQJvJxfWG7d=pV1w@mail.gmail.com>
References: <BANLkTikxz95HyKt0+0gjeByNah0-N+vBLg@mail.gmail.com>
	<20110622130517.GF23666@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AE211039EA
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 15:09:07 +0200 (CEST)
Received: by pwi18 with SMTP id 18so615268pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 06:09:06 -0700 (PDT)
In-Reply-To: <20110622130517.GF23666@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 3:05 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 22, 2011 at 02:44:10PM +0200, Daniel Mack wrote:
>
>> What would be a good approach? Would we need a multiplexer for this
>> hardware bus, or can we extend the DAI driver in any clever way to
>> achieve that? Or is there a solution already I just don't know about?
>
> This seems like the DAI driver should deal with things. =A0It needs to
> join up the input and output paths anyway as there's shared clocks and
> so on.

So does it need modification, or do you say it should work already? I
can care for fixing this up if necessary - is there any other DAI
driver that does that and that could serve as an example?

Thanks,
Daniel
