From: Hans Verkuil <hansverk-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 1/5] video: rmk's HDMI notification prototype
Date: Thu, 11 Aug 2016 17:54:51 +0200
Message-ID: <d3aa0131-a499-d14f-d774-f5a934b68e10@cisco.com>
References: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
 <1470907227-899-2-git-send-email-p.zabel@pengutronix.de>
 <57AC53AB.60008@cisco.com> <20160811103929.GU1041@n2100.armlinux.org.uk>
 <57AC5831.5050809@cisco.com> <20160811141653.GV1041@n2100.armlinux.org.uk>
 <57AC9078.2060009@cisco.com> <20160811150353.GW1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160811150353.GW1041-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 08/11/2016 05:03 PM, Russell King - ARM Linux wrote:
> On Thu, Aug 11, 2016 at 04:49:28PM +0200, Hans Verkuil wrote:
>> On 08/11/16 16:16, Russell King - ARM Linux wrote:
>>> On Thu, Aug 11, 2016 at 12:49:21PM +0200, Hans Verkuil wrote:
>>>> I thought this was the raw EDID data. But if you pass a struct edid around,
>>>> then why not make this const struct edid *edid? I fail to see why you would
>>>> want to use a void pointer here.
>>>
>>> struct edid is a DRM thing - it's not generic.  Using struct edid here
>>> would force everyone to use the DRM structure, whereas other subsystems
>>> use, eg, unsigned char.
>>
>> So how the edid pointer should be interpreted depends on which subsystem
>> sends it? That doesn't sound right. It makes it really hard for the drivers
>> receiving the notifications.
>
> No, that's wrong... and I really don't see why you're trying to make a
> meal of this.

It's a misunderstanding on my side. I thought that struct edid was an 'unpacked'
version of the EDID, but it is just an 'overlay' of the first block of the EDID.

Sorry about that, I never worked much with drm :-) And just forget about that
idea of an hdmi_event_new_phys_addr, that too came out of my misunderstanding.

Anyway, what do you think of using this:

struct hdmi_event_new_edid {
	struct hdmi_event_base base;
	union {
		const struct edid *drm_edid;
		const u8 *edid;
	};
	size_t size;
};

hdmi_event_new_edid is fine using a void pointer (well, I hate void pointers,
but I see no clean way around it).

Regards,

	Hans
