From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: S24_BLE does not play using aplay.
Date: Fri, 07 Nov 2008 15:08:18 +0100
Message-ID: <49144BD2.3070400@ladisch.de>
References: <aceb60a00811061659o11eec5f4s6c5b6c4ba470b873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id DB75F24413
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 15:08:08 +0100 (CET)
In-Reply-To: <aceb60a00811061659o11eec5f4s6c5b6c4ba470b873@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Baek Chang <baeksan@ccrma.stanford.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Baek Chang wrote:
> Playing WAVE 'sine_24_48k.wav' : Signed 24 bit Little Endian in 3bytes, Rate 48000 Hz, Stereo
> aplay: set_params:961: Sample format non available

This error message indicates that the device does not support the sample
format.

You didn't show the aplay command line, but I'd guess that you used a
"hw" device.  Try "plughw" or "default" to get automatic sample format
conversion.


HTH
Clemens
