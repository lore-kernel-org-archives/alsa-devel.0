From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Echo Audiofire 12 issues
Date: Mon, 28 May 2018 22:38:59 +0900
Message-ID: <672c8a05-ead2-221a-5430-f071ee208d25@sakamocchi.jp>
References: <1527458701.3272.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 63415267046
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 15:39:04 +0200 (CEST)
In-Reply-To: <1527458701.3272.0@smtp.gmail.com>
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
To: Adriano Michael Petrosillo <ampetrosillo@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
(C.C.ed alsa-devel)

On May 28 2018 07:05, Adriano Michael Petrosillo wrote:
> Hi,
> 
> I'm contacting you regarding a few issues with my Echo Audiofire 12. It 
> has the latest firmware (5.8). With a recent kernel (4.15.0-22-generic) 
> it is recognised by the OS but it works unreliably, leading to system 
> instability.

Please explain about your experiences which made you be unreliable and 
feel instability to your system so that the others such as me can get them.

> Here is the dmesg output:
> 
> [ 6019.402918] firewire_core 0000:04:07.0: PHY ID mismatch in self ID: 0 
> != 1
> [ 6019.402931] firewire_core 0000:04:07.0: topology build failed
> [ 6019.934272] firewire_core 0000:04:07.0: rediscovered device fw0
> [ 6065.194414] firewire_core 0000:04:07.0: phy config: new root=ffc1, 
> gap_count=5
> [ 6065.700801] firewire_core 0000:04:07.0: created device fw1: GUID 
> 0014865e75918c0e, S400
> [ 6067.619626] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619663] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619670] snd-fireworks fw 1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619676] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619683] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619689] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619695] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619701] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619706] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000
> [ 6067.619712] snd-fireworks fw1.0: Invalid CIP header for AMDTP: 
> 00000000:00000000

In the beginning of packet streaming, your unit transfers packets with 
invalid CIP header, as shown. But enough later it starts to transfer the 
packet correctly. The above message is irrelevant to your issue.

> It is also impossible to use as a system card, and alsamixer is unable 
> to set the volumes for the 12 channels, but here I'm probably doing 
> something wrong. If you want to improve support for the card, I can 
> cooperate, I have no coding skills unfor tunately.

ALSA fireworks driver adds no control element set in Linux system. This 
is a design not to bring complexity into kernel stuffs. For control 
feature to DSP on your unit, please use 'hinawa-fireworks-cui' in 
'hinawa-utils'[1] with 'libhinawa'[2], or ffado-dbus-server/ffado-mixer[3].

[1] https://github.com/takaswie/hinawa-utils
[2] https://github.com/takaswie/libhinawa
[3] http://subversion.ffado.org/


Regards

Takashi Sakamoto
