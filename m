From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - alsa-lib 2/3] tlv: Handle 'holes'
 in	SND_CTL_TLVT_DB_RANGE array
Date: Tue, 20 Jul 2010 08:25:00 +0200
Message-ID: <4C45413C.10909@ladisch.de>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>	<1279523646-4987-3-git-send-email-peter.ujfalusi@nokia.com>	<s5heiezfp1c.wl%tiwai@suse.de>	<20100719160109.GC7002@sirena.org.uk>	<s5h630bfo3x.wl%tiwai@suse.de>	<20100719162416.GD7002@sirena.org.uk>	<s5h39vffmkw.wl%tiwai@suse.de>	<20100719170947.GA5950@rakim.wolfsonmicro.main>
	<s5hbpa3z5lz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id EC29D103889
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 08:25:13 +0200 (CEST)
In-Reply-To: <s5hbpa3z5lz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Mark Brown wrote:
> > It still seems silly to have to paper over this for every single dB
> > interval - if we need to link up the ranges it seems like we ought to
> > be fixing this in one place.
> 
> Well, what I don't feel right is that this breaks the simpleness of
> DB_RANGE handling.  It's just damn simple, and works as long as the
> target point is covered by defined ranges.  If something is wrong,
> it's the definition, not the parser.  That's why I wondered first
> whether it can't be fixed in the driver side.

As a driver writer, I would intuitively assume that the ranges must
not be overlapping.  If we require all drivers to get this right,
there will likely be new ones that don't.

> The only worst case is discontinued lines you mentioned.  Is there
> a real device that behaves so (and implemented in that way)?

AK4524's and friends' "pseudo-log" controls use piecewise linear ranges
where the boundaries between the ranges would have to be described with
a separate TLV entry if overlapping TLV ranges are required (see page 28
of 4524.pdf).  Currently, ak4xxx-adda.c uses a volume lookup table.


Regards,
Clemens
