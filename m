From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v8 1/5] video: rmk's HDMI notification
	prototype
Date: Thu, 11 Aug 2016 11:39:29 +0100
Message-ID: <20160811103929.GU1041@n2100.armlinux.org.uk>
References: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
 <1470907227-899-2-git-send-email-p.zabel@pengutronix.de>
 <57AC53AB.60008@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by alsa0.perex.cz (Postfix) with ESMTP id A7124266B8B
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 12:39:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57AC53AB.60008@cisco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans Verkuil <hansverk@cisco.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Daniel Kurtz <djkurtz@chromium.org>, Philipp Zabel <p.zabel@pengutronix.de>, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2016 at 12:30:03PM +0200, Hans Verkuil wrote:
> Hi Russell,
> 
> I like this approach and it is something I will need for other CEC drivers
> (not yet merged) as well.
> 
> Just a few comments:
> 
> On 08/11/16 11:20, Philipp Zabel wrote:
> > This is Russell's HDMI notification prototype [1], currently waiting
> > for the HDMI CEC situation to resolve.
> > 
> > The use case for the notifications on MediaTek MT8173 is to let the
> > (dis)connection notifications control an ALSA jack object.
> > 
> > No Signed-off-by since this is not my code, and still up for discussion.
> > 
> > [1] https://patchwork.kernel.org/patch/8351501/
> > ---
> >  drivers/video/Kconfig         |  3 +++
> >  drivers/video/Makefile        |  1 +
> >  drivers/video/hdmi-notifier.c | 61 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/hdmi-notifier.h | 44 +++++++++++++++++++++++++++++++
> >  4 files changed, 109 insertions(+)
> >  create mode 100644 drivers/video/hdmi-notifier.c
> >  create mode 100644 include/linux/hdmi-notifier.h
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 3c20af9..1ee7b9f 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -36,6 +36,9 @@ config VIDEOMODE_HELPERS
> >  config HDMI
> >  	bool
> >  
> > +config HDMI_NOTIFIERS
> > +	bool
> > +
> >  if VT
> >  	source "drivers/video/console/Kconfig"
> >  endif
> > diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> > index 9ad3c17..65f5649 100644
> > --- a/drivers/video/Makefile
> > +++ b/drivers/video/Makefile
> > @@ -1,5 +1,6 @@
> >  obj-$(CONFIG_VGASTATE)            += vgastate.o
> >  obj-$(CONFIG_HDMI)                += hdmi.o
> > +obj-$(CONFIG_HDMI_NOTIFIERS)      += hdmi-notifier.o
> >  
> >  obj-$(CONFIG_VT)		  += console/
> >  obj-$(CONFIG_LOGO)		  += logo/
> > diff --git a/drivers/video/hdmi-notifier.c b/drivers/video/hdmi-notifier.c
> > new file mode 100644
> > index 0000000..a233359
> > --- /dev/null
> > +++ b/drivers/video/hdmi-notifier.c
> > @@ -0,0 +1,61 @@
> > +#include <linux/export.h>
> > +#include <linux/hdmi-notifier.h>
> > +#include <linux/notifier.h>
> > +#include <linux/string.h>
> > +
> > +static BLOCKING_NOTIFIER_HEAD(hdmi_notifier);
> > +
> > +int hdmi_register_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&hdmi_notifier, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(hdmi_register_notifier);
> > +
> > +int hdmi_unregister_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_unregister(&hdmi_notifier, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(hdmi_unregister_notifier);
> > +
> > +void hdmi_event_connect(struct device *dev)
> > +{
> > +	struct hdmi_event_base base;
> > +
> > +	base.source = dev;
> > +
> > +	blocking_notifier_call_chain(&hdmi_notifier, HDMI_CONNECTED, &base);
> > +}
> > +EXPORT_SYMBOL_GPL(hdmi_event_connect);
> > +
> > +void hdmi_event_disconnect(struct device *dev)
> > +{
> > +	struct hdmi_event_base base;
> > +
> > +	base.source = dev;
> > +
> > +	blocking_notifier_call_chain(&hdmi_notifier, HDMI_DISCONNECTED, &base);
> > +}
> > +EXPORT_SYMBOL_GPL(hdmi_event_disconnect);
> > +
> > +void hdmi_event_new_edid(struct device *dev, const void *edid, size_t size)
> 
> I would prefer const u8 *edid. It is after all just a u8 array and not some
> opaque data structure.

In DRM, the edid is of type "struct edid" (defined in
include/drm/drm_edid.h).  So, making it "const u8 *" means that all
DRM drivers will have to explicitly cast it - not something I'm in
favour of.

> > +{
> > +	struct hdmi_event_new_edid new_edid;
> > +
> > +	new_edid.base.source = dev;
> > +	new_edid.edid = edid;
> > +	new_edid.size = size;
> > +
> > +	blocking_notifier_call_chain(&hdmi_notifier, HDMI_NEW_EDID, &new_edid);
> > +}
> > +EXPORT_SYMBOL_GPL(hdmi_event_new_edid);
> > +
> > +void hdmi_event_new_eld(struct device *dev, const void *eld)
> 
> Stupid question: what does ELD stand for? I've no idea...
> 
> And is void the right choice here or should it also be u8?

The ELD stands for EDID-like data.  See information on HDA039.  It's a
method of conveying the EDID data specific to audio drivers to them
without having the complexities of parsing the full EDID each time.
It's also exported to userland so that userland can determine the
capabilities of the audio path, again, without having to have full
EDID parsers and exporting the full EDID data block through audio
drivers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
