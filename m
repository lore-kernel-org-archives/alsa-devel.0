From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/6] ASoC: 4 channel support for twl4030
	and omap-mcbsp
Date: Tue, 7 Apr 2009 09:32:02 +0300
Message-ID: <200904070932.02656.peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090407084536.bae7bcb0.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C46FA24373
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 08:32:20 +0200 (CEST)
In-Reply-To: <20090407084536.bae7bcb0.jarkko.nikula@nokia.com>
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
To: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 07 April 2009 08:45:36 Nikula Jarkko (Nokia-D/Helsinki) wrote:
> On Mon, 6 Apr 2009 14:19:26 +0200
>
> "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:
> > As an example, the board file for Beagle is modified to add support
> > for stereo and TDM mode depending on the stream's channel count, so
> > the stereo and the four channel mode are supported on Beagle.
>
> Peter, before starting to hack on this, did I interpret TWL block
> diagram correctly so that I can route both R1/R2 and L1/L2 into same
> outputs? It seems that only codec outputs available in Beagle are the
> HSOL and HSOR. There seems to be no test pads for PreDriv and IHF
> outputs.

With the current implementation there is a mux on Headset outputs:
'HeadsetL Mux': Off, DACL1, DACL2
'HeadsetR Mux': Off, DACR1, DACR2

So you can select which Left channel (Channel 1 or 2 in TDM) goes to HSOL a=
nd =

which Right channel (channel 3 or 4 in TDM) goes to HSOR.

In i2s/stereo mode the codec receives the data on DACL2/DACR2.

I have been misled by the TRM on these, since it seams that these can be mi=
xed =

on the output (and not muxes, as they are implemented at the moment).

There has been proposed patches sent to alsa-devel some time ago, which fix=
ed =

these mistakes...

>
>
> Jarkko

-- =

P=E9ter
