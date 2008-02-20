From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: ALSA MIDI interface - plugin
Date: Wed, 20 Feb 2008 06:09:21 +0530
Message-ID: <61445c750802191639g6ddc1097n13f9cbf88d5153b@mail.gmail.com>
References: <61445c750802140724h1585b495pcc546e2b082e086a@mail.gmail.com>
	<s5hfxvuw483.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 707532462C
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 01:39:23 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so3974029wag.8
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 16:39:21 -0800 (PST)
In-Reply-To: <s5hfxvuw483.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> It's possible, but so far, no external plugin framework is implemented
> for rawmidi.  The external plugins are available only for PCM and
> control APIs.  I guess it'd be relatively easy to add the external
> rawmidi plugins, though.
>

How can I start adding an external rawmidi plugin? As you said, there is no
framework ready yet. So, first a framework has to be created so that
external plugins can be added the same way one would add PCM or control type
plugins. It might sound a little naive but I am not familiar with the
framework part of it, but it looks interesting.

1. I think for finding out what the plugin framework would consists of I
need to have a look at alsa-lib and modify it too, is it correct?. If such a
framework is created then
will the control flow look like this:

amidi/aplaymidi ->alsa-lib with midi plugin framework->my_midi_plugin

Can you point me to some code/doc etc which might serve as start point,
basically how do I go about adding such a framework and finally, how user is
going to use
it with newly added plugin? (i.e. for pcm io type plugin we use #aplay -D
my_plugin test.wav, will it be similar for midi plugin also?)

-Pharaoh.
