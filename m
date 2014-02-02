From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Echo Fireworks control protocol (was Re: Sample
 program for hwdep interface)
Date: Sun, 2 Feb 2014 14:58:50 +0100
Message-ID: <20140202145850.1f8684b3@stein>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
 <52B45837.2080804@sakamocchi.jp>
 <20131221101123.GA17855@marvin.atrad.com.au>
 <52C93F8B.1010701@sakamocchi.jp> <20140112142230.4aacdc9e@stein>
 <52D2B41B.7090505@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 131E626504A
 for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2014 14:58:52 +0100 (CET)
In-Reply-To: <52D2B41B.7090505@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, Clemens Ladisch <clemens@ladisch.de>, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Jan 13 Takashi Sakamoto wrote:
> Hi Stefan,
> 
>  > another alternative would be to implement sharing/multiplexing of the
>  > EFC response address range in firewire-core, like it is implemented
>  > for FCP_COMMAND and FCP_RESPONSE.  Not sure if it is wise to share
>  > nonstandard address ranges though.
> 
> Currently I'm considering to use AV/C-command-based EFC in kernel-land. 
> Fireworks has a face of GenericAVC and commands with issue may be 
> replaced with some AV/C commands for a few purposes (but I have never 
> checked my idea).
> 
> I need more time for this issue.
> 
> And, just from my curiosity, is your solution allowed by related 
> specifications such as OHCI1394 or IEEE1394? I have a little 
> knowledgement about these specification.

I figure from your driver your that EFC_COMMAND and EFC_RESPONSE are
located at
	[0xecc0'0000'0000...0xecc0'0000'0200) and
	[0xecc0'8000'0000...0xecc0'8000'0200),
although the latter apparently could be reconfigured by the controller
according to a comment in your sources.  On the other hand, FCP_COMMAND
and FCP_RESPONSE are of course located at the addresses
	[0xffff'f000'0b00...0xffff'f000'0d00) and
	[0xffff'f000'0d00...0xffff'f000'0f00),
which are not configurable.

So, let's see what the specifications provide for these address ranges.


OHCI-1394
---------

>From the point of view of OHCI-1394 --- which can be roughly described as a
specification for 1394 link layer controllers or 1394-to-PCI bridges ---,
DMA programming of the EFC address range works in the same way as with the
FCP address range, i.e. by asynchronous reception DMA in buffer-fill style.

The two address ranges are treated differently though with respect to
acknowledge packets and 1394 response subactions:  According to OHCI-1394
clauses 3.3.2 and 3.3.3, incoming write requests to addresses below
0xffff'0000'0000 are immediately acknowledged with ack_complete by the
OHCI, whereas any requests to addresses at or above 0xffff'0000'0000 are
acknowledged with ack_pending by the OHCI and presumably followed up by a
subsequent 1394 response subaction from transaction layer software.

Assuming that we have an FCP controller with an OHCI link-layer controller
and an FCP target with an OHCI link layer, then a typical FCP transaction
would look like this (c = controller node, t = target node, req = 1394
write request packet, rsp = 1394 write response packet):

	(FCP transaction request subaction)
	c->t  req at 0xffff'f000'0b00
	t->c  ack_pending
	t->c  rsp re: 0xffff'f000'0b00
	c->t  ack_complete
	(FCP transaction response subaction)
	t->c  req at 0xffff'f000'0d00
	c->t  ack_pending
	c->t  rsp re: 0xffff'f000'0d00
	t->c  ack_complete

I.e. one FCP transaction is typically wrapped into IEEE 1212/ IEEE 1394
split transactions.  In contrast, EFC transactions are wrapped into IEEE
1212/ IEEE 1394 unified transactions (if we assume that EFC controller
and EFC responder had an OHCI link layer):

	(EFC transaction request subaction)
	c->t  req at 0xecc0'0000'0000
	t->c  ack_complete
	(EFC transaction response subaction)
	t->c  req at 0xecc0'8000'0000
	c->t  ack_complete

Link layer controllers which are *not* OHCI-1394 implementations may use
one or the other 1212/ 1394 transaction type in either of the two
transport protocols.  Furthermore, OHCI-1394 also allows split transaction
behavior to be configured for the range below 0xffff'0000'0000, but Linux'
firewire-ohci and older Linux' ohci1394 configure unified transaction
behavior, which is implemented by means of posted host bus writes by the
OHCI.  Lastly, some OHCI-1394 hardware allows addresses like the EFC range
to be covered by the physical response unit, but neither firewire-ohci nor
ohci1394 extend the OHCI physical response range over the EFC register
range.

Anyway; the use of split or unified transactions is immaterial to the
question of exclusive use versus shared use of these address ranges by the
application layer.


IEEE 1212
---------

The IEEE 1212 Control and Status Registers (CSR) Architecture for
Microcomputer buses defines the following address ranges within node
address space:

	Memory space,
	[0x0000'0000'0000...0xffff'e000'0000):
	"The name reflects a historical expectation that node resources
	located here exhibit behaviors usually associated with memory.
	That is, read and write transactions do not have side effects.
	In fact, any node resources may be located in this address space
	--- even registers with associated side effects."

