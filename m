From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
	FIFO state query
Date: Thu, 4 Mar 2010 09:30:47 +0200
Message-ID: <201003040930.47744.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100303161842.7b82ea8c.jhnikula@gmail.com>
	<201003031701.40016.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 66AB0103812
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 08:31:30 +0100 (CET)
In-Reply-To: <201003031701.40016.peter.ujfalusi@nokia.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

On Wednesday 03 March 2010 17:01:39 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> On Wednesday 03 March 2010 16:18:42 ext Jarkko Nikula wrote:
> > On Wed, 3 Mar 2010 12:02:48 +0200
> > =

> > Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > > The command for test:
> > > aplay -fdat -d 1 /dev/urandom
> > =

> > I recommend to use /dev/zero instead since urandom takes CPU time.
> > =

> > > [   96.290924] XBUFFSTAT: 0
> > > [   96.293487] XBUFFSTAT: 0
> > > [   96.296020] XBUFFSTAT: 0
> > > [   96.299774] XBUFFSTAT: 1
> > > =

> > > So the buffer is kept full in element mode, as it is expected.
> > =

> > I was expecting to see more variations. IRCC, the DMA in OMAP is doing
> > transfers over the memory bus using some small bursts but I'm not
> > completely sure. I'm thinking if that could explain the Eero's and
> > Liam's observations?
> =

> I kind of expecting similar result (this).
> In element mode the threshold value is 0 (1 word).
> So if one word is free in McBSP buffer, than it will assert the DMA reque=
st
> line, and the DMA will write one word to McBSP.
> So in theory the buffer must be kept full in this mode, with quite minimal
> variation.
> But I might be wrong on this...

Well, to be precise, I expected that the XBUFFSTAT would have been 1 most o=
f the =

time, and not 0.
But in stereo we are still within one sample accuracy, so I think this is O=
K.

-- =

P=E9ter
