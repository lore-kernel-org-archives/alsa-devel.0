From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: support
 notification of
Date: Fri, 23 Nov 2018 13:19:06 +0900
Message-ID: <20181123041906.GA23251@sakamocchi.jp>
References: <20181123041307.22980-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by alsa0.perex.cz (Postfix) with ESMTP id D0804267865
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 05:19:14 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id 17so2515809pgg.1
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 20:19:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181123041307.22980-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, sbahling@suse.com
List-Id: alsa-devel@alsa-project.org

Oops, the subject line is truncated... It should be
"ALSA: firewire-tascam: support notification of change of state for
control surface". (My text editor works for the surplus.)

On Fri, Nov 23, 2018 at 01:13:02PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> Units of TASCAM FireWire series transfer its state in tx isochronous
> packets. The way to handle change of the state is a longstanding issue
> since I firstly reveal the mechanism in this list[1].
> 
> In this time, Scott Bahling dedicates for further investigation to seek
> better implementation[2][3][4]. Finally, we identified meaning of the
> most of bits in the image of state, and decided which changes are worth
> for userspace applications to handle as events.
> 
> This commit adds support notification of the events. Userspace
> applications can handle the notification via ALSA hwdep interface.
> Furthermore, they can retrieve image of the latest states via the
> interface.
> 
> Changes from the initial proposal[5]:
>  - obsolete usage of mmap(2) due to several disadvantages. Instead, use
>    event queue for change notification, and add ioctl command to retrieve
>    image of states.
> 
> Changes from the latest work[6]:
>  - To reduce time in an interrupt context in which tx isochronous packets
>    are handled, data in the event and the image is passed to userspace in
>    big-endian order. Additionally, image of the states are passed to
>    userspace in big-endian order as well. Userspace applications are
>    responsible to convert the data in host-endianness order.
>  - improve efficiency to copy batch of events to userspace in hwdep
>    interface
>  - rename structure and macro name.
> 
> This patchset is also available in my remote branch for backport purpose
> to Linux v4.17 or later[7].
> 
> I've already prepare userspace implementation; libhinwa. A
> 'topic/firewire-tascam-pr' remote branch includes patchset for the
> additional feature[8]. This library produces GObject class to handle the
> event notification and emits GObject signal, and has a method
> 'HinawaSndTscm.get_state()', with enough consideration to endianness.
> Developers can process change of state with these two APIs.
> 
> > Scott
> 
> As the above, I changed method name from 'HinawaSndTscm.get_status()'.
> I'd like you to change your local implementation for 'hinawa-utils'.
> Sorry to add further work to you.
> 
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094817.html
> [2] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140051.html
> [3] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-October/140593.html
> [4] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-November/141395.html
> [5] https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace
> [6] https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace-take3
> [7] https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace-pr
> [8] https://github.com/takaswie/libhinawa/tree/topic/tascam-userspace-pr
> 
> Regards
> 
> Takashi Sakamoto (5):
>   ALSA: firewire-tascam: pick up data of state from tx isochronous
>     pakcets
>   ALSA: firewire-tascam: add new hwdep ioctl command to get state image
>   ALSA: firewire-tascam: queue events for change of control surface
>   ALSA: firewire-tascam: apply small refactoring to handle several type
>     of event for hwdep interface
>   ALSA: firewire-tascam: notify events of change of state for userspace
>     applications
> 
>  include/uapi/sound/firewire.h        |  20 +++++
>  sound/firewire/tascam/amdtp-tascam.c |  51 +++++++++++-
>  sound/firewire/tascam/tascam-hwdep.c | 115 +++++++++++++++++++++++----
>  sound/firewire/tascam/tascam.h       |   9 +++
>  4 files changed, 180 insertions(+), 15 deletions(-)
> 
> -- 
> 2.19.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
