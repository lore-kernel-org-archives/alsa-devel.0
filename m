From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Strange control interactions on Tegra Harmony
Date: Fri, 28 Jan 2011 12:55:53 +0000
Message-ID: <20110128125553.GC10350@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DD47@HQMAIL01.nvidia.com>
	<20110127184927.GC12717@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8DDEA@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8DE0F@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B38B424556
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 13:55:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DE0F@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "dp@opensource.wolfsonmicro.com" <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 02:55:07PM -0800, Stephen Warren wrote:
> Stephen Warren wrote at Thursday, January 27, 2011 3:00 PM:

> > The issue with both the headphone and speaker mute controls muting both
> > outputs is something else though.

> Hmm. This issue happens when I run:

> aplay foo.wav

> But not when I run:

> aplay -D hw:0,0 foo.wav

> I deleted /etc/asound.conf (which set the default sink to pulse), and the
> problem went away. I guess I won't bother investigating this anymore right
> now.

This sounds like the driver's happy and something in userspace is trying
to be too clever about things.