That is, EFC uses Memory space.  (Particularly, it uses Memory space for
two vendor-defined registers with write side effects.)

	Private space,
	[0xffff'e000'0000...0xffff'f000'0000):
	"Allocated for vendor-dependent uses local to the node.  Some
	implementations may preclude the reuse of an internal address as
	an externally accessible bus address."

	Register space,
	[0xffff'f000'0000...0x1'0000'0000'0000):
	"Register space is allocated for the definition of registers that
	may have side effects when accessed; it includes standard CSR
	architecture registers, bus-dependent registers, configuration
	ROM, and units space."

	CSR architecture registers,
	[0xffff'f000'0000...0xffff'f000'0200):
	These are registers defined by IEEE 1212 itself.

	Bus-dependent registers,
	[0xffff'f000'0200...0xffff'f000'0400):
	These are registers defined by bus standards based on IEEE 1212,
	notably IEEE 1394.

	Configuration ROM,
	[0xffff'f000'0400...0xffff'f000'0800):
	This is a read-only register whose format is defined by IEEE 1212
	and whose contents are defined by IEEE 1212, by bus standards like
	IEEE 1394, and by unit architecture standards like SBP-2, RFC 2734,
	IEC 61883, AV/C specifications, and others.

	Units space,
	[0xffff'f000'0800...0x1'0000'0000'0000):
	"Allocated for cooperative, shared definition by the applicable
	bus standard or the organizations or vendors responsible for unit
	architectures."

That is, FCP uses Units space.

According to this, we can do anything we want within the EFC address range
(just take care that different applications do not confuse each other),
whereas we have to take higher-level specifications into account when
we deal with the FCP address range.


IEEE 1394
---------

IEEE 1394 High-Performance Serial Bus does not add any provisions for CSR
Architecture Memory space or Private space.  It only adds definitions
concerning all three sub-ranges of Register space.  IEEE 1394 explicitly
reserves [0xffff'f000'0900...0xffff'f000'0a00) for IEC 61883-1 plug
control registers and [0xffff'f000'0b00...0xffff'f000'0f00) for IEC
61883-1 FCP command and response registers.


IEC 61883-1
-----------

Among else this specification defines how FCP transactions are
encapsulated in IEEE 1212/ IEEE 1394 transactions, and how the headers of
FCP request and response frames look.  The fact that response headers
repeat certain parts of the request header, together with the IEEE 1394
transaction layer implementation (firewire-core) giving the
bus:generation:node tuple from which an FCP response frame originated,
allows firewire-core to hand out copies of each incoming FCP response
frame to all applications that registered themselves as listeners to
FCP_RESPONSE.  It is then the responsibility of the application to sort
out whether or not the FCP response belongs to any of the FCP requests
which this application sent out.  Such application programs can be
implemented in userspace or in kernelspace.  The firedtv DVB driver is an
example of the latter kind.

>From comments in your sources (added by patch 19/52 "fireworks: Add
transaction and some commands"), I guess that bytes 1...4 in EFC response
frames allow applications to match response frames with request frames.
If so, the implementation could be organized similarly to FCP:
firewire-core could allow multiple application programs (in kernelspace or
in userspace) to register for listening at
[0xecc0'8000'0000...0xecc0'8000'0200) and would give copies of all
incoming EFC response frames to all listeners.  It would then be the
responsibility of the listeners to sort out which of the responses are
theirs, and which to ignore.  When implemented correctly in those
applications, this matching of commands and responses would work with any
number of controller applications and with any number of target devices on
any number of 1394 buses attached to the host.

However, there are some more considerations:

  - This perhaps requires that none of the EFC controllers tell the EFC
    target to use an EFC_RESPONSE address other than the default,
    0xecc0'8000'0000.

  - How well do Fireworks devices deal with overlapping EFC transactions?
    In other words, may two or even more controller applications (e.g. one
    streaming driver in kernelspace and one mixer UI in userspace) operate
    independently, or do they have to coordinate certain actions?

  - In firewire-core, we could hardwire shared use of
    [0xecc0'8000'0000...0xecc0'8000'0200) just like we hardwired shared
    use of FCP_COMMAND and FCP_RESPONSE.  This assumes that no other
    application --- outside of Fireworks control applications --- attempts
    to use this address range.

    Or we could add an in-kernel API and kernel--userspace ABI which lets
    applications request shared listening to an address range (in contrast
    to the existing API/ ABI which lets applications register for
    exclusive listening to an address range).

    In the latter case, the userspace ABI could be either firewire-core's
    firewire-cdev interface, or it could be ALSA's hwdep interface.

    In the former case, firewire-cdev and/or hwdep could be used as well,
    although firewire-cdev would be the more natural choice.

I understood from Clemens' comments that he intended that mixer
applications should use hwdep only
  - to match ALSA hwdep nodes with firewire-cdev nodes,
  - to lock/ unlock streaming,
  - in the future:  to receive certain status information from the ALSA
    driver if that status is only available as in-band data from the
    isochronous data stream, or if that status is nowhere available
    because it is implicit status of write-only registers,
whereas the mixer applications are supposed to use firewire-cdev for all
their other dealings with the audio devices.  (Clemens and Jonathan,
correct me if I misunderstood or if I forgot other control and status I/O
that is only possible with direct cooperation by the ALSA driver.)
-- 
Stefan Richter
-=====-====- ---= ====-
http://arcgraph.de/sr/
