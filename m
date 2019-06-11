From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/15] ALSA: firewire-tascam/fireface:
 reserve/release isochronous resources in pcm.hw_params/hw_free callbacks
Date: Tue, 11 Jun 2019 18:59:10 +0900
Message-ID: <20190611095909.GA19071@workstation>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
 <s5hblz4bgyy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71CA3F806F5
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 11:59:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hblz4bgyy.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 11, 2019 at 11:37:25AM +0200, Takashi Iwai wrote:
> On Sun, 02 Jun 2019 09:12:44 +0200,
> Takashi Sakamoto wrote:
> > 
> > Hi,
> > 
> > This patchset is a part of series of patches for all of drivers in
> > ALSA firewire stack to reserve/release isochronous resources in
> > pcm.hw_params/hw_free callbacks.
> > 
> > In current implementation, the resources are reserved at the same time
> > to start packet streaming, and released at the same time to stop packet
> > streaming. However, once allocated, the resources are available
> > independent of lifetime of packet streaming.
> > 
> > The isochronous resources are the resources of IEEE 1394 bus. On the
> > other side of view, it's a kind of resources of hardware to maintain
> > the bus (isochronous resource manager). For this kind of reservation and
> > release, hw_params and hw_free operations are suitable in ALSA PCM
> > interface.
> > 
> > Ideally, the operation to reserve/release isochronous resource should
> > be separated from the operation to start/stop packet streaming. However,
> > IEEE 1394 bus has reset event. Once reset occurs, isochronous resource
> > manager releases allocated resources. The resources should be
> > reallocated by requesters themselves. For this reason, in this patchset,
> > bus generation is checked before starting packet streaming. If
> > generation is updated, reallocation is requested to isochronous
> > resource manager, then packet streaming starts.
> > 
> > Takashi Sakamoto (15):
> >   ALSA: firewire-tascam: code refactoring for registration of
> >     isochronous channels
> >   ALSA: firewire-tascam: code refactoring for reservation of isochronous
> >     resources
> >   ALSA: firewire-tascam: code refactoring for release of isochronous
> >     resources
> >   ALSA: firewire-tascam: reserve/release isochronous resources in
> >     pcm.hw_params/hw_free callbacks
> >   ALSA: firewire-tascam: update isochronous resources when starting
> >     packet streaming after bus reset
> >   ALSA: firewire-tascam: minor code refactoring to finish streaming
> >     session
> >   ALSA: firewire-tascam: code refactoring for pcm.hw_params/hw_free
> >     callbacks
> >   ALSA: fireface: add protocol-specific operation to allocate
> >     isochronous resources
> >   ALSA: fireface: support allocate_resources operation in ff800 protocol
> >   ALSA: fireface: support allocate_resources operation in ff400 protocol
> >   ALSA: fireface: support allocate_resources operation in latter
> >     protocol
> >   ALSA: fireface: reserve/release isochronous resources in
> >     pcm.hw_params/hw_free callbacks
> >   ALSA: fireface: update isochronous resources when starting packet
> >     streaming after bus-reset
> >   ALSA: fireface: minor code refactoring to finish streaming session
> >   ALSA: fireface: code refactoring for pcm.hw_params/hw_free callbacks
> 
> Applied all 15 patches now.  Thanks.

Welcome back ;)

I've already prepared similar patchsets for the other drivers in ALSA
firewire stack. You'll receive the patchset several times in this week.
I'm happy if you review and apply them.


Thanks

Takashi Sakamoto
