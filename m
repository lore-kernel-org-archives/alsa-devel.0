From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Echo Fireworks control protocol (was Re: Sample
 program for hwdep interface)
Date: Sat, 08 Feb 2014 22:22:40 +0900
Message-ID: <52F62FA0.6040809@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
 <52B45837.2080804@sakamocchi.jp> <20131221101123.GA17855@marvin.atrad.com.au>
 <52C93F8B.1010701@sakamocchi.jp> <20140112142230.4aacdc9e@stein>
 <52D2B41B.7090505@sakamocchi.jp> <20140202145850.1f8684b3@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CE3A2607BB
 for <alsa-devel@alsa-project.org>; Sat,  8 Feb 2014 14:22:48 +0100 (CET)
In-Reply-To: <20140202145850.1f8684b3@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, Clemens Ladisch <clemens@ladisch.de>, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

I'm sorry to be late for reply but I've been reading related 
specifications and check your message.

> OHCI-1394
> ---------
> Assuming that we have an FCP controller with an OHCI link-layer controller
> and an FCP target with an OHCI link layer, then a typical FCP transaction
> would look like this (c = controller node, t = target node, req = 1394
> write request packet, rsp = 1394 write response packet):
>
> 	(FCP transaction request subaction)
> 	c->t  req at 0xffff'f000'0b00
> 	t->c  ack_pending
> 	t->c  rsp re: 0xffff'f000'0b00
> 	c->t  ack_complete
> 	(FCP transaction response subaction)
> 	t->c  req at 0xffff'f000'0d00
> 	c->t  ack_pending
> 	c->t  rsp re: 0xffff'f000'0d00
> 	t->c  ack_complete
>
> I.e. one FCP transaction is typically wrapped into IEEE 1212/ IEEE 1394
> split transactions.  In contrast, EFC transactions are wrapped into IEEE
> 1212/ IEEE 1394 unified transactions (if we assume that EFC controller
> and EFC responder had an OHCI link layer):
>
> 	(EFC transaction request subaction)
> 	c->t  req at 0xecc0'0000'0000
> 	t->c  ack_complete
> 	(EFC transaction response subaction)
> 	t->c  req at 0xecc0'8000'0000
> 	c->t  ack_complete

Here is a log with debug=1 for firewire-ohci.

A FCP transaction:
[ 2234.652306] firewire_ohci 0000:0c:06.0: AT spd 2 tl 35, ffc1 -> ffc0, 
ack_pending , BW req, fffff0000b00 28,0
[ 2234.652434] firewire_ohci 0000:0c:06.0: AR spd 2 tl 35, ffc0 -> ffc1, 
ack_complete, W resp
[ 2234.653719] firewire_ohci 0000:0c:06.0: AR spd 2 tl 36, ffc0 -> ffc1, 
ack_pending , BW req, fffff0000d00 128,0
[ 2234.653764] firewire_ohci 0000:0c:06.0: AT spd 2 tl 36, ffc1 -> ffc0, 
ack_complete, W resp

AN EFC transaction:
[ 2340.506243] firewire_ohci 0000:0c:06.0: AT spd 2 tl 38, ffc1 -> ffc0, 
ack_pending , BW req, ecc000000000 18,0
[ 2340.506336] firewire_ohci 0000:0c:06.0: AR spd 2 tl 38, ffc0 -> ffc1, 
ack_complete, W resp
[ 2340.506450] firewire_ohci 0000:0c:06.0: AR spd 2 tl 1f, ffc0 -> ffc1, 
ack_complete, BW req, ecc080000000 24,0
(fw_send_request() is canceled because (request->ack == ACK_COMPLETE))

I think EFC request is similar to FCP request, like split transaction, 
not unified transaction. But firewire-core handles response as unified 
transaction.

> Link layer controllers which are *not* OHCI-1394 implementations may use
> one or the other 1212/ 1394 transaction type in either of the two
> transport protocols.  Furthermore, OHCI-1394 also allows split transaction
> behavior to be configured for the range below 0xffff'0000'0000, but Linux'
> firewire-ohci and older Linux' ohci1394 configure unified transaction
> behavior, which is implemented by means of posted host bus writes by the
> OHCI.  Lastly, some OHCI-1394 hardware allows addresses like the EFC range
> to be covered by the physical response unit, but neither firewire-ohci nor
> ohci1394 extend the OHCI physical response range over the EFC register
> range.

OK.

> Anyway; the use of split or unified transactions is immaterial to the
> question of exclusive use versus shared use of these address ranges by the
> application layer.

OK. But it's nice information to me. Thank you ;)

