From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030 updates
Date: Tue, 31 Mar 2009 08:16:52 +0300
Message-ID: <200903310816.52267.peter.ujfalusi@nokia.com>
References: <1238143148-31894-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090327115234.GB9621@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A7FB10381B
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 07:17:06 +0200 (CEST)
In-Reply-To: <20090327115234.GB9621@sirena.org.uk>
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
To: alsa-devel@alsa-project.org
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 27 March 2009 13:52:34 ext Mark Brown wrote:
> On Fri, Mar 27, 2009 at 10:39:06AM +0200, Peter Ujfalusi wrote:
> > Two small updates for the TWL4030 codec driver:
> > 1. Add support for 96KHz sample rate playback (96KHz capture is not
> > supported) 2. Constrains to protect the already running stream from
> > accidental reconfiguration
>
> Applied both, thanks.
>
> Someone (probably me, I'm working on something which could use it at the
> minute) ought to factor out the implementation of symmetric rate
> selection into the core.

I have been thinking of adding these constrains to omap-pcm, since one shou=
ld =

not configure the mcbsp channel differently for playback and capture on the =

same channel...

-- =

P=E9ter

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
