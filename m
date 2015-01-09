From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v9 3/4] ASoC: tda998x: add a codec to the
	HDMI transmitter
Date: Fri, 9 Jan 2015 11:19:35 +0000
Message-ID: <20150109111935.GF12302@n2100.arm.linux.org.uk>
References: <cover.1420628786.git.moinejf@free.fr>
 <23b36acc1f769418a06f3e929eba288b5911da12.1420628786.git.moinejf@free.fr>
 <54AD4C77.5000401@arm.com>
 <20150107154138.GL12302@n2100.arm.linux.org.uk>
 <20150107190241.27ebac8b@armhf> <54AFAC4C.7010209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 08F712607E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 12:19:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54AFAC4C.7010209@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 09, 2015 at 12:24:12PM +0200, Jyri Sarha wrote:
> I think that would still fail if DRM and TDA998x is built in and SND_SOC is
> built as modules. A request_module() call before tda9998x_codec_register()
> should help.

That doesn't fix the problem.  If the DRM driver is built in, but the
codec is not, and the DRM driver has a reference to
tda9998x_codec_register(), then the vmlinux file will fail to link,
and you'll never get the opportunity to call request_module().

> Or could could write:
> 
> select SND_SOC_TDA998X if (SND_SOC=DRM_I2C_NXP_TDA998X || SND_SOC=y)

I'm not sure that's right either.

Let's go back and think about this: why should SND_SOC_TDA998X be
*selected*.  Let me put that a different way: why should this symbol
be forced on just because we're building the DRM TDA998x driver?

Would it be more sensible to make SND_SOC_TDA998X depend on
DRM_I2C_NXP_TDA998X instead, maybe with a 'default y' - which is a
kinder way to have SND_SOC_TDA998X be enabled.  If SND_SOC_TDA998X
doesn't have a prompt, then it'll automatically enable itself too
this way when all its dependencies are satisfied.

IMHO "select" is a very over-used, and in many cases an evil
construct because its very hard to avoid breaking dependencies
with it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