> IEEE 1212
> ---------
> 	Memory space,
> 	[0x0000'0000'0000...0xffff'e000'0000):
> 	"The name reflects a historical expectation that node resources
> 	located here exhibit behaviors usually associated with memory.
> 	That is, read and write transactions do not have side effects.
> 	In fact, any node resources may be located in this address space
> 	--- even registers with associated side effects."
>
> That is, EFC uses Memory space.  (Particularly, it uses Memory space for
> two vendor-defined registers with write side effects.)
>
> 	Units space,
> 	[0xffff'f000'0800...0x1'0000'0000'0000):
> 	"Allocated for cooperative, shared definition by the applicable
> 	bus standard or the organizations or vendors responsible for unit
> 	architectures."
>
> That is, FCP uses Units space.

OK.

> According to this, we can do anything we want within the EFC address range
> (just take care that different applications do not confuse each other),

OK.

> From comments in your sources (added by patch 19/52 "fireworks: Add
> transaction and some commands"), I guess that bytes 1...4 in EFC response
> frames allow applications to match response frames with request frames.
> If so, the implementation could be organized similarly to FCP:

It's patch 25/52.
[alsa-devel] [PATCH 25/52] fireworks: Add command/response functionality 
into hwdep interface.
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071845.html

3rd quadlet in EFC transaction frame is used for sequence number. When 
devices receive command, they respond with sequence number increment by 
1. And I confirm devices can correctly handle commands which don't has 
continuous sequence number.

> firewire-core could allow multiple application programs (in kernelspace or
> in userspace) to register for listening at
> [0xecc0'8000'0000...0xecc0'8000'0200) and would give copies of all
> incoming EFC response frames to all listeners.

OK.

> It would then be the responsibility of the listeners to sort out which of
> the responses are theirs, and which to ignore.  When implemented correctly
> in those applications, this matching of commands and responses would work
> with any number of controller applications and with any number of target
> devices on any number of 1394 buses attached to the host.

OK.

> However, there are some more considerations:
>
>    - This perhaps requires that none of the EFC controllers tell the EFC
>      target to use an EFC_RESPONSE address other than the default,
>      0xecc0'8000'0000.

I'm optimistic about this issue.

The way to change the address is just via EFC command, here is no other 
ways. And I've already confirmed all of Fireworks models uses this 
address as a default, with Echo Audio's resources.

Then usual users have no chance to change the address, no chance to face 
changed address, unless they hope and work to do it.

>    - How well do Fireworks devices deal with overlapping EFC transactions?
>      In other words, may two or even more controller applications (e.g. one
>      streaming driver in kernelspace and one mixer UI in userspace) operate
>      independently, or do they have to coordinate certain actions?

Fireworks devices don't mind who sends commands.

They just receive commands and send responses against them with 
incremented sequence number. So, like FCP applications, EFC applications 
need to match their command and response by the sequnce number. When any 
applications uses duplicated sequence number in command, matching may be 
failed.

To prevent from this failure, hwdep functionality of snd-fireworks check 
the sequence number field. If it's in the number for kernel-land, the 
ioctl is failed. You can see the number in include/uapi/sound/firewire.h.

But users can send EFC command via firewire character devices. There is 
no way to prohibit users to send command with number for kernel-land.

>    - In firewire-core, we could hardwire shared use of
>      [0xecc0'8000'0000...0xecc0'8000'0200) just like we hardwired shared
>      use of FCP_COMMAND and FCP_RESPONSE.  This assumes that no other
>      application --- outside of Fireworks control applications --- attempts
>      to use this address range.
>
>      Or we could add an in-kernel API and kernel--userspace ABI which lets
>      applications request shared listening to an address range (in contrast
>      to the existing API/ ABI which lets applications register for
>      exclusive listening to an address range).
>
>      In the latter case, the userspace ABI could be either firewire-core's
>      firewire-cdev interface, or it could be ALSA's hwdep interface.
>
>      In the former case, firewire-cdev and/or hwdep could be used as well,
>      although firewire-cdev would be the more natural choice.

I believe ioctl with FW_CDEV_IOC_ALLOCATE is better because it's simple.
I want to avoid big modification to firewire subsystem. This 
functionality is just for a few devices (13 models).

> I understood from Clemens' comments that he intended that mixer
> applications should use hwdep only
>    - to match ALSA hwdep nodes with firewire-cdev nodes,
>    - to lock/ unlock streaming,
>    - in the future:  to receive certain status information from the ALSA
>      driver if that status is only available as in-band data from the
>      isochronous data stream, or if that status is nowhere available
>      because it is implicit status of write-only registers,
> whereas the mixer applications are supposed to use firewire-cdev for all
> their other dealings with the audio devices.  (Clemens and Jonathan,
> correct me if I misunderstood or if I forgot other control and status I/O
> that is only possible with direct cooperation by the ALSA driver.)

I don't know his future plan. But according to his advices, my current 
work is to focus on streaming driver. Currently the functionality to 
control device's internal mixer should be implemented in user-land 
application, not in ALSA drivers.

Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
