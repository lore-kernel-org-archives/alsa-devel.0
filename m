From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [RFC v1] ALSA: xen-front: Add Xen para-virtualized
 frontend driver
Date: Fri, 17 Nov 2017 10:08:43 +0200
Message-ID: <172d2f40-937d-5455-1b4e-576ac7b0da45@gmail.com>
References: <fff5d166-066c-c21e-94b9-bb50f8c1b2cd@epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fff5d166-066c-c21e-94b9-bb50f8c1b2cd@epam.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: alsa-devel@alsa-project.org

ping

On 11/02/2017 03:11 PM, Oleksandr Andrushchenko wrote:
> Hi, all!
>
> Foreword
> ========
>
> This RFC is aimed to introduce support of para-virtualized sound frontend
> driver for Xen [1] and gather opinions from the relevant communities
> (ALSA, Xen). It implements the protocol from [2] with the
> following limitations:
>   - mute/unmute is not supported
>   - get/set volume is not supported
> Volume control is not supported for the reason that most of the use-cases
> (at the moment) are based on scenarios where unprivileged OS
> (e.g. Android, AGL etc) uses software mixers.
> Both capture and playback are supported.
>
> The relevant backend is implemented as a user-space application [3]
> and uses accompanying helper library [4].
>
> Both frontend driver and backend were tested on real HW running Xen 
> hypervisor
> (Renesas R-Car ARM based H3/M3 boards, x86).
>
> Discussion
> ==========
>
> During the first attempt to upstream the driver [5] number of comments 
> and
> concerns were raised, one of the biggest flaws in the design were 
> questioned
> by both Clemens Ladisch [6] and Takashi Sakamoto [7]: the absence of
> synchronization between frontend and backend during capture/playback.
> Two options were discussed:
>
> “In design of ALSA PCM core, drivers are expected to synchronize to
> actual hardwares for semi-realtime data transmission. The
> synchronization is done by two points:
> 1) Interrupts to respond events from actual hardwares.
> 2) Positions of actual data transmission in any serial sound interfaces
>     of actual hardwares.
> “
>
> and finally a change to the existing protocol was suggested:
>
> “In 'include/xen/interface/io/sndif.h', there's no functionalities I
> described the above:
> 1. notifications from DomU to Dom0 about the size of period for
>     interrupts from actual hardwares. Or no way from Dom0 to DomU about
>     the configured size of the period.
> 2. notifications of the interrupts from actual hardwares to DomU.”
>
> This is implemented as a change to the sndif protocol [8] and allows 
> removing
> period emulation:
> 1. Introduced a new event channel from back to front
> 2. New event with number of bytes played/captured (XENSND_EVT_CUR_POS,
>    to be used for sending snd_pcm_period_elapsed at frontend (in Linux
>    implementation). Sent in bytes, not frames to make the protocol
>    generic and consistent)
> 3. New request for playback/capture control (XENSND_OP_TRIGGER) with
>    start/pause/stop/resume sub-ops.
>
> Along with these changes other comments on the driver were addressed,
> e.g. split into smaller chunks, moved the driver from misc to xen etc.
>
>
> Hope, this helps to get the full picture of what was discussed and 
> makes it
> possible to move forward.
>
> Waiting for your valuable comments,
>
> Thank you,
> Oleksandr
>
> [1] https://github.com/andr2000/linux/commits/snd_upstream_v1
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/xen/interface/io/sndif.h
> [3] https://github.com/xen-troops/snd_be
> [4] https://github.com/xen-troops/libxenbe
> [5] https://lkml.org/lkml/2017/8/7/363
> [6] 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/123617.html
> [7] 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/123744.html
> [8] 
> https://github.com/andr2000/linux/commit/095d7feae00bf00c852c67c4f1044de5601678ed
>
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> https://lists.xen.org/xen-devel
