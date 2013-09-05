From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Constraints and hw_params with highly configurable
 HW
Date: Thu, 05 Sep 2013 10:47:03 +0200
Message-ID: <52284507.5000004@ladisch.de>
References: <5226041B.4010105@weiss.ch> <5226232C.5080803@ladisch.de>
 <52270071.9030500@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B0B22261A00
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2013 10:47:09 +0200 (CEST)
In-Reply-To: <52270071.9030500@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uli Franke <uli.franke@weiss.ch>
Cc: Daniel Weiss <weiss@weiss.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rolf Anderegg <Rolf.Anderegg@weiss.ch>
List-Id: alsa-devel@alsa-project.org

Uli Franke wrote:
>> Then the constraints should be read from the device in the PCM open
>> callback.
>
> No, that's not possible as the constraints will/can change in case you
> request a different sample rate for instance. Therefore the constraints
> won't be known until you set the rate for instance.

The PCM constraints can represent arbitrary dependencies between the
parameters, as long as they are known to the driver.

For example, one dependency (already handled by the ALSA framework) is
between buffer size (length in frames) (A), buffer time (length in
seconds) (B), and sample rate (C), with A = B * C.  If any of these
parameters changes, the allowed range of the other two is adjusted.
For example, if a device allows sample rates between 48 kHz and 96 kHz
(but none has yet been chosen), and if the buffer time is set to 0.5 s,
then the interval for the buffer length is set to 24000...48000 frames.

My dice driver assumes that the number of channels depends only on the
sample rate (and that only 48/96/192 kHz matter).  The function
dice_rate_constraint() is called when the number of channels in the
snd_pcm_hw_params structure changes, and adjusts the allowed sample
rates accordingly; the function dice_channels_constraint() is called
when the sample rate changes, and adjusts the allowed number of channels
accordingly.

> And you will never be able to pre-fetch this information reliably as
> the DICE firmware is allowed to change its setup arbitrarily.

A generic DICE driver does not know what some arbitrary firmwares does,
but for Weiss devices, you know the rules, don't you?


Regards,
Clemens
