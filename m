From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 00/17] ASoC: twl6040: Cleanups and fixes
Date: Mon, 19 Sep 2011 14:32:42 +0300
Message-ID: <73155881.Gph4EpKVic@barack>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
	<20110919101235.GA5467@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71]) by alsa0.perex.cz (Postfix) with ESMTP id 4DF3B249DD
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 13:32:44 +0200 (CEST)
Received: by mail-bw0-f50.google.com with SMTP id zt19so25661534bkb.37
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2011 04:32:36 -0700 (PDT)
In-Reply-To: <20110919101235.GA5467@sirena.org.uk>
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

On Monday 19 September 2011 11:12:36 Mark Brown wrote:
> It'd be really good if you could manage to split this stuff up - this
> series is enormous and it's getting posted rather a lot, much of this
> stuff seems like it could be split out and posted separately.

It used to be 29 patches ;)
I would try to avoid resending this 17 patch in a smaller packs, unless it =
is =

really needed.
I did separated the two bigger change from this update series (Offset =

cancellation, vibra).
The changes within this series are quite straight forward,
Also as they pretty much depend on each other I thought it is better to kee=
p =

them together.

--
P=E9ter
