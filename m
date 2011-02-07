From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WL1273 FM Radio driver...
Date: Mon, 7 Feb 2011 12:02:35 +0000
Message-ID: <20110207120234.GE10564@opensource.wolfsonmicro.com>
References: <1297075922.15320.31.camel@masi.mnp.nokia.com>
 <4D4FDED0.7070008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D4FDED0.7070008@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: matti.j.aaltonen@nokia.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, hverkuil@xs4all.nl, sameo@linux.intel.com, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 07, 2011 at 10:00:16AM -0200, Mauro Carvalho Chehab wrote:

> the MFD part (for example, wl1273_fm_read_reg/wl1273_fm_write_cmd/wl1273_fm_write_data). 
> The logic that are related to control the radio (wl1273_fm_set_audio,  wl1273_fm_set_volume,
> etc) are not related to access the device via the MFD bus. They should be at
> the media part of the driver, where they belong.

Those functions are being used by the audio driver.
