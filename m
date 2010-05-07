From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH RFC v1] ASoC: core: Support for limiting
	the volume
Date: Fri, 7 May 2010 13:03:53 +0300
Message-ID: <201005071303.53132.peter.ujfalusi@nokia.com>
References: <1273212185-7129-1-git-send-email-peter.ujfalusi@nokia.com>
	<201005071026.35702.peter.ujfalusi@nokia.com>
	<20100507095614.GA27795@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A2E49244F4
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 12:04:13 +0200 (CEST)
In-Reply-To: <20100507095614.GA27795@sirena.org.uk>
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

On Friday 07 May 2010 12:56:15 ext Mark Brown wrote:
> On Fri, May 07, 2010 at 10:26:35AM +0300, Peter Ujfalusi wrote:
> > Probably it would be better to return with 0 only, if we _changed_ the
> > maximum. I'll resend after the comments.
> =

> No, I think it's fine to report success so long as the requested change
> can be implemented - if it's a noop it might be worth printing a warning
> but the requested setting is in effect.

I think:
if (max <=3D mc->max) {
	mc->max =3D max;
	ret =3D 0;
}

Would be appropriate. We still report error, if the user asked out of limit =

gain, but we report success, if the limit has not been actually changed.

-- =

P=E9ter
