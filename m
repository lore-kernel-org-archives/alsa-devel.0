From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: core: Support for limiting the volume
Date: Mon, 10 May 2010 10:07:58 +0300
Message-ID: <201005101007.58347.peter.ujfalusi@nokia.com>
References: <1273230349-6351-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100507154120.GC25793@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id CCBD624706
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 09:09:26 +0200 (CEST)
In-Reply-To: <20100507154120.GC25793@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 07 May 2010 18:41:20 ext Mark Brown wrote:
> On Fri, May 07, 2010 at 02:05:49PM +0300, Peter Ujfalusi wrote:
> > Add support for the core to limit the maximum volume on an
> > existing control.
> > The function will modify the soc_mixer_control.max value
> > of the given control.
> > The new value must be lower than the original one (chip maximum)
> =

> Applied, thanks.

Thanks,
however it seams that if the control has invert enabled this is going to br=
eak.
In case of invert we need to invert from the chip maximum, and not from the =

platform dependent limit.
The only way I can think of to solve this is to introduce new variable in =

soc_mixer_control struct. It can be called platform_max.
The snd_soc_limit_volume would modify the platform_max leaving the max as =

configured by the drivers (chip maximum).
In volsw_info calls than we return the platform_max instead of max.
If in the _info call the platform_max is 0, than we take the max to report =
(some =

custom kcontrol macro might not aware of the change in codec drivers).

What do you think?

-- =

P=E9ter
