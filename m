From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support
	for audio
Date: Fri, 9 Jan 2015 11:45:29 +0000
Message-ID: <20150109114529.GH12302@n2100.arm.linux.org.uk>
References: <cover.1420628786.git.moinejf@free.fr>
 <0084acea5a3475a77531d6a77483f36d3469111a.1420628786.git.moinejf@free.fr>
 <54AE99F5.1010404@ti.com> <20150108174257.557f7ea5@armhf>
 <54AFA9B0.6040405@ti.com> <20150109123036.4bc4bbf6@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 8591A2605CB
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 12:45:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150109123036.4bc4bbf6@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Andrew Jackson <Andrew.Jackson@arm.com>, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 09, 2015 at 12:30:36PM +0100, Jean-Francois Moine wrote:
> In my original version, the audio-ports are a bitmap of the pins, the
> bit 0 being the WS used for I2S. A fully wired tda998x would have been
> as:
> 
> 	audio-ports = <0x03>, <0x04>, <0x09>, <0x11>;
> 	audio-port-names = "i2s", "spdif", "i2s", "i2s";
> 
> With the new version, it would simply become:
> 
> 	audio-inputs = "i2s", "spdif", "i2s", "i2s";

How do you know which i2s inputs to enable?

Does it make sense for the audio inputs to be mixed like that?

You will need to enable one i2s for front L+R, and increasingly others
for the additional channels.

I think we need to understand exactly how the 998x map I2S inputs to the
HDMI channels to avoid making a mistake with the binding; remember, the
binding isn't something that can be easily "bug fixed" at a later date
as anything we come up with now has to be supported long term by the
kernel.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
