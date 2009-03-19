From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH] ASoC: Declare Headset as Mic and
	Headphone widgets for SDP3430
Date: Thu, 19 Mar 2009 12:01:25 +0000
Message-ID: <20090319120124.GD1598@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECF95F43@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECF95F43@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 19, 2009 at 01:07:34AM -0500, Lopez Cruz, Misael wrote:
> Headset was declared previously as a Headphone widget connecting
> HSMIC and HSOL/HSOR pins of TWL4030 codec in SDP430 machine driver.
> The capture path becomes invalid as the Headphone widget is not a
> valid input endpoint.

Applied, thanks.
