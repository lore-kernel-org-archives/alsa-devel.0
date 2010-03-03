From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
	FIFO state query
Date: Wed, 3 Mar 2010 17:01:39 +0200
Message-ID: <201003031701.40016.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003031202.48598.peter.ujfalusi@nokia.com>
	<20100303161842.7b82ea8c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id C5BBE24154
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 16:01:43 +0100 (CET)
In-Reply-To: <20100303161842.7b82ea8c.jhnikula@gmail.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 03 March 2010 16:18:42 ext Jarkko Nikula wrote:
> On Wed, 3 Mar 2010 12:02:48 +0200
> =

> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > The command for test:
> > aplay -fdat -d 1 /dev/urandom
> =

> I recommend to use /dev/zero instead since urandom takes CPU time.
> =

> > [   96.290924] XBUFFSTAT: 0
> > [   96.293487] XBUFFSTAT: 0
> > [   96.296020] XBUFFSTAT: 0
> > [   96.299774] XBUFFSTAT: 1
> > =

> > So the buffer is kept full in element mode, as it is expected.
> =

> I was expecting to see more variations. IRCC, the DMA in OMAP is doing
> transfers over the memory bus using some small bursts but I'm not
> completely sure. I'm thinking if that could explain the Eero's and
> Liam's observations?

I kind of expecting similar result (this).
In element mode the threshold value is 0 (1 word).
So if one word is free in McBSP buffer, than it will assert the DMA request =

line, and the DMA will write one word to McBSP.
So in theory the buffer must be kept full in this mode, with quite minimal =

variation.
But I might be wrong on this...

> =

> > So according to XBUFSTAT we have played out 289 samples.
> > based on the time we actually played 288.528 samples.
> > =

> > I would say this is really close to what we would expect to have?
> =

> Sounds accurate enough.
> =

> > Note: I have used printk for these, which pretty much alters the behavi=
or
> > a bit in timing wise...
> =

> BTW: There is OMAP3 port in LTTng.

Thanks, I'll look at that, since this printk is altering the behavior too m=
uch.

-- =

P=E9ter
