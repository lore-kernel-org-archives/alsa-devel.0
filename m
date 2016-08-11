From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH v8 1/5] video: rmk's HDMI notification prototype
Date: Thu, 11 Aug 2016 16:03:54 +0100
Message-ID: <20160811150353.GW1041@n2100.armlinux.org.uk>
References: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
 <1470907227-899-2-git-send-email-p.zabel@pengutronix.de>
 <57AC53AB.60008@cisco.com>
 <20160811103929.GU1041@n2100.armlinux.org.uk>
 <57AC5831.5050809@cisco.com>
 <20160811141653.GV1041@n2100.armlinux.org.uk>
 <57AC9078.2060009@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57AC9078.2060009-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Hans Verkuil <hansverk-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2016 at 04:49:28PM +0200, Hans Verkuil wrote:
> On 08/11/16 16:16, Russell King - ARM Linux wrote:
> > On Thu, Aug 11, 2016 at 12:49:21PM +0200, Hans Verkuil wrote:
> >> I thought this was the raw EDID data. But if you pass a struct edid around,
> >> then why not make this const struct edid *edid? I fail to see why you would
> >> want to use a void pointer here.
> > 
> > struct edid is a DRM thing - it's not generic.  Using struct edid here
> > would force everyone to use the DRM structure, whereas other subsystems
> > use, eg, unsigned char.
> 
> So how the edid pointer should be interpreted depends on which subsystem
> sends it? That doesn't sound right. It makes it really hard for the drivers
> receiving the notifications.

No, that's wrong... and I really don't see why you're trying to make a
meal of this.

In both cases, it's the EDID as received from the device.  One subsystem
happens to represent it internally as a "struct edid" in its drivers,
another subsystem uses "unsigned char []".

In order to _cleanly_ accept both styles, without having to resort to
driver authors needing to litter their code with lots of idiotic casts,
I'm accepting a void * pointer, so that we can accept _both_ a struct
edid and an unsigned char array.

Both are compatible with each other.  Both have the same bytes at the
same offset.  There is no difference between them other than the C
types that are used by each subsystem.

> But I understand that currently the main purpose of the hdmi_event_new_edid
> is to get the physical address from the EDID for CEC? Or do you have other
> uses as well?

That is one use, but if an audio driver wants to parse the raw EDID
instead of the ELD, it can.

What I want to avoid is having the video driver parse lots of different
bits from the EDID and then send lots of events "just in case" something
wants some of the parsed information - it's much more efficient to give
drivers the raw information and allow them to parse what they need from
the EDID.  I'm not convinced that parsing out the physical address, and
then passing that from the video side is a good idea.

The reason I made an exception for the ELD is because (a) it's already
passed between video and audio drivers, (b) the code we have present to
convert an EDID to ELD is in DRM, and requires DRM data structures
which won't be available in an audio driver.

If you want a mechanism to pass just the physical address, we could add
it, and require CEC drivers to make use of both the EDID or physical
address events.  That would mean situations where the physical address
is known to be fixed before hand can be easily catered for.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
