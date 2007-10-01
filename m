From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: some alsa lib usage on arm926 platform
Date: Mon, 01 Oct 2007 09:07:59 +0200
Message-ID: <1191222479.12581.1213434995@webmail.messagingengine.com>
References: <loom.20070922T073328-313@post.gmane.org>
	<loom.20070928T152516-14@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8265B24346
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Oct 2007 09:08:00 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 00CC02F54C
	for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2007 03:07:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20070928T152516-14@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Akio wrote:
> 1. what is the different between "plughw:0,0", "defalut", "hw:0.0"?

"hw" goes directly to the driver, without any plugins.
"plughw" inserts sample rate and/or sample format conversion plugins if
the format requested by the application is not supported by the driver.
"default" does some additional things, depending on the driver.  On most
cards, it adds the "dmix" plugin for software mixing.

> a. the channel opened is just only one, but If I set the 
>    snd_pcm_hw_params_set_access as 
>    SND_PCM_ACCESS_RW_NONINTERLEAVED.
>    using snd_pcm_readn and snd_pcm_writen the code will not 
>    work. what is the wrong? 
>    but if set snd_pcm_hw_params_set_access as
>    SND_PCM_ACCESS_RW_INTERLEAVED
>    and using snd_pcm_readi and snd_pcm_writei. the code work 
>    very well. one channel also have data interleave problem?

INTERLEAVED is the only supported format for most stereo sound cards, so
it is the setting to be used for mono, too.

NONINTERLEAVED is only used for multichannel streams that are not
interleaved.

> b. in snd_pcm_open the block flag is set as 0. what is the mode 
>    of the operation? blocking or non-blocking? 

Blocking.

> After long time test. the test procedure is as the following steps:
>    1. capture voice data as PCM data.
>    2. encoded as amr-wb bit stream.
>    3. decoded as PCM data from encoded bit stream.
>    4. playback PCM data.
> after 16 hours continue tests, there are some delay, about 800 
> mili seconds.

You did not specify between what two quantities you've measured the
delay, but I guess you mean the relative positions of the playback and
capture devices.

The speed of the devices is determined by the hardware.  The playback
and capture devices will run out of sync if they are not using the same
clock.  Are the capture and playback devices on different computers?

> is there any way to reduce the delay after long time test.

Measure the relative speed of the capture and playback devices, then
resample accordingly (or just insert or drop a sample when needed).

> 5. If we want using salsa lib to replace the usage of alsa lib, 
>    what do we have to take care?

Plugins for sample rate/format conversion of software mixing are not
available, so your application must use a sample format support by the
hardware, and only one application can use the device at the same time.

> how about the latency and performance between salsa and alsa?

This is the same as when using the "hw" device with alsa-lib.
The purpose of salsa is to save memory.


HTH
Clemens
