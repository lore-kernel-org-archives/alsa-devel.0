From: Hans Verkuil <hansverk-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 1/5] video: rmk's HDMI notification prototype
Date: Thu, 11 Aug 2016 12:49:21 +0200
Message-ID: <57AC5831.5050809@cisco.com>
References: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
 <1470907227-899-2-git-send-email-p.zabel@pengutronix.de>
 <57AC53AB.60008@cisco.com> <20160811103929.GU1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160811103929.GU1041-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
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



On 08/11/16 12:39, Russell King - ARM Linux wrote:
> On Thu, Aug 11, 2016 at 12:30:03PM +0200, Hans Verkuil wrote:
>> Hi Russell,
>>
>> I like this approach and it is something I will need for other CEC drivers
>> (not yet merged) as well.
>>
>> Just a few comments:
>>
>> On 08/11/16 11:20, Philipp Zabel wrote:
>>> This is Russell's HDMI notification prototype [1], currently waiting
>>> for the HDMI CEC situation to resolve.
>>>
>>> The use case for the notifications on MediaTek MT8173 is to let the
>>> (dis)connection notifications control an ALSA jack object.
>>>
>>> No Signed-off-by since this is not my code, and still up for discussion.
>>>
>>> [1] https://patchwork.kernel.org/patch/8351501/
>>> ---
>>>  drivers/video/Kconfig         |  3 +++
>>>  drivers/video/Makefile        |  1 +
>>>  drivers/video/hdmi-notifier.c | 61 +++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/hdmi-notifier.h | 44 +++++++++++++++++++++++++++++++
>>>  4 files changed, 109 insertions(+)
>>>  create mode 100644 drivers/video/hdmi-notifier.c
>>>  create mode 100644 include/linux/hdmi-notifier.h
>>>
>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>>> index 3c20af9..1ee7b9f 100644
>>> --- a/drivers/video/Kconfig
>>> +++ b/drivers/video/Kconfig
>>> @@ -36,6 +36,9 @@ config VIDEOMODE_HELPERS
>>>  config HDMI
>>>  	bool
>>>  
>>> +config HDMI_NOTIFIERS
>>> +	bool
>>> +
>>>  if VT
>>>  	source "drivers/video/console/Kconfig"
>>>  endif
>>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>>> index 9ad3c17..65f5649 100644
>>> --- a/drivers/video/Makefile
>>> +++ b/drivers/video/Makefile
>>> @@ -1,5 +1,6 @@
>>>  obj-$(CONFIG_VGASTATE)            += vgastate.o
>>>  obj-$(CONFIG_HDMI)                += hdmi.o
>>> +obj-$(CONFIG_HDMI_NOTIFIERS)      += hdmi-notifier.o
>>>  
>>>  obj-$(CONFIG_VT)		  += console/
>>>  obj-$(CONFIG_LOGO)		  += logo/
>>> diff --git a/drivers/video/hdmi-notifier.c b/drivers/video/hdmi-notifier.c
>>> new file mode 100644
>>> index 0000000..a233359
>>> --- /dev/null
>>> +++ b/drivers/video/hdmi-notifier.c
>>> @@ -0,0 +1,61 @@
>>> +#include <linux/export.h>
>>> +#include <linux/hdmi-notifier.h>
>>> +#include <linux/notifier.h>
>>> +#include <linux/string.h>
>>> +
>>> +static BLOCKING_NOTIFIER_HEAD(hdmi_notifier);
>>> +
>>> +int hdmi_register_notifier(struct notifier_block *nb)
>>> +{
>>> +	return blocking_notifier_chain_register(&hdmi_notifier, nb);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hdmi_register_notifier);
>>> +
>>> +int hdmi_unregister_notifier(struct notifier_block *nb)
>>> +{
>>> +	return blocking_notifier_chain_unregister(&hdmi_notifier, nb);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hdmi_unregister_notifier);
>>> +
>>> +void hdmi_event_connect(struct device *dev)
>>> +{
>>> +	struct hdmi_event_base base;
>>> +
>>> +	base.source = dev;
>>> +
>>> +	blocking_notifier_call_chain(&hdmi_notifier, HDMI_CONNECTED, &base);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hdmi_event_connect);
>>> +
>>> +void hdmi_event_disconnect(struct device *dev)
>>> +{
>>> +	struct hdmi_event_base base;
>>> +
>>> +	base.source = dev;
>>> +
>>> +	blocking_notifier_call_chain(&hdmi_notifier, HDMI_DISCONNECTED, &base);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hdmi_event_disconnect);
>>> +
>>> +void hdmi_event_new_edid(struct device *dev, const void *edid, size_t size)
>>
>> I would prefer const u8 *edid. It is after all just a u8 array and not some
>> opaque data structure.
> 
> In DRM, the edid is of type "struct edid" (defined in
> include/drm/drm_edid.h).  So, making it "const u8 *" means that all
> DRM drivers will have to explicitly cast it - not something I'm in
> favour of.

I thought this was the raw EDID data. But if you pass a struct edid around,
then why not make this const struct edid *edid? I fail to see why you would
want to use a void pointer here.

Also struct edid is for the first EDID block only, whereas CEC drivers need
the CEA-861 block to get the physical address.

This could of course be a separate event that just notifies clients of the
physical address.

> 
>>> +{
>>> +	struct hdmi_event_new_edid new_edid;
>>> +
>>> +	new_edid.base.source = dev;
>>> +	new_edid.edid = edid;
>>> +	new_edid.size = size;
>>> +
>>> +	blocking_notifier_call_chain(&hdmi_notifier, HDMI_NEW_EDID, &new_edid);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hdmi_event_new_edid);
>>> +
>>> +void hdmi_event_new_eld(struct device *dev, const void *eld)
>>
>> Stupid question: what does ELD stand for? I've no idea...
>>
>> And is void the right choice here or should it also be u8?
> 
> The ELD stands for EDID-like data.  See information on HDA039.  It's a
> method of conveying the EDID data specific to audio drivers to them
> without having the complexities of parsing the full EDID each time.
> It's also exported to userland so that userland can determine the
> capabilities of the audio path, again, without having to have full
> EDID parsers and exporting the full EDID data block through audio
> drivers.
> 

OK. Since eld is an unsigned char array I would suggest changing void to
unsigned char here.

Or perhaps const unsigned char eld[128].

Regards,

	Hans
