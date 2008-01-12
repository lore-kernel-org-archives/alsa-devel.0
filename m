From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Hotplug plugin
Date: Sun, 13 Jan 2008 00:57:49 +0100
Message-ID: <20080112235749.GB2900@tango.0pointer.de>
References: <4778FA23.8090409@slagter.name>
	<20071231144225.GB4414@tango.0pointer.de>
	<477A85C5.8010104@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 677BF248A6
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 00:57:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <477A85C5.8010104@slagter.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Erik Slagter <erik@slagter.name>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 01.01.08 19:26, Erik Slagter (erik@slagter.name) wrote:

> load-module module-alsa-sink device=hw:0 format=s16 rate=44100
> -> channels=2 sink_name=alc883 channel_map=left,right
> load-module module-alsa-sink device=hw:1 format=s16 rate=44100
> -> channels=2 sink_name=jvc channel_map=left,right
> load-module module-combine sink_name=all master=alc883 slaves=jvc
> -> adjust_time=10 resample_method=src-sinc-best-quality
> 
> ***
> 
> -> is line continuation
> 
> These combinations all yield the same result: at startup I have an "all"
> sink that combines both devices, and does that pretty well, I must say.
> But as soon as the USB device is removed, it is removed from the
> combined "all" sink. Then when the USB device is reinserted, it gets
> detected (module-hal-detect) or not (module-detect, static config).
> Using module-hal-detect the reinserted just sits there, it isn't added
> to the combined sink. Using the other methods, it's not even detected
> that the USB device is back...

Hmm, if that doesn't work with module-hal-detect, then please provide
me with a full output of pulseaudio -vv when this happens. However,
the ALSA ML is probably not the right place to discuss this. Please
post this in the PA ML.

> The only solution I can think of, is a udev script that casts some magic
> spells towards pulse when the USB device is inserted or removed... But
> then I could skip pulse altogether, because mpd has an option to
> activate and deactivate selected outputs at runtime, as well.

No. If module-hal-detect finds the device, but module-combine doesn't
then this is some real problem we need to debug. 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
