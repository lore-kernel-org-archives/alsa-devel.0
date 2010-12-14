From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Fix 24bit support
Date: Tue, 14 Dec 2010 14:11:00 +0200
Message-ID: <201012141411.00740.peter.ujfalusi@nokia.com>
References: <1292327129-19417-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101214114914.GB13649@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id C6DFC10384B
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 13:10:59 +0100 (CET)
In-Reply-To: <20101214114914.GB13649@rakim.wolfsonmicro.main>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 December 2010 13:49:14 ext Mark Brown wrote:
> On Tue, Dec 14, 2010 at 01:45:29PM +0200, Peter Ujfalusi wrote:
> > twl4030 series of codecs supports S32_LE with msbits=3D24.
> > Replace the S24_LE with S32_LE format, and add constraint
> > for 24msbit in case of 32 S32_LE format.
> > =

> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> =

> There's no real need to add the constraint for 24 bit - the CODEC will
> quite happily consume 32 bit data, it'll just ignore the 8 LSB.  We
> should probably do something more sensible with the format stuff, it's
> never been a terribly pressing issue though.

AFAIK this constraint is for applications to know, that only the 24 bit MSB=
 is =

valid in S32_LE (for example the ice1712 also sets this constraint to let =

application know).
The datasheet of twl4030 series states, that it supports this coding, so IM=
HO it =

does not hurt to let applications know this fact.
But yeah, it will discard the the 8 bit LSB for sure.

-- =

P=E9ter
