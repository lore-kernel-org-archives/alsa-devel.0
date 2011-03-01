From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v21 1/3] MFD: WL1273 FM Radio: MFD driver for the FM
 radio.
Date: Tue, 1 Mar 2011 12:43:54 +0100
Message-ID: <20110301114353.GA4543@sortiz-mobl>
References: <1298966450-31814-1-git-send-email-matti.j.aaltonen@nokia.com>
 <1298966450-31814-2-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298966450-31814-2-git-send-email-matti.j.aaltonen@nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, mchehab@redhat.com, hverkuil@xs4all.nl, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Matti,

On Tue, Mar 01, 2011 at 10:00:48AM +0200, Matti J. Aaltonen wrote:
> This is the core of the WL1273 FM radio driver, it connects
> the two child modules. The two child drivers are
> drivers/media/radio/radio-wl1273.c and sound/soc/codecs/wl1273.c.
> 
> The radio-wl1273 driver implements the V4L2 interface and communicates
> with the device. The ALSA codec offers digital audio, without it only
> analog audio is available.

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Mauro, I suppose you're taking this one ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
