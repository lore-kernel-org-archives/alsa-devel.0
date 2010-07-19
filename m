From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/3] ASoC: twl4030/tpa6130a2:?DB_RANGE
	mapping fixes
Date: Mon, 19 Jul 2010 13:43:48 +0300
Message-ID: <201007191343.49282.peter.ujfalusi@nokia.com>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
	<201007191214.50115.peter.ujfalusi@nokia.com>
	<20100719103038.GA9203@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id B9A7F103819
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 12:43:53 +0200 (CEST)
In-Reply-To: <20100719103038.GA9203@rakim.wolfsonmicro.main>
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

On Monday 19 July 2010 13:30:38 ext Mark Brown wrote:
> Meh, that works but I guess my brain can't imagine concepts that ugly :)

Just out of curiosity: you don't like the overlapping method I suppose.
Having spent now two days with this, I tend to favor that, since it clearly =

shows how the raw <-> dB ranges are mapped. Granted, it handles some raw va=
lues =

twice.
But, if the alsa-lib series is accepted, than the issue goes away, and I'm =
going =

to be happy with that as well.

Thanks again,
P=E9ter
