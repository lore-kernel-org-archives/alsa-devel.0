From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WL1273 FM Radio driver...
Date: Wed, 2 Feb 2011 15:51:49 +0000
Message-ID: <20110202155148.GS12743@opensource.wolfsonmicro.com>
References: <1295363063.25951.67.camel@masi.mnp.nokia.com>
 <20110130232358.GD2565@sortiz-mobl>
 <4D4979A5.1020000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D4979A5.1020000@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, hverkuil@xs4all.nl, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 02, 2011 at 01:35:01PM -0200, Mauro Carvalho Chehab wrote:

[Reflowed into 80 columns.]
> My concerns is that the V4L2-specific part of the code should be at
> drivers/media.  I prefer that the specific MFD I/O part to be at
> drivers/mfd, just like the other drivers.

Currently that's not the case - the I/O functionality is not in any
meaningful sense included in the MFD, it's provided by the V4L portion.
