From: Robin Gareus <robin@gareus.org>
Subject: firewire mixer interface -- was Re: [PATCH 11/11]
 ALSA: digi00x: apply double-oh-three algorism to multiplex PCM samples
Date: Fri, 20 Mar 2015 13:05:16 +0100
Message-ID: <550C0CFC.4060404@gareus.org>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
 <55082E06.6010008@gareus.org> <55083103.5030704@gmail.com>
 <5508CFA5.7060903@sakamocchi.jp> <550AD65F.10803@gareus.org>
 <550B51BC.80506@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 07A1E2654AD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 13:05:31 +0100 (CET)
In-Reply-To: <550B51BC.80506@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net, Damien Zammit <damien.zammit@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/19/2015 11:46 PM, Takashi Sakamoto wrote:

Hi Takashi

Thanks for elaborating.

[..]

> For example, to control the clock selector of Digi 002/003 family, we
> just execute this command with firewire-request.
> 
> $ ./firewire-request /dev/fw1 write 0xffffe0000118 0x0000000[0|1|2|3]

Yes, that's what I was asking about. Can one safely write raw control
messages to /dev/fw* without interfering with ongoing streaming?


Instead interfacing via established protocols /dev/snd/control* or
rather libasound's snd_mixer_t seems like a no-brainer to me.

Are there any control elements on common 1394 devices that cannot be
properly exposed using existing infrastructure?

> On the other hand, IEEE 1394 bus-connected sound devices implements its
> own way to tell their control capabilities and model-specific way to
> perform control. Thus we should prepare for model-specific parsers. The
> idea to include these parsers into kernel-space increases maintaining
> efforts.

Agreed. Most of the heavy lifting should probably be done by libasound.

> In an aspect of user experience, I cannot find any differences between
> using alsamixer (or amixer) and using specific-application.

Uhm. It's a huge difference. There is a whole lot of existing
infrastructure: from Sys-V init.d and/or SystemD save/restore, dbus
hooks, existing mixer GUIs and application integration, not to mention
various language bindings (eg pyalsa).

Linux Audio is already fragmented enough as it stands, adding yet
another interface/toolchain won't help. One might just as well continue
to use ffado. I was under the impression that the whole point of moving
1394 audio into the kernel was to allow seamless integration with the
rest of ALSA.

2c,
robin
