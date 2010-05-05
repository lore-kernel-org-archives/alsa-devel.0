From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: omap: Add basic audio support for
	Nokia RX-51/N900
Date: Wed, 5 May 2010 10:02:18 +0300
Message-ID: <201005051002.18529.peter.ujfalusi@nokia.com>
References: <1273037477-20626-1-git-send-email-jhnikula@gmail.com>
	<201005050930.22712.peter.ujfalusi@nokia.com>
	<20100505094829.ffec7939.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 45FF1103819
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 09:02:28 +0200 (CEST)
In-Reply-To: <20100505094829.ffec7939.jhnikula@gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 05 May 2010 09:48:29 ext Jarkko Nikula wrote:
> Thanks! Definitely reset handling is better to move to codec driver.
> Especially important if starting to manage digital voltages there. I'll
> cook up updated versions.

The tlv320dac33 driver handles the reset GPIO as well. Luckily it does not =
need =

any specific sequence to be followed as the tlv320aic3x series does.

-- =

P=E9ter
