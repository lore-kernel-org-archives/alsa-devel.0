From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [Alsa-devel] RE: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- First good news!
Date: Fri, 09 Apr 2004 18:49:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200404092249.i39MnNwx025652@dhin.linuxaudiosystems.com>
References: <20040409222552.MLZG22605.smtp2.fuse.net@64BitBadass>
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-reply-to: Your message of "Fri, 09 Apr 2004 18:25:47 EDT."
             <20040409222552.MLZG22605.smtp2.fuse.net@64BitBadass>
To: Ivica Ico Bukvic <ico@fuse.net>
Cc: 'A list for linux audio users' <linux-audio-user@music.columbia.edu>, 'Russell King' <rmk+lkml@arm.linux.org.uk>, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org, 'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org, 'Tim Blechmann' <TimBlechmann@gmx.net>
List-Id: alsa-devel@alsa-project.org

>Well, if there is a way of monitoring these hex registers for various
>hardware in Linux I could try to compare their state upon initialization in
>Linux to that one in Windows (since in both situations they share the same
>IRQ, at least on my notebook) and forward this info to you guys.
>
>So my question at this point is, is there such hex-editor in Linux that
>allows this kind of monitoring and if so where can I obtain it?

i would imagine that you have it already, though its cmdline: setpci
(and lspci -vv for the display side, so to speak).

not sure if this is really the equivalent, but i suspect that it is.

--p
