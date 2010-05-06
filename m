From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv2] ASoC: tlv320aic3x: Add platform data and
	reset gpio handling
Date: Thu, 6 May 2010 14:23:47 +0300
Message-ID: <201005061423.47946.peter.ujfalusi@nokia.com>
References: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
	<201005061208.18169.peter.ujfalusi@nokia.com>
	<20100506095213.GC30491@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A909324632
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 13:24:09 +0200 (CEST)
In-Reply-To: <20100506095213.GC30491@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 06 May 2010 12:52:13 ext Mark Brown wrote:
> On Thu, May 06, 2010 at 12:08:18PM +0300, Peter Ujfalusi wrote:
> > Also all machines, which are using the tlv320aic3x should be aware, that
> > if they do not have the reset GPIO (which they _should_), than they have
> > to set the gpio_reset to -1, unless they want to request gpio0 in the
> > tlv320aic3x driver for fun ;)
> =

> This should be relatively safe here since the platform data was added at
> the same time - it's not changing the semantics underneath existing
> code.

Yes, it is actually _safe_

-- =

P=E9ter
