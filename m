From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v8 1/5] video: rmk's HDMI notification
	prototype
Date: Thu, 11 Aug 2016 11:18:17 +0100
Message-ID: <20160811101817.GT1041@n2100.armlinux.org.uk>
References: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
 <1470907227-899-2-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 946A4266D0D
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 12:20:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1470907227-899-2-git-send-email-p.zabel@pengutronix.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2016 at 11:20:23AM +0200, Philipp Zabel wrote:
> This is Russell's HDMI notification prototype [1], currently waiting
> for the HDMI CEC situation to resolve.
> 
> The use case for the notifications on MediaTek MT8173 is to let the
> (dis)connection notifications control an ALSA jack object.
> 
> No Signed-off-by since this is not my code, and still up for discussion.

Well, I have two drivers (both CEC drivers) which use this, and I still
don't see any alternative solution to the problem that this patch is
solving.

I don't think it's really a CEC problem - there's three bits to HDMI
that need to track each others state - the video, audio and CEC paths.

While the video and audio paths may be one block, the CEC path may
actually be a separate block.  For example, the TDA998x devices
integrate the HDMI video/audio block along with a TDA9950 on the
same device - the TDA9950 being a CEC engine.  The TDA9950 is also
available as a separate device, and even when integrated with HDMI,
it appears on the I2C bus as a seperate device.

So, splitting the functionality is definitely the right model.  We
just need some way to keep each blocks state in sync.  What's provided
in this patch is the simple solution which seems to work for the use
cases we have.

I think, in light of no comments against this approach, and no other
approach being available, that this is good enough justification to
merge this, especially as it is blocking other work.

So... if people want to give me reviewed-by/acked-bys, I'll add them
to my patch, and I'll post that and the dw-hdmi and tda9950 CEC drivers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
