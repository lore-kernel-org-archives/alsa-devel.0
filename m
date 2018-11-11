From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] ARM: staging: bcm2835-audio:
	interpolate audio delay
Date: Sun, 11 Nov 2018 21:18:12 +0100 (CET)
Message-ID: <1197390391.186035.1541967492518@email.ionos.de>
References: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 766B42677E4
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2018 21:18:22 +0100 (CET)
In-Reply-To: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Brady <mikebrady@eircom.net>, tiwai@suse.de
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, f.fainelli@gmail.com, julia.lawall@lip6.fr, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, nishka.dasgupta_ug18@ashoka.edu.in, Kirill Marinushkin <k.marinushkin@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mike,

> Mike Brady <mikebrady@eircom.net> hat am 11. November 2018 um 19:21 geschrieben:
> 
> 
> When the BCM2835 audio output is used, userspace sees a jitter up to 10ms
> in the audio position, aka "delay" -- the number of frames that must
> be output before a new frame would be played.
> Make this a bit nicer for userspace by interpolating the position
> using the CPU clock.
> The overhead is small -- an extra ktime_get() every time a GPU message
> is sent -- and another call and a few calculations whenever the delay
> is sought from userland.
> At 48,000 frames per second, i.e. approximately 20 microseconds per
> frame, it would take a clock inaccuracy of
> 20 microseconds in 10 milliseconds -- 2,000 parts per million --
> to result in an inaccurate estimate, whereas
> crystal- or resonator-based clocks typically have an
> inaccuracy of 10s to 100s of parts per million.
> 
> Signed-off-by: Mike Brady <mikebrady@eircom.net>

the former version of your patch has already been applied to staging-next.

Didn't you received Greg's email?

So please rebase your changes.

Stefan
