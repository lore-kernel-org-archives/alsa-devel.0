From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Thu, 15 Nov 2018 00:50:30 +0200
Message-ID: <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
 <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 4932F267A61
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 23:50:34 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id w7-v6so16984816wmc.1
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 14:50:34 -0800 (PST)
In-Reply-To: <20181114220640.GB2089@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 11/15/2018 12:06 AM, Mark Brown wrote:
> Switching between clocks while the device isn't completely idle is
> unlikely to work well with any device - I'd have questions about a use
> case that's doing that.

The clocks are switched inside the hw_params callback of the
machine driver, when the sampling rate changes from a multiple of
48kHz to a multiple of 44.1kHz and vice versa, usually after
opening the device and before starting playback.  That has to be
so, as far as I can see.

If by idle you mean, not playing, then the device is idle during
the switch.  If by idle you mean biased off, then it depends on
circumstance.  For instance if playback at 44.1kHz is stopped and
quickly restarted at 48kHz, as often happens, the device won't
have had the chance to sit long enough to be biased off (and even
if it has, I'm not entirely sure whether it won't be biased on
before the hw_params callback).  The pop may still be avoided if
auto-mute is used, but that's not always the case.  My proposed
fix on the other hand consistently avoids generating the pop and
does not rely on muting.  I'm just not sure how to best implement
it.
