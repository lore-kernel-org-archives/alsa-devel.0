From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v4 4/8] video: rmk's HDMI notification
	prototype
Date: Thu, 18 Feb 2016 15:24:06 +0000
Message-ID: <20160218152406.GS19428@n2100.arm.linux.org.uk>
References: <1455807526-16918-1-git-send-email-p.zabel@pengutronix.de>
 <1455807741-19122-2-git-send-email-p.zabel@pengutronix.de>
 <20160218150650.GR19428@n2100.arm.linux.org.uk>
 <1455808710.3937.25.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 64766260676
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 16:24:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1455808710.3937.25.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 18, 2016 at 04:18:30PM +0100, Philipp Zabel wrote:
> Hi Russell,
> 
> Am Donnerstag, den 18.02.2016, 15:06 +0000 schrieb Russell King - ARM
> Linux:
> > On Thu, Feb 18, 2016 at 04:02:17PM +0100, Philipp Zabel wrote:
> > > This is extracted from Russell's food for thought HDMI notification
> > > prototype [1]. I've put it into drivers/video for the time being because
> > > my kernels don't have drivers/cec yet.
> > 
> > I see it's also the old version still - this is my latest version, only
> > subtly different in terms of the file naming and Kconfig option name.
> > Functionally the same.
> 
> Thank you for the update. Have you sent (or do you intend to send) this
> separately somewhere? I could then reference it and drop the patch from
> this series.
> Or I could add your signoff and keep the new patch as part of this
> series, if you'd prefer.

I haven't yet: it's part of two branches in my tree at the moment, one
with Hans Verkil's CEC work in plus TDA998x and dw-hdmi support for
that, and also my imx-drm branch which contains a reworked version of
FSL's CEC code:

imx-drm:
drm: bridge/dw_hdmi: place PHY into low power mode when disabled
drm: bridge/dw_hdmi: start of support for pixel doubled modes
drm: bridge/dw_hdmi: remove CEC engine register definitions
drm: bridge/dw_hdmi-cec: add Designware HDMI CEC driver
cec: add HDMI CEC input driver
cec: add HDMI CEC core driver
drm: bridge/dw_hdmi: add HDMI notifier support
video: add HDMI state notifier support

cec:
cec: add tda9950 driver using Hans Verkil's CEC code
drm: i2c/tda998x: add CEC support
cec: add dw-hdmi cec driver using Hans Verkil's CEC code
DocBook/media: add CEC documentation
cec.txt: add CEC framework documentation
cec: add compat32 ioctl support
cec: add HDMI CEC framework
rc: Add HDMI CEC protocol handling
HID: add HDMI CEC specific keycodes
input.h: add BUS_CEC type
drm: bridge/dw_hdmi: add HDMI notifier support
video: add HDMI state notifier support

I haven't put any thought into how to get anything from these merged yet,
I was rather hoping that Hans was going to push his own CEC work to be
merged, and then I'd think about those logistics.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
