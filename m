From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Add support Voice DAI
Date: Tue, 14 Apr 2009 10:09:52 +0300
Message-ID: <200904141009.52450.peter.ujfalusi@nokia.com>
References: <49DDFE1D.3090009@samsung.com>
	<20090409140654.GC18152@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id AEDEE2446F
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 09:10:19 +0200 (CEST)
In-Reply-To: <20090409140654.GC18152@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 09 April 2009 17:06:54 ext Mark Brown wrote:
> On Thu, Apr 09, 2009 at 10:54:37PM +0900, Joonyoung Shim wrote:
>
> > +		/* change rate and set CODECPDZ */
> > +		twl4030_codec_enable(codec, 0);
> > +		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
> > +		twl4030_codec_enable(codec, 1);
>
> Hrm.  This codec_enable() call looks fishy - what's the effect if the
> other DAI is running when the voice DAI is configured?  Though there may
> be no way round this...

The TRM is not that clear on what changes in the CODEC_MODE register needs =
a =

codec reset. Changing the OPT_MODE does need a reset, most probably other =

fields also..

-- =

P=E9ter
