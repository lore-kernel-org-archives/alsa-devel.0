From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: firewire mixer interface -- was Re: [PATCH 11/11]
 ALSA: digi00x: apply double-oh-three algorism to multiplex PCM samples
Date: Fri, 20 Mar 2015 22:25:26 +0900
Message-ID: <550C1FC6.4050700@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
 <55082E06.6010008@gareus.org> <55083103.5030704@gmail.com>
 <5508CFA5.7060903@sakamocchi.jp> <550AD65F.10803@gareus.org>
 <550B51BC.80506@sakamocchi.jp> <550C0CFC.4060404@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id EE9EE26049B
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 14:25:31 +0100 (CET)
In-Reply-To: <550C0CFC.4060404@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, Damien Zammit <damien.zammit@gmail.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Robin,

On Mar 20 2015 21:05, Robin Gareus wrote:
>> $ ./firewire-request /dev/fw1 write 0xffffe0000118 0x0000000[0|1|2|3]
> 
> Yes, that's what I was asking about. Can one safely write raw control
> messages to /dev/fw* without interfering with ongoing streaming?

Any userspace applications can destroy packet streaming which kernel
driver starts, by transaction to streaming-related register.

In current implementation of ALSA firewire stack and Linux FireWire
subsystem, we cannot avoid this.

For example, about Digi 002/003 family, we can destroy kernel streaming
in a way below:
1.write/read PCM samples to ALSA PCM character devices (in most case
done via alsa-lib PCM API)
2.write transaction with 0x00000003 for 0xffffe0000004 to /dev/fw%u.
3.Applications cannot read/write PCM samples again.

In this case, usually, the process receive EIO from ALSA PCM API.

> Instead interfacing via established protocols /dev/snd/control* or
> rather libasound's snd_mixer_t seems like a no-brainer to me.

As long as being able to send transactions via FireWire character
devices, the headache remains, regardless of the place to implement such
control functionality.

> Are there any control elements on common 1394 devices that cannot be
> properly exposed using existing infrastructure?

More explaination, please.

>> On the other hand, IEEE 1394 bus-connected sound devices implements its
>> own way to tell their control capabilities and model-specific way to
>> perform control. Thus we should prepare for model-specific parsers. The
>> idea to include these parsers into kernel-space increases maintaining
>> efforts.
> 
> Agreed. Most of the heavy lifting should probably be done by libasound.

I don't think it possible to argue the other ALSA developers for going
to include such vendor-specific or model-specific huge codes to
alsa-lib... (Except for intel HDA)

>> In an aspect of user experience, I cannot find any differences between
>> using alsamixer (or amixer) and using specific-application.
> 
> Uhm. It's a huge difference. There is a whole lot of existing
> infrastructure: from Sys-V init.d and/or SystemD save/restore, dbus
> hooks, existing mixer GUIs and application integration, not to mention
> various language bindings (eg pyalsa).

Here, I mention about alsa-lib control API to add control elements from
userspace and it's eventing mechanism.
http://www.alsa-project.org/alsa-doc/alsa-lib/group___control.html#gad5f640f1d836b532b1c18d7604a90bad

Regards


Takashi Sakamoto
