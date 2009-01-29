From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Analog bypass
	implementation - try2
Date: Thu, 29 Jan 2009 16:47:44 +0200
Message-ID: <200901291647.44780.peter.ujfalusi@nokia.com>
References: <1233233870-22700-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090129135310.GE12179@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DA331038A1
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 15:54:28 +0100 (CET)
In-Reply-To: <20090129135310.GE12179@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 29 January 2009 15:54:34 ext Mark Brown wrote:
> On Thu, Jan 29, 2009 at 02:57:49PM +0200, Peter Ujfalusi wrote:
> > With the this implementation, there is no visible difference in power
> > consumption compared to the previous, codec off way.
> > So when the codec is in SND_SOC_BIAS_STANDBY mode and all of the bypass=
es
> > are disabled, the additional power consumption is minimal, if any.
>
> It isn't ideal since what should happen is that the bias is kept on
> while any paths are active (not just digital ones) but it shouldn't
> cause any problems since all that should happen is that the checks
> for bypass paths being active will just always return false.  I'll
> the patch - when the core becomes more capable the patch can always be
> revisited.

You mean, that if one of the bypass is active, and the core wants to set th=
e =

codec to SND_SOC_BIAS_STANDBY, that the twl4030_set_bias_level should retur=
n =

with false?

Also, if the codec was in SND_SOC_BIAS_STANDBY and one of the bypass gots =

enabled, than it should set the codec bias_state to SND_SOC_BIAS_ON?

So the STANDBY state is really STANDBY?

-- =

P=E9ter
