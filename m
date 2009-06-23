From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/3] ASoC: TWL4030: Fix voice interface
	clock masters
Date: Tue, 23 Jun 2009 10:10:38 +0300
Message-ID: <200906231010.38207.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31E@dlee04.ent.ti.com>
	<200906220935.27903.peter.ujfalusi@nokia.com>
	<20090622102505.GA4730@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id CCE71245B6
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 09:11:08 +0200 (CEST)
In-Reply-To: <20090622102505.GA4730@sirena.org.uk>
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
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: steve@sakoman.com
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On Monday 22 June 2009 13:25:07 ext Mark Brown wrote:
> On Mon, Jun 22, 2009 at 09:35:27AM +0300, Peter Ujfalusi wrote:
> > On Friday 19 June 2009 11:23:42 ext Lopez Cruz, Misael wrote:
> > > Voice interface of twl4030 codec supports: CBM_CFM and
> > > CBS_CFS. It doesn't support CBS_CFM.
> >
> > Acked-By: Peter Ujfalusi <peter.ujfalusi@nokia.com>
>
> Applied, thanks.
>
> Peter, you might want to submit a MAINTAINERS entry for TWL4030 - you're
> doing a lot of good review there.

Do you mean something like this:

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ae5a81..1c04143 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5523,6 +5523,13 @@ M:       dsaxena@plexity.net
 S:     Maintained
 F:     drivers/char/hw_random/omap-rng.c

+TI TWL4030 SERIES SOC CODEC DRIVER
+P:     Peter Ujflausi
+M:     peter.ujfalusi@nokia.com
+L:     alsa-devel@alsa-project.org
+S:     Maintained
+F:     sound/soc/codecs/twl4030*
+
 TIPC NETWORK LAYER
 P:     Per Liden
 M:     per.liden@ericsson.com

It would be a honor...
But before sending such a patch, I guess Steve Sakoman should give his =

blessing to it (he is the original author of the twl4030 codec driver). Or =

perhaps someone else also?

-- =

P=E9ter
