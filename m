From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
	FIFO state query
Date: Tue, 2 Mar 2010 16:02:47 +0200
Message-ID: <201003021602.47258.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
	<1267537920.24345.7.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 221961038F1
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 15:02:58 +0100 (CET)
In-Reply-To: <1267537920.24345.7.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 02 March 2010 15:52:00 Nurkkala Eero.An (EXT-Offcode/Oulu) wrote:
> On Tue, 2010-03-02 at 14:39 +0100, Ujfalusi Peter (Nokia-D/Tampere)
> =

> wrote:
> > New function for reading the XBUFFSTAT register, which holds
> > the fill state of the transmit buffer on McBSP.
> > =

> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> =

> Reading the XBUFFSTAT register is by no means accurate.
> IIRC, it reports the buffer status incorrectly about 1/50 times
> on average (@ 48000khz); with simple math, it may be read during the DMA
> burst. Or is it guaranteed not being read during DMA transfer / have
> you otherwise verified the behavior?

That is one side, the other is that since the interface is running on the L=
4 =

domain, the actual buffer fill level might be different inside...
But it is not guarantied that the DMA is not running.
The pointer callback is usually called after the driver calls the elapsed, =
which =

in our case is when the DMA finished it's burst.
So, yes it is not going to be precise, but it is still going to be better t=
han =

it is now.
I did run some tests, and the delay numbers reported looked reasonable.
In element mode on McBSP2 the delay was 640 samples in some cases dropped t=
o =

639.
In threshold mode, hmm I lost the log. But it was fluctuating, but that is =

expected. I'll do some tests on this.


> =

> - Eero
> =


-- =

P=E9ter
