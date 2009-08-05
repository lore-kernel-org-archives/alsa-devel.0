From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 00/20] OMAP ASoC changes in DMA utilization
Date: Wed, 5 Aug 2009 10:23:03 +0300
Message-ID: <200908051023.04036.peter.ujfalusi@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<20090730135257.GE9975@sirena.org.uk>
	<20090730215546.4e184112.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 8256F24349
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 09:23:28 +0200 (CEST)
In-Reply-To: <20090730215546.4e184112.jhnikula@gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 30 July 2009 21:55:46 ext Jarkko Nikula wrote:
> On Thu, 30 Jul 2009 14:52:57 +0100
>
> Is Peter available or having a vacation? He would have better
> possibilities to say and test the PM changes. Now omap_pcm_pointer is
> very accurate and I would like that it remains accurate unless user
> especially wants low-power over it.

I was on vacation for the past four weeks, but now I'm back. Slowly going =

through the mails.

I'll go through the series, but generally I think that the old element mode =

should be selected by default on OMAP3 and give possibility for changing it=
 to a =

more PM friendly mode if necessary . I'm not sure which mode is the default =

after this series..

-- =

P=E9ter
