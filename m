From: "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
Subject: Re:
 =?utf-8?q?RME_Fireface_alsa_driver_-_improved_but_st?=
 =?utf-8?q?ill_not=09working?=
Date: Tue, 23 Apr 2019 02:03:49 -0400
Message-ID: <5c68a159-5d32-432a-996d-0683310ff1ad@www.fastmail.com>
References: <53dc5ff5-bee5-5998-dcd4-1dd1f926c857@halfshavedyaks.xyz>
 <20181211204344.GA16818@workstation>
 <a61bd3e8-0ace-3ef1-ffa4-f56c3c67fd31@halfshavedyaks.xyz>
 <alpine.DEB.2.21.1812172247580.1336@laptop>
 <c4a1e138-64b8-7926-2927-8af99134e817@halfshavedyaks.xyz>
 <20181219042203.GA8794@workstation>
 <e3b5b326-e418-eea2-fe77-a1c828d5cb09@halfshavedyaks.xyz>
 <20190105085024.GA29901@workstation>
 <663f96f0-8652-ce5e-7572-ade544ff3cd3@halfshavedyaks.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C83DCF8070C
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2019 08:03:53 +0200 (CEST)
In-Reply-To: <663f96f0-8652-ce5e-7572-ade544ff3cd3@halfshavedyaks.xyz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: thet <parenthetical@halfshavedyaks.xyz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Apr 18, 2019, at 06:01, thet wrote:
> I notice that the RME fireface alsa driver snd-fireface now works a
> little since 4.19 I think
> 
> In earlier kernels 4.18 and below the midi worked on the FF400 but no
> audio and the FF800 was not supported at all.
 
FF400 support was firstly added to Linux v4.12, however the initial driver
includes some bugs. Below fixes were already committed to stable kernels.

 * fa9c98e4b975 ("ALSA: fireface: fix reference to wrong register for clock configuration")[1]
 * 3d16200a3e55 ("ALSA: fireface: fix for state to fetch PCM frames")[2]

If using Linux kernel v4.19.14 or later, or v4.14.92 or later, both of
audio and midi work with FF400.

> now the midi works on both FF400 and FF800 and the audio works a little.
 
> the kernel I am using is 5.0.0-7.1-liquorix-amd64 #1 ZEN SMP PREEMPT
> liquorix 5.0-6ubuntu1~bionic (2019-04-06) x86_64 x86_64 x86_64 GNU/Linux
 
FF800 support was firstly added to Linux v5.0.

> (I am also happy to test with a different kernel but I am not able to
> compile it myself so it would need to be available in a repo.)
> 
> The audio however does not work correctly. It is unstable, sometimes it
> works for a while but other times it glitches or even becomes wildly
> distorted.

Yes. I've reported this issue when posting the RFC patchset of this
driver[3]. Furthermore, I experience the issue in all of supported models;
FF400, FF800 and UCX.
 
> I am not a kernel developer at all - but I am willing to test and post
> logs if it helps - if anyone here can give me clear instructions about
> how to test.

This issue belongs to knowledge about protocol used in transmission of
data on IEEE 1394 bus, thus it's beyond to kernel development.

On RME Fireface series, unique protocol is used to transfer PCM
frames and its presentation timing[4][5][6]. This is completely
different from the standard protocol; IEC 61883-1/6. Therefore,
thorough packet analysis is required, but nobody has achieved to clear
it.

> Also - is it possible for a user to disable the audio part of the driver
> but still use the midi part?
> 
> This would allow me to use the audio with FFADO and the midi with alsa.
> FFADO doesn't support midi on these devices so it is great that alsa
> does -  but running both at once can be tricky as the alsa driver does
> not let FFADO take over the device once it has it.

I designed ALSA fireface driver with enough care for libffado, so you can
use ALSA MIDI functionality and libffado packet streaming at the same time.

For details, please read commit logs relevant to ALSA fireface driver[7]
I'll always write the logs with enough information about my commit,
especially about the way to handle the target device, unclear points,
impacts/requirements for userspace applications and so on.

> Can I suggest that maybe the audio and midi drivers for these devices
> could be made as separate kernel modules? Then if one part has problems
> it need not be loaded. I'm not sure if this is feasible but if it is it
> would allow more flexibility in how they are used.

You seem to register one of the separated modules accounting for PCM
feature to blacklist for kmod. I have a mixed feeling to this idea.

When ALSA firewire stack got a driver for devices which libffado also
supports[8], an userspace API was introduced as well. This API is
designed to disallow the kernel driver to start packet streaming.
This feature is expected to intervene kernel drivers and userspace
applications against resources of the packet streaming.

The application can disallow kernel drivers for it by a simple way
(opening ALSA FwDep character device execute ioctl(2) with
SNDRV_FIREWIRE_IOCTL_LOCK, then close).

I'll suggest you to encourage libffado developers (or yourself) to
implement it because the cost to separate kernel module is not so cheap
as you expected.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/fireface?id=fa9c98e4b975
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/fireface?id=3d16200a3e55
[3] https://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102261.html
[4] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/fireface?id=53eb086750f3
[5] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/fireface?id=6fb7db902bbe
[6] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/fireface?id=4b316436ab2e
[7] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/sound/firewire/fireface
[8] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/firewire?id=82fbb4f7b47683077e071
[9] https://github.com/takaswie/libhinawa/blob/master/src/snd_unit.c#L235


Regards

Takashi Sakamoto
