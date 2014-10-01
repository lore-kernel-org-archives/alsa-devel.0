From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v6 2/2] drm/i2c:tda998x: Use the HDMI audio
	CODEC
Date: Wed, 1 Oct 2014 14:47:30 +0100
Message-ID: <20141001134729.GP5182@n2100.arm.linux.org.uk>
References: <cover.1411547014.git.moinejf@free.fr>
 <4b3d35a14461ed164956b7f5aa77b29170bc393d.1411547014.git.moinejf@free.fr>
 <20140930192540.GL4273@sirena.org.uk> <20141001112846.0dbc80ae@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 05555260485
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 15:47:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20141001112846.0dbc80ae@armhf>
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

On Wed, Oct 01, 2014 at 11:28:46AM +0200, Jean-Francois Moine wrote:
> On Tue, 30 Sep 2014 20:25:40 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> > > +	request_module("snd-soc-hdmi-codec");
> > > +	pdev = platform_device_register_resndata(&priv->hdmi->dev,
> > > +						 "hdmi-audio-codec",
> > > +						  PLATFORM_DEVID_NONE,
> > > +						  NULL, 0,
> > > +						  &tda998x_hdmi_data,
> > > +						  sizeof tda998x_hdmi_data);  
> > 
> > Why is this request_module() needed?  If there is a good reason for it
> > we should have some documentation.
> 
> The reason is simple: as the HDMI CODEC is not declared in the DT, the
> associated module must be loaded in memory.

Module auto-loading works in non-DT environments too.  Unlike the
direction that the arm port is going, the core kernel features, such
as driver autoloading, are coded *not* to require DT (or indeed any
particular firmware.)

There are circumstances where this has been lost sight of (such as
the gpiod stuff), but as a general rule, features do not rely on DT.

Platform drivers will be auto-loaded if they have:

MODULE_ALIAS(PLATFORM_MODULE_PREFIX DRIVER_NAME);

and DRIVER_NAME matches the non-id part of the platform device name.
In the case of platform driver ID tables:

MODULE_DEVICE_TABLE(platform, id-table);

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
