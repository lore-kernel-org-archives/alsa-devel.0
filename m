From: Ivan Gyurdiev <ivg2@cornell.edu>
Subject: Re: Linux 2.6.0-test6
Date: Sun, 28 Sep 2003 12:42:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3F770F88.7050904@cornell.edu>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
To: alsa-devel@lists.sourceforge.net, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This release broke ALSA for me. OSS emulation continued to work for 
xmms, but not for wine. The via_82xx driver told me to try 
dxs_support=1, so I did and it works again.

This is an ALC650-based:

00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235 AC97 Audio Controller (rev 50)

(I'm sorry if this is a second post to LKML - mailer problems)

> Jaroslav Kysela:
>   o ALSA CVS updates
>     - clean up the usage of the size variable and removes size1.
>     - define AD198x bits.
>     - add descriptions for whole-frag and no-silence commands.
>     - use dxs_support=3 (48k fixed) as default, since there are so many problems
>       with dxs_support=0.
>     - add the support for stereo mute switches on AD198x.
>     - initialize tumbler/snapper audio via gpio before i2c initialization.
>     - add check of DXS supports (so far, empty).
>     - add detection of revision of ALC650 chip
>     - get_page() fix
>     - fix the SPDIF bit on aureon boards.
>     - set 48k only for the sample rate of SPDIF on nForce.
>     - kill of not-required version.h inclusion
>     - Remove duplicated include
>     - fix buffer overlap on FX8010 PCM.
>     - Fix hwdep hotplug problem
>     - Use try_module_get() and module_put() to block the toplevel module
>     - Fix returned error code in the release() callback
>     etc
> 
