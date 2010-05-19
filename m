From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Remove CPVSS supply
Date: Wed, 19 May 2010 09:55:52 +0300
Message-ID: <201005190955.52499.peter.ujfalusi@nokia.com>
References: <1274211085-20261-1-git-send-email-jhnikula@gmail.com>
	<F80267346F10C541946CBE8909F1C39E26E7BF8C34@NOK-EUMSG-02.mgdnok.nokia.com>
	<20100519095345.a0fdcd52.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id AD49724545
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 08:55:57 +0200 (CEST)
In-Reply-To: <20100519095345.a0fdcd52.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 19 May 2010 09:53:45 ext Jarkko Nikula wrote:
> On Wed, 19 May 2010 08:51:13 +0200
> =

> <ilkka.koskinen@nokia.com> wrote:
> > Hi,
> > =

> > On Tue, 18 May 2010, Jarkko Nikila wrote:
> > >I believe there is no need for the CPVSS supply as this pin is for
> > >decoupling capacitor for the internal charge pump.
> > =

> > Yes, you're right. I have a vague feeling that I put it there due to
> > some previous comments...
> > =

> > Anyway, I believe tpa6140's HPVdd is similar case and, thus, not
> > needed either. Would you like to make a patch for that or shall I do
> > it?
> =

> I can do it and repost as it makes the patch even more simpler :-)

Thanks Jarkko.
You can add my Acked-by to the new patch.

-- =

P=E9ter
